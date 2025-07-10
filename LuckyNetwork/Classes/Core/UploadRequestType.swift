//
//  UploadRequestType.swift
//  LuckyNetwork
//
//  Created by junky on 2024/10/22.
//

import Foundation
import Alamofire


public protocol UploadRequestType {
    
    associatedtype UploadResponseType: Codable&Sendable
    
    var session: Alamofire.Session { get }
    
    var url: Alamofire.URLConvertible { get }
    
    var method: Alamofire.HTTPMethod { get }
    
    var header: Alamofire.HTTPHeaders? { get }
    
    var interceptor: Alamofire.Interceptor? { get }
    
    var modifier: Alamofire.Session.RequestModifier? { get }
    
    var threshold: UInt64 { get }
}


public extension UploadRequestType {
    
    var session: Alamofire.Session { .default }
    
    var method: Alamofire.HTTPMethod { .post }
    
    var header: Alamofire.HTTPHeaders? { nil }
    
    var interceptor: Alamofire.Interceptor? { nil }
    
    var modifier: Alamofire.Session.RequestModifier? { nil }
    
    var threshold: UInt64 { MultipartFormData.encodingMemoryThreshold }
}


public extension UploadRequestType {
    
    func upload(data: Data, progress: Alamofire.Request.ProgressHandler?, compelete: @Sendable @escaping (DataResponse<UploadResponseType, AFError>) -> Void) {
        
        let req = session.upload(data, to: url, method: method, headers: header, interceptor: interceptor, requestModifier: modifier)
        
        if let progress = progress {
            req.uploadProgress(closure: progress)
        }
        req.responseDecodable(of: UploadResponseType.self, completionHandler: compelete)
    }
    
    
    func upload(multipartFormData: @escaping (MultipartFormData) -> Void, progress: Alamofire.Request.ProgressHandler?, compelete: @Sendable @escaping (DataResponse<UploadResponseType, AFError>) -> Void) {
        
        let req = session.upload(multipartFormData: multipartFormData, to: url, usingThreshold: threshold, method: method, headers: header, interceptor: interceptor, requestModifier: modifier)
        if let progress = progress {
            req.uploadProgress(closure: progress)
        }
        req.responseDecodable(of: UploadResponseType.self, completionHandler: compelete)
    }
    
    
    
    
    func upload(datas: [Data], name: String = "files", progress: Alamofire.Request.ProgressHandler?, compelete: @Sendable @escaping (DataResponse<UploadResponseType, AFError>) -> Void) {
        
        upload(multipartFormData: { mutData in
            datas.forEach{ mutData.append($0, withName: name) }
        }, progress: progress, compelete: compelete)
    }
    
    
    func upload(files: [URL], name: String = "files", progress: Alamofire.Request.ProgressHandler?, compelete: @Sendable @escaping (DataResponse<UploadResponseType, AFError>) -> Void) {
        
        upload(multipartFormData: { mutData in
            files.forEach{ mutData.append($0, withName: name) }
        }, progress: progress, compelete: compelete)
    }
    
    
    func upload(datas: [Data], name: String = "files", progress: Alamofire.Request.ProgressHandler?) async throws -> UploadResponseType {
        return try await withCheckedThrowingContinuation { continuation in
            upload(multipartFormData: { mutData in
                datas.forEach{ mutData.append($0, withName: name) }
            }, progress: progress) { response in
                switch response.result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
}

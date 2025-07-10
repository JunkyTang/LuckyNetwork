//
//  DownloadRequestType.swift
//  LuckyNetwork
//
//  Created by junky on 2024/10/22.
//

import Foundation
import Alamofire


public protocol DownloadRequestType {
    
    associatedtype DownloadParameterType: Codable&Sendable
    
    var session: Alamofire.Session { get }
    
    var url: Alamofire.URLConvertible { get }
    
    var method: Alamofire.HTTPMethod { get }
    
    var parameters: DownloadParameterType? { get }
    
    var encoder: Alamofire.ParameterEncoder { get }
    
    var header: Alamofire.HTTPHeaders? { get }
    
    var interceptor: Alamofire.Interceptor? { get }
    
    var modifier: Alamofire.Session.RequestModifier? { get }
    
    var destination: Alamofire.DownloadRequest.Destination? { get }
    
    func download(progress: Alamofire.Request.ProgressHandler?, compelete: @Sendable @escaping (AFDownloadResponse<URL?>) -> Void)
}

public extension DownloadRequestType {
    
    var session: Alamofire.Session { .default }
    
    var method: Alamofire.HTTPMethod { .get }
    
    var parameters: DownloadParameterType? { nil }
    
    var encoder: Alamofire.ParameterEncoder { URLEncodedFormParameterEncoder.default }
    
    var header: Alamofire.HTTPHeaders? { nil }
    
    var interceptor: Alamofire.Interceptor? { nil }
    
    var modifier: Alamofire.Session.RequestModifier? { nil }
    
    var destination: Alamofire.DownloadRequest.Destination? { nil }
    
    
}


public extension DownloadRequestType {
    
    
    func download(progress: Alamofire.Request.ProgressHandler?, compelete: @Sendable @escaping (AFDownloadResponse<URL?>) -> Void) {
        let req = session.download(url, method: method, parameters: parameters, encoder: encoder, headers: header, interceptor: interceptor, requestModifier: modifier, to: destination)
        if let progress = progress {
            req.downloadProgress(closure: progress)
        }
        req.response(completionHandler: compelete)
    }
    
    
    func download(progress: Alamofire.Request.ProgressHandler?) async throws -> URL? {
        
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<URL?, Error>) in
            let req = session.download(url, method: method, parameters: parameters, encoder: encoder, headers: header, interceptor: interceptor, requestModifier: modifier, to: destination)
            if let progress = progress {
                req.downloadProgress(closure: progress)
            }
            
            req.response { response in
                switch response.result {
                case .success(let url):
                    continuation.resume(returning: url)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        
    }
    
}

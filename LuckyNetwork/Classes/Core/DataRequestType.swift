//
//  DataRequestType.swift
//  LuckyNetwork
//
//  Created by junky on 2024/10/22.
//

import Foundation
import Alamofire


public protocol DataRequestType {
    
    associatedtype DataResponseType: Codable&Sendable
    associatedtype DataParameterType: Codable&Sendable
    
    var session: Alamofire.Session { get }
    
    var url: Alamofire.URLConvertible { get }
    
    var method: Alamofire.HTTPMethod { get }
    
    var parameters: DataParameterType? { get }
    
    var encoder: Alamofire.ParameterEncoder { get }
    
    var header: Alamofire.HTTPHeaders? { get }
    
    var interceptor: Alamofire.Interceptor? { get }
    
    var modifier: Alamofire.Session.RequestModifier? { get }
    
}

public extension DataRequestType {
    
    var session: Alamofire.Session { .default }
    
    var method: Alamofire.HTTPMethod { .get }
    
    var parameters: DataParameterType? { nil }
    
    var encoder: Alamofire.ParameterEncoder { URLEncodedFormParameterEncoder.default }
    
    var header: Alamofire.HTTPHeaders? { nil }
    
    var interceptor: Alamofire.Interceptor? { nil }
    
    var modifier: Alamofire.Session.RequestModifier? { nil }
    
}



public extension DataRequestType {
    
    @discardableResult
    func request(compelete: @Sendable @escaping (AFDataResponse<DataResponseType>) -> Void) -> Alamofire.DataRequest {
        session.request(url, method: method, parameters: parameters, encoder: encoder, headers: header, interceptor: interceptor, requestModifier: modifier)
            .responseDecodable(of: DataResponseType.self, completionHandler: compelete)
    }
    
    func request() async throws -> DataResponseType {
        return try await withCheckedThrowingContinuation { continuation in
            request { response in
                switch response.result {
                case .success(let success):
                    continuation.resume(returning: success)
                case .failure(let failure):
                    continuation.resume(throwing: failure)
                }
            }
        }
    }
    
}

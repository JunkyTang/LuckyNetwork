//
//  Monitor.swift
//  LuckyNetwork
//
//  Created by junky on 2024/10/26.
//

import Foundation
import Alamofire
import LuckyPropertyWrapper

public final class RecordMonitor: Alamofire.EventMonitor {
    
    public init() {}
    
    public func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        DispatchQueue.main.async {
            RecordStorage.prepend(response.record)
        }
    }
    
    public func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) where Value : Sendable {
        DispatchQueue.main.async {
            RecordStorage.prepend(response.record)
        }
    }
    
    public func request(_ request: DownloadRequest, didParseResponse response: DownloadResponse<URL?, AFError>) {
        DispatchQueue.main.async {
            RecordStorage.prepend(response.record)
        }
    }
    
    
}


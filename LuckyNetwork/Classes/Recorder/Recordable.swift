//
//  Recordable.swift
//  LuckyNetwork
//
//  Created by junky on 2024/10/26.
//

import Foundation
import Alamofire


protocol Recordable {
    var record: Record { get }
}

extension DataResponse: Recordable {
    
    var record: Record {
        return Record(method: request?.httpMethod, url: request?.url, code: response?.statusCode, content: debugDescription)
    }
}

extension DownloadResponse: Recordable {
    var record: Record {
        return Record(method: request?.httpMethod, url: request?.url, code: response?.statusCode, content: debugDescription)
    }
}

//
//  Record.swift
//  LuckyNetwork
//
//  Created by junky on 2024/10/26.
//

import Foundation
import Alamofire
import LuckyPropertyWrapper


public struct Record: Codable {
    
    public var method: String?
    public var url: URL?
    public var code: Int?
    
    public var content: String
    
    public init(method: String? = nil, url: URL? = nil, code: Int? = nil, content: String) {
        self.method = method
        self.url = url
        self.code = code
        self.content = content
    }
}









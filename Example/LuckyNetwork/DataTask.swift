//
//  DataTask.swift
//  LuckyNetWork_Example
//
//  Created by junky on 2024/10/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import LuckyNetwork


struct DataTask: DataRequestType {
    
    
    
    struct DataResponseType: Codable {
        var code: Int
        var message: String
        var data: [FontInfo]?
        
        
        struct FontInfo: Codable {
            var id: Int
            var name: String
            var media: FontMedia
        }
        
        struct FontMedia: Codable {
            var cover: URL?
            var files: URL?
        }
    }
    
    
    struct DataParameterType: Codable {
        var lang: String
    }
    
    var url: any Alamofire.URLConvertible {
        return "https://api.fichero.luckjingle.com" + "/api/apis/printing/typeface"
    }
    
    var parameters: DataParameterType?
    
    var session: Alamofire.Session { .current }
    

}

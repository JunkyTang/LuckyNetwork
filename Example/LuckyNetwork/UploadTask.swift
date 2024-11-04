//
//  UploadTask.swift
//  LuckyNetWork_Example
//
//  Created by junky on 2024/10/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import LuckyNetwork


struct UploadTask: UploadRequestType {

    struct UploadResponseType: Codable {
        var msg: String
        var code: Int
        var data: File?
        
        struct File: Codable {
            var url: URL?
        }
    }
    
    var url: any URLConvertible {
        return "https://api.fichero.luckjingle.com" + "/api/apis/common/upload/file_qiniu"
    }
    
    
    var session: Session {
        return .current
    }

}






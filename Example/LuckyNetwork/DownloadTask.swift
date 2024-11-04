//
//  DownloadTask.swift
//  LuckyNetWork_Example
//
//  Created by junky on 2024/10/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import LuckyNetwork


struct DownloadTask: DownloadRequestType {
    
    struct DownloadParameterType: Codable {}
    
    var url: any Alamofire.URLConvertible {
//        "https://api.gj.img.luckjingle.com/16705721911504073.ttf"
        "https://img0.baidu.com/it/u=2191392668,814349101&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1399"
    }
    
    
    var session: Alamofire.Session { .current }
    
    
    var destination: DownloadRequest.Destination? {
        return { url, resp in
            
            var target = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            target = target.appendingPathComponent("font", isDirectory: true)
            let name = url.lastPathComponent
            target = target.appendingPathComponent(name)
            print(target)
            return (target, [.removePreviousFile ,.createIntermediateDirectories])
        }
    }
    
    
    
    
    func download(progress: Alamofire.Request.ProgressHandler?, compelete: @Sendable @escaping (AFDownloadResponse<URL?>) -> Void) {
        if let downloadUrl = try? url.asURL(),
           let destInfo = destination?(downloadUrl, HTTPURLResponse())
        {
            let target = destInfo.0
            print(target)
            if FileManager.default.fileExists(atPath: target.path) {
                compelete(.init(request: nil, response: nil, fileURL: nil, resumeData: nil, metrics: nil, serializationDuration: 0, result: .success(target)))
                return
            }
        }
        let req = session.download(url, method: method, parameters: parameters, encoder: encoder, headers: header, interceptor: interceptor, requestModifier: modifier, to: destination)
        if let progress = progress {
            req.downloadProgress(closure: progress)
        }
        req.response(completionHandler: compelete)
    }
}

//
//  Session+.swift
//  LuckyNetWork_Example
//
//  Created by junky on 2024/10/26.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import LuckyNetwork

extension Alamofire.Session {
    
    static let current: Session = Session(eventMonitors: [RecordMonitor()])
}

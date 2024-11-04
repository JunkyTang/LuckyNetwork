//
//  RecordStorage.swift
//  LuckyNetwork
//
//  Created by junky on 2024/11/4.
//

import Foundation
import LuckyPropertyWrapper


@MainActor
public class RecordStorage {
    
    @UserDefaultsProperty(suitName: "com.lucky.network", key: "record.list", defaultValue: [])
    static var recordList: [Record]
    
    @CurrentValueSubjectProperty
    static var needRefresh: Void = ()

    static func prepend(_ record: Record) {
        
        var list = recordList
        list.insert(record, at: 0)
        list = Array(list.prefix(20))
        recordList = list
        needRefresh = ()
    }
    
    static func clean() {
        recordList = []
        needRefresh = ()
    }
}

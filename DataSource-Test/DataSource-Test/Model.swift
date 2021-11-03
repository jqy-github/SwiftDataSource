//
//  Model.swift
//  DataSource-Test
//
//  Created by JY on 2020/11/25.
//

import Foundation

class CellModel: NSObject {
    @objc var title : String?
    @objc var subTitle : String?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

class SectionModel: NSObject {
    @objc var title : String?
    @objc var footer : String?
    @objc var contents : [String]?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

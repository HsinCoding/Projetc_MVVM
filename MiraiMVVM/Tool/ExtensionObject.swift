//
//  ExtensionObject.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/11/28.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var doubleValue: Double {
        return  (self as NSString).doubleValue
    }
}

extension Double {
    var stringValue: String {
        return String(format:"%f", self as Double)
    }
}

extension Int {
    var stringValue: String {
        return String(format:"%@", self as Int)
    }
    
}

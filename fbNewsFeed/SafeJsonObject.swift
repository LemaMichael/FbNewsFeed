//
//  SafeJsonObject.swift
//  fbNewsFeed
//
//  Created by Michael Lema on 7/30/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit


class SafeJsonObject : NSObject {
    
    //: Made to prevent the application from crashing
    override func setValue(_ value: Any?, forKey key: String) {
        
        let selectorString = "set\(key.uppercased().characters.first!)\(String(key.characters.dropFirst())):"
        let selector = Selector(selectorString)
        
        if responds(to: selector) {
            super.setValue(value, forKey: key)
        }
    }
}

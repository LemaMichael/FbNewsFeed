//
//  Post.swift
//  fbNewsFeed
//
//  Created by Michael Lema on 7/29/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit


class Post : SafeJsonObject {
    var name: String?
    var statusText: String?
    var profileImageName: String?
    var statusImageName: String?
    
    //: Changed numLikes & numComments types to NSNumber for parsing purposes
    var numLikes: NSNumber?
    var numComments: NSNumber?
    
    var location: Location?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "location" {
            location = Location()
            location?.setValuesForKeys(value as! [String : Any])
        }
        else {
            super.setValue(value, forKey: key)
        }
    }
    
}



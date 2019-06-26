//
//  blockedUserObject.swift
//  tiatwpbnw
//
//  Created by David A on 9/4/18.
//  Copyright © 2018 David A. All rights reserved.
//

import Foundation


class blockedUserObject {
    var blockedUID:String = ""
    var blockedUsername:String = ""
    var blockedDate:CLong = 0

    
    
    
    
    
    //Normal Post
    init( BlockedUID:String,
     BlockedUsername:String,
     BlockedDate:CLong ) {
        self.blockedUID = BlockedUID
        self.blockedUsername = BlockedUsername
        self.blockedDate = BlockedDate
  
    }
    
    
    
    func toFBObject() -> Any {
        return [
            "blockedUID":blockedUID as AnyObject,
            "blockedUsername":blockedUsername as AnyObject,
            "blockedDate": blockedDate as AnyObject
        ]
        
    }
    
    
    
    
}

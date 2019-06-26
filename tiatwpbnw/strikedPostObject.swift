//
//  strikedPostObject.swift
//  tiatwpbnw
//
//  Created by David A on 8/5/18.
//  Copyright © 2018 David A. All rights reserved.
//

import Foundation
class strikedPostObject {
    var postRemoverPosition:String = ""
    var postRemovalReason:Int = 0
    var postRemoverID:String = ""

    
    var postObject:postObject?
    
    
    
    
    
    //Normal Post
    init( PostRemovalReason:Int ,
          PostRemovePosition:String ,
          PostRemoverID:String ,
          PostObject:postObject) {
        self.postRemovalReason = PostRemovalReason
        self.postObject = PostObject
        self.postRemoverPosition = PostRemovePosition
        self.postRemoverID = PostRemoverID


        
    }
    
   
    
    func toFBObject() -> Any {
        return [
            "postRemovalReason":postRemovalReason as AnyObject,
            "postRemoverPosition":postRemoverPosition as AnyObject,
            "postRemoverID":postRemoverID as AnyObject,
            "postObject": postObject!.toFBObject() as AnyObject] as Any
        
    }
    
    
    
    
}

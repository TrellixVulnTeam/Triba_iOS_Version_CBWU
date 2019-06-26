//
//  reportObject.swift
//  tiatwpbnw
//
//  Created by David A on 4/12/18.
//  Copyright © 2018 David A. All rights reserved.
//
//Also used for strike history
import Foundation
class reportObject {
    
    var postReportReason:Int = 0
    var postObject:postObject?
    var postReporterID:String?


    
  
    
    //Normal Post
    init( PostReportReason:Int ,
          PostObject:postObject,PostReporterID:String  ) {
    self.postReportReason = PostReportReason
    self.postObject = PostObject
    self.postReporterID = PostReporterID
    }
    
    func toFBObject() -> Any {
        return [
            "postReportReason":postReportReason as AnyObject,
            "postReporterID":postReporterID as AnyObject,
             "postObject": postObject!.toFBObject() as AnyObject] as Any
        

    }
    
    
    
    
}

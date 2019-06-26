//
//  postLocationsClass.swift
//  tiatwpbnw
//
//  Created by David A on 3/7/18.
//  Copyright © 2018 David A. All rights reserved.
//

import Foundation
class postLocationsClass {
    
    
    
    
    var box00:String = ""
    var box01:String = ""
    var box02:String = ""
    var box10:String = ""
    var box11:String = ""
    var box12:String = ""
    var box20:String = ""
    var box21:String = ""
    var box22:String = ""
    
    
    
    
    init( Box00:String, Box01:String,Box02:String,
          Box10:String,Box11:String,Box12:String,
          Box20:String,Box21:String,Box22:String
        ) {
        self.box00 = Box00
        self.box01 = Box01
        self.box02 = Box02
        self.box10 = Box10
        self.box11 = Box11
        self.box12 = Box12
        self.box20 = Box20
        self.box21 = Box21
        self.box22 = Box22
    }
    
    func initWithDict(aDict: [String: Any]) {
        
        
        self.box00 = aDict["box00"] as! String
        self.box01 = aDict["box01"] as! String
        self.box02 = aDict["box02"] as! String
        self.box10 = aDict["box10"] as! String
        self.box11 = aDict["box11"] as! String
        self.box12 = aDict["box12"] as! String
        self.box20 = aDict["box20"] as! String
        self.box21 = aDict["box21"] as! String
        self.box22 = aDict["box22"] as! String
    }
    func toFBObject() -> Any {
        return [  "box00":box00,
                  "box01":box01,
                  "box02":box02 ,
                  "box10":box10 ,
                  "box11":box11 ,
                  "box12":box12 ,
                  "box20":box20 ,
                  "box21":box21 ,
                  "box22":box22 ]as Any
    }
    
    
    
    
}

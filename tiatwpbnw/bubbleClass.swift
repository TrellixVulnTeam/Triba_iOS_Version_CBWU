//
//  bubbleClass.swift
//  tiatwpbnw
//
//  Created by David A on 3/10/18.
//  Copyright © 2018 David A. All rights reserved.
//

import Foundation
class bubbleClass {
    
    var bubbleName:String = ""
    var bubbleDescription:String = ""
    var bubbleID:String = ""
    var bubbleImageID:String = ""
    var bubbleActiveStatus:String = ""
    var bubbleLats:[Double] = []
    var bubbleLongs:[Double] = []
    var bubbleType:Int = 0
    var bubbleState:String = ""
    var bubbleCity:String = ""
    var bubbleBorough:String = ""
    
    
    init (BubbleID: String, BubbleName: String,BubbleState: String,BubbleCity: String,BubbleBorough: String, BubbleType: Int) {
        self.bubbleID = BubbleID
        self.bubbleName = BubbleName
        self.bubbleState = BubbleState
        self.bubbleCity = BubbleCity
        self.bubbleBorough = BubbleBorough
        self.bubbleType = BubbleType
        self.bubbleDescription = ""
        self.bubbleImageID = ""
        self.bubbleLats = []
        self.bubbleLongs = []
        self.bubbleActiveStatus = "ACTIVE"
        
    }
    
    
    init (BubbleName:String, BubbleDescription:String,BubbleID:String,
          BubbleImageID:String,BubbleLats:[Double],BubbleLongs:[Double],BubbleType: Int ) {
        self.bubbleName = BubbleName
        self.bubbleDescription = BubbleDescription
        self.bubbleID = BubbleID
        self.bubbleImageID = BubbleImageID
        self.bubbleLats = BubbleLats
        self.bubbleLongs = BubbleLongs
        self.bubbleActiveStatus = "ACTIVE"
        self.bubbleType = BubbleType
        self.bubbleState = ""
        self.bubbleCity = ""
        self.bubbleBorough = ""
        
    }
    
    
    func initNonGeoBubble( BubbleName:String, BubbleDescription:String,BubbleID:String,
                           BubbleImageID:String,BubbleLats:[Double],BubbleLongs:[Double]) {
        
        
        self.bubbleName = BubbleName
        self.bubbleDescription = BubbleDescription
        self.bubbleID = BubbleID
        self.bubbleImageID = BubbleImageID
        self.bubbleLats = BubbleLats
        self.bubbleLongs = BubbleLongs
        self.bubbleActiveStatus = "ACTIVE"
        self.bubbleType = 0
        self.bubbleState = ""
        self.bubbleCity = ""
        self.bubbleBorough = ""
    }
    
    
    
    func toFBObject() -> Any {
        return [  "bubbleName":bubbleName,
                  "bubbleDescription":bubbleDescription,
                  "bubbleID":bubbleID ,
                  "bubbleImageID":bubbleImageID ,
                  "bubbleLats":bubbleLats ,
                  "bubbleLongs":bubbleLongs ,
                  "bubbleActiveStatus":bubbleActiveStatus,
                  "bubbleType":bubbleType,
                  "bubbleState":bubbleState,
                  "bubbleCity":bubbleCity,
                  "bubbleBorough":bubbleBorough] as Any
    }
    
}

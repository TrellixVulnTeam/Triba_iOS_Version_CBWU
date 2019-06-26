//
//  postChatObject.swift
//  tiatwpbnw
//
//  Created by David A on 5/24/18.
//  Copyright © 2018 David A. All rights reserved.
//

import Foundation
class postChatObject{
    
    
    var postIsActive:Bool = true
    var postCreatorID:String = ""
    var postText:String = ""
    var postID:String = ""
    var postLat:Double = 0.0
    var postLong:Double = 0.0
    var postTime:CLong = 0
    var postTimeInverse:CLong = 0
    var postUserName:String = ""
    var postType:String = ""
    var postDescription:String = ""
    var creatorName:String = ""
    var ratingBlend:Int = 0
    var postVisibilityStartTime:CLong = 0
    var postVisibilityEndTime:CLong = 0
    var textCount: Int = 0
    var postLocations:postLocationsClass?
    var postSpecs:postSpecDetails?
    var postBranch1:String = "unavailableForSomeReason"
    var postBranch2:String = "unavailableForSomeReason"
    var postMediaLink:String = "none"
    //CHatVersionType MUST be the same type as the postVersionType
    var chatVersionType: Int = 1


    
    //Chat Post
    //postV1

    init( PostCreatorID:String ,
          PostText:String,
          PostID:String ,
          PostLat:Double ,
          PostLong:Double ,
          PostTime:CLong ,
          PostTimeInverse:CLong ,
          PostUserName:String ,
          PostType:String ,
          PostDESCRIPTION:String,
          CreatorName:String, PostLocations:postLocationsClass) {
        self.postCreatorID = PostCreatorID
        self.postText = PostText
        self.postID = PostID
        self.postLat = PostLat
        self.postLong = PostLong
        self.postTime = PostTime
        self.postTimeInverse = PostTimeInverse
        self.postUserName = PostUserName
        self.postType = PostType
        self.postDescription = PostDESCRIPTION
        self.creatorName = CreatorName
        self.postLocations = PostLocations
        
    }
    
    
    //Normal Post
    //postV1
    init( PostCreatorID:String ,
          PostText:String,
          PostID:String ,
          PostLat:Double ,
          PostLong:Double ,
          PostTime:CLong ,
          PostTimeInverse:CLong ,
          PostUserName:String ,
          PostType:String ,
          PostDESCRIPTION:String,
          CreatorName:String, PostLocations:postLocationsClass, RatingBlend:Int, PostSpecs:postSpecDetails, PostVisStart:CLong, PostVisEnd:CLong, TextCount:Int,Branch1:String, Branch2:String ) {
        self.postCreatorID = PostCreatorID
        self.postText = PostText
        self.postID = PostID
        self.postLat = PostLat
        self.postLong = PostLong
        self.postTime = PostTime
        self.postTimeInverse = PostTimeInverse
        self.postUserName = PostUserName
        self.postType = PostType
        self.postDescription = PostDESCRIPTION
        self.creatorName = CreatorName
        self.postLocations = PostLocations
        self.ratingBlend = RatingBlend
        self.postSpecs = PostSpecs
        self.postVisibilityStartTime = PostVisStart
        self.postVisibilityEndTime =  PostVisEnd
        self.textCount = TextCount
        self.postBranch1 = Branch1
        self.postBranch2 = Branch2
        
        
        
    }
    
    func toFBObject() -> Any {
        return [
            
            "postCreatorID":postCreatorID as AnyObject,
            "postText":postText as AnyObject,
            "postID":postID as AnyObject
            ,"postLat":postLat as AnyObject
            ,"postLong":postLong as AnyObject,
             "postTime":postTime as AnyObject,
             "postTimeInverse":postTimeInverse as AnyObject,
             "postUserName":postUserName as AnyObject,
             "postType":postType as AnyObject,
             "postDescription":postDescription as AnyObject,
             "creatorName":creatorName as AnyObject,
             "postLocations":postLocations?.toFBObject() as AnyObject,
             "ratingBlend":ratingBlend as AnyObject,
             "postVisibilityStartTime":postVisibilityStartTime as AnyObject,
             "postVisibilityEndTime":postVisibilityEndTime as AnyObject,
             "textCount":textCount as AnyObject,
             "postBranch1":postBranch1 as AnyObject,
             "postBranch2":postBranch2 as AnyObject,
             "postSpecs": postSpecs!.toFBObject() as AnyObject] as Any
        
        
        
    }
    
    
    
}

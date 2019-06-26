//
//  postObject.swift
//  tiatwpbnw
//
//  Created by David A on 4/15/18.
//  Copyright © 2018 David A. All rights reserved.
//

import Foundation
class postObject {
    
    var postWasFlagged:Bool = false
    var postCreatorID:String = ""
    var postHasBubbles:Bool = false
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
    var ratingBlendInverse:Int = 0
    var postVisibilityStartTime:CLong = 0
    var postVisibilityEndTime:CLong = 0
    var textCount: Int = 0
    var textCountInverse: Int = 0
    var postLocations:postLocationsClass?
    var postSpecs:postSpecDetails?
    var postBranch1:String = "unavailableForSomeReason"
    var postBranch2:String = "unavailableForSomeReason"
    var postVersionType:Int = 2
    var messageRanking:Int = 0
    var ratingRanking:Int = 0
    var postLocationString:String = ""
    var postEventStartTime:CLong = 0
    var postEventEndTime:CLong = 0
    var postTimeDetailsString:String = ""

    
    init(HEHE:Bool ) {
      self.postID = "UNAVAILABLE"
    }
    //Chat Post...a comment basically
    //postV1

    init( PostCreatorID:String ,
          PostText:String,
          PostID:String ,
          PostLat:Double ,
          PostLong:Double ,
          PostTime:CLong ,
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
    
    //Normal Post with flagged status
    //postV1

    init( PostCreatorID:String ,
          PostText:String,
          PostID:String ,
          PostLat:Double ,
          PostLong:Double ,
          PostTime:CLong ,
          PostUserName:String ,
          PostType:String ,
          PostDESCRIPTION:String,
          CreatorName:String, PostLocations:postLocationsClass, RatingBlend:Int, PostSpecs:postSpecDetails, PostVisStart:CLong, PostVisEnd:CLong, TextCount:Int,Branch1:String, Branch2:String, PostFlagStatus:Bool ) {
        self.postCreatorID = PostCreatorID
        self.postText = PostText
        self.postID = PostID
        self.postLat = PostLat
        self.postLong = PostLong
        self.postTime = PostTime
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
        self.postWasFlagged = PostFlagStatus
        
        
        
    }
    
    //Normal Post with versionType
    //
    
    init( PostCreatorID:String ,
          PostText:String,
          PostID:String ,
          PostLat:Double ,
          PostLong:Double ,
          PostTime:CLong ,
          PostUserName:String ,
          PostType:String ,
          PostDESCRIPTION:String,
          CreatorName:String, PostLocations:postLocationsClass, RatingBlend:Int, PostSpecs:postSpecDetails, PostVisStart:CLong, PostVisEnd:CLong, TextCount:Int,Branch1:String, Branch2:String, PostFlagStatus:Bool, PostVersionType:Int ) {
        self.postCreatorID = PostCreatorID
        self.postText = PostText
        self.postID = PostID
        self.postLat = PostLat
        self.postLong = PostLong
        self.postTime = PostTime
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
        self.postWasFlagged = PostFlagStatus
        self.postVersionType = PostVersionType
        
        
        
    }
    
    
    

    
    //v2
    init( PostCreatorID:String ,
          PostText:String,
          PostID:String ,
          PostLat:Double ,
          PostLong:Double ,
          PostTime:CLong ,
          PostUserName:String ,
          PostType:String ,
          PostDESCRIPTION:String,
          CreatorName:String, PostLocations:postLocationsClass, RatingBlend:Int, PostSpecs:postSpecDetails, PostVisStart:CLong, PostVisEnd:CLong, TextCount:Int,Branch1:String, Branch2:String, PostFlagStatus:Bool, PostVersionType:Int, PostLocationString:String, PostEventStartTime:CLong, PostEventEndTime:CLong, PostTimeDetailsString: String  ) {
        self.postCreatorID = PostCreatorID
        self.postText = PostText
        self.postID = PostID
        self.postLat = PostLat
        self.postLong = PostLong
        self.postTime = PostTime
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
        self.postWasFlagged = PostFlagStatus
        self.postVersionType = PostVersionType
        self.postLocationString = PostLocationString
        self.postEventStartTime = PostEventStartTime
        self.postEventEndTime = PostEventEndTime
        self.postTimeDetailsString  = PostTimeDetailsString

        
        
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
             "postVersionType":postVersionType as AnyObject,
             "postWasFlagged":postWasFlagged as AnyObject,
             "postSpecs": postSpecs!.toFBObject() as AnyObject,
             "postLocationString":postLocationString as AnyObject,
             "postEventStartTime":postEventStartTime as AnyObject,
             "postEventEndTime":postEventEndTime as AnyObject,
             "postTimeDetailsString":postTimeDetailsString as AnyObject] as Any
        
      

 

        
    }
    
   
    
}

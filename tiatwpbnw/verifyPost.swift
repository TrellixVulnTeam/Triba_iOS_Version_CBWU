//
//  verifyPost.swift
//  tiatwpbnw
//
//  Created by David A on 9/21/18.
//  Copyright © 2018 David A. All rights reserved.
//

import Foundation
class verifyPost{
    
    func verifyPost( dict: [String : AnyObject])->Bool{
        
        var boolValid = true;
        if(dict["postVersionType"] == nil){
            boolValid = false;      }
        else{
            // postLong = dict["postLong"] as! Double
            
            if dict["postVersionType"] is Int{
                //everything about the value works.
               var postVersionType = dict["postVersionType"] as! Int
                if(postVersionType == 1){
                     boolValid = postVersion1(dict: dict);
                    
                }
                else if(postVersionType == 2){
                   // boolValid = postVersion1(dict: dict);
                    
                    
                    boolValid = postVersion2(dict: dict);
                    
                    print("PASSED2")
                    print("PASSED2")
                    print("PASSED2")
                    print("PASSED2")
                    print("PASSED2")
                    print("PASSED2")
                    print(boolValid.description)
                    print("PASSED2")
                    print("PASSED2")
                    print("PASSED2")
                    print("PASSED2")

                    
                }
                else{
                    //running general post v1 to see if it can be shown as that
                    boolValid = postVersion1(dict: dict);
                }
                
                
            } else {
 boolValid = false;
                
            }
        }
        
        return boolValid;
        
    }
        
    func createPost( dict: [String : AnyObject])->postObject{
        
        
        
        var isValidPost:Bool = true

        
        
        
        var ISActive:Bool = true //
        var HAsBeenCleared:Bool = true
        var POstTime:CLong = 0
        var POstRemovalTime:CLong = 0
        
        
        var postID:String? = ""
        var postCreatorID:String? = ""
        var postText:String? = ""
        var postUserName:String? = ""
        var postType:String? = ""
        var postDescription:String? = ""
        var postTime:CLong? = 0
        var postTimeInverse:CLong? = 0
        var creatorName:String? = ""
        
        var loc00:String? = ""
        var loc01:String? = ""
        var loc02:String? = ""
        var loc10:String? = ""
        var loc11:String? = ""
        var loc12:String? = ""
        var loc20:String? = ""
        var loc21:String? = ""
        var loc22:String? = ""
        
        var POstVisStartTime:CLong? = 0
        var POstVisEndTime:CLong? = 0
        
        
        var postLat:Double? = 0.0
        var postLong:Double? = 0.0
        
        var ratingBlend:CLong? = 0
        var textCount:Int? = 0
        var POstRemovalReason:Int? = 0

        var postVersionType:Int? = 0
        var POstRemover:String? = ""
        
        var postBranch1:String? = ""
        var postBranch2:String? = ""
        
        var postWasFlagged:Bool = true
        
        postVersionType = dict["postVersionType"] as! Int
        
        var postLocationString:String? = ""
        var postEventStartTime:CLong? = 0
        var postEventEndTime:CLong? = 0
        
        var postTimeDetailsString:String? = ""


        
        if(postVersionType == 1){
        
        
        postID = dict["postID"] as! String
        postCreatorID = dict["postCreatorID"] as! String
        postText = dict["postText"] as! String
        postUserName = dict["postUserName"] as! String
        postType = dict["postType"] as! String
        postDescription = dict["postDescription"] as! String
        postTime = dict["postTime"] as! CLong
        postTimeInverse = dict["postTimeInverse"] as! CLong
        creatorName = dict["creatorName"] as! String
        let locDic = dict["postLocations"]  as! [String: Any]
        loc00 = locDic["box00"] as! String
        loc01 = locDic["box01"] as! String
        loc02 = locDic["box02"] as! String
        loc10 = locDic["box10"] as! String
        loc11 = locDic["box11"] as! String
        loc12 = locDic["box12"] as! String
        loc20 = locDic["box20"] as! String
        loc21 = locDic["box21"] as! String
        loc22 = locDic["box22"] as! String

        POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
        POstVisEndTime = dict["postVisibilityEndTime"] as! CLong
        postLat = dict["postLat"] as! Double
        postLong = dict["postLong"] as! Double

        ratingBlend = dict["ratingBlend"] as! CLong
        textCount = dict["textCount"] as! Int
        postBranch1 = dict["postBranch1"] as! String
        postBranch2 = dict["postBranch2"] as! String
        postWasFlagged = dict["postWasFlagged"] as! Bool
        let specDic = dict["postSpecs"]  as! [String: Any]
        ISActive = specDic["isActive"] as! Bool
        HAsBeenCleared = specDic["hasBeenCleared"] as! Bool
        POstTime = specDic["postTime"] as! CLong
        POstRemovalTime = specDic["postRemovalTime"] as! CLong
        POstRemover = specDic["postRemover"] as! String
        POstRemovalReason = specDic["postRemovalReason"] as! Int

        postVersionType = dict["postVersionType"] as! Int

        
        
        //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
        // self.myList.append(titleText! as! String)
        // self.postTypeList.append(postType as! String)
        //self.userIDList.append(postCreatorID as! String)
   
        let postLocations = postLocationsClass(Box00:loc00!, Box01:loc01!,Box02:loc02!,
                                               Box10:loc10!,Box11:loc11!,Box12:loc12!,
                                               Box20:loc20!,Box21:loc21!,Box22:loc22!)
        
        let postSpecs = postSpecDetails(IsActive:ISActive, HasBeenCleared:HAsBeenCleared,PostTime:POstTime,
                                        PostRemovalTime:POstRemovalTime, PostRemovalReason: POstRemovalReason!, PostRemover: POstRemover!)
        
        var postChat = postObject(PostCreatorID:postCreatorID!,
                                  PostText:postText!,
                                  PostID:postID! ,
                                  PostLat:postLat! ,
                                  PostLong:postLong! ,
                                  PostTime:postTime! ,
                                  PostUserName:postUserName! ,
                                  PostType:postType! ,
                                  PostDESCRIPTION:postDescription!,
                                  CreatorName:creatorName!, PostLocations: postLocations,RatingBlend:ratingBlend!, PostSpecs:postSpecs, PostVisStart:POstVisStartTime!, PostVisEnd:POstVisEndTime!, TextCount:textCount!,Branch1:postBranch1!, Branch2:postBranch2!, PostFlagStatus:postWasFlagged, PostVersionType: postVersionType!)
            return postChat

        }
        else if(postVersionType == 2){
            
            
            postID = dict["postID"] as! String
            postCreatorID = dict["postCreatorID"] as! String
            postText = dict["postText"] as! String
            postUserName = dict["postUserName"] as! String
            postType = dict["postType"] as! String
            postDescription = dict["postDescription"] as! String
            postTime = dict["postTime"] as! CLong
            postTimeInverse = dict["postTimeInverse"] as! CLong
            creatorName = dict["creatorName"] as! String
            let locDic = dict["postLocations"]  as! [String: Any]
            loc00 = locDic["box00"] as! String
            loc01 = locDic["box01"] as! String
            loc02 = locDic["box02"] as! String
            loc10 = locDic["box10"] as! String
            loc11 = locDic["box11"] as! String
            loc12 = locDic["box12"] as! String
            loc20 = locDic["box20"] as! String
            loc21 = locDic["box21"] as! String
            loc22 = locDic["box22"] as! String
            
            POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
            POstVisEndTime = dict["postVisibilityEndTime"] as! CLong
            postLat = dict["postLat"] as! Double
            postLong = dict["postLong"] as! Double
            
            ratingBlend = dict["ratingBlend"] as! CLong
            textCount = dict["textCount"] as! Int
            postBranch1 = dict["postBranch1"] as! String
            postBranch2 = dict["postBranch2"] as! String
            postWasFlagged = dict["postWasFlagged"] as! Bool
            let specDic = dict["postSpecs"]  as! [String: Any]
            ISActive = specDic["isActive"] as! Bool
            HAsBeenCleared = specDic["hasBeenCleared"] as! Bool
            POstTime = specDic["postTime"] as! CLong
            POstRemovalTime = specDic["postRemovalTime"] as! CLong
            POstRemover = specDic["postRemover"] as! String
            POstRemovalReason = specDic["postRemovalReason"] as! Int
            
            postVersionType = dict["postVersionType"] as! Int
            
            postLocationString = dict["postLocationString"] as! String
            postEventStartTime = dict["postEventStartTime"] as! CLong
            postEventEndTime = dict["postEventEndTime"] as! CLong

            postTimeDetailsString =  dict["postTimeDetailsString"] as! String
          
    
            //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
            // self.myList.append(titleText! as! String)
            // self.postTypeList.append(postType as! String)
            //self.userIDList.append(postCreatorID as! String)
            
            let postLocations = postLocationsClass(Box00:loc00!, Box01:loc01!,Box02:loc02!,
                                                   Box10:loc10!,Box11:loc11!,Box12:loc12!,
                                                   Box20:loc20!,Box21:loc21!,Box22:loc22!)
            
            let postSpecs = postSpecDetails(IsActive:ISActive, HasBeenCleared:HAsBeenCleared,PostTime:POstTime,
                                            PostRemovalTime:POstRemovalTime, PostRemovalReason: POstRemovalReason!, PostRemover: POstRemover!)
            
            var postChat = postObject(PostCreatorID:postCreatorID!,
                                      PostText:postText!,
                                      PostID:postID! ,
                                      PostLat:postLat! ,
                                      PostLong:postLong! ,
                                      PostTime:postTime! ,
                                      PostUserName:postUserName! ,
                                      PostType:postType! ,
                                      PostDESCRIPTION:postDescription!,
                                      CreatorName:creatorName!, PostLocations: postLocations,RatingBlend:ratingBlend!, PostSpecs:postSpecs, PostVisStart:POstVisStartTime!, PostVisEnd:POstVisEndTime!, TextCount:textCount!,Branch1:postBranch1!, Branch2:postBranch2!, PostFlagStatus:postWasFlagged, PostVersionType: postVersionType!, PostLocationString: postLocationString!, PostEventStartTime:postEventStartTime!, PostEventEndTime:postEventEndTime!,PostTimeDetailsString: postTimeDetailsString! )
            return postChat
            
        }
        else if(postVersionType ?? 0 > 1){
            
            
            postID = dict["postID"] as! String
            postCreatorID = dict["postCreatorID"] as! String
            postText = dict["postText"] as! String
            postUserName = dict["postUserName"] as! String
            postType = dict["postType"] as! String
            postDescription = dict["postDescription"] as! String
            postTime = dict["postTime"] as! CLong
            postTimeInverse = dict["postTimeInverse"] as! CLong
            creatorName = dict["creatorName"] as! String
            let locDic = dict["postLocations"]  as! [String: Any]
            loc00 = locDic["box00"] as! String
            loc01 = locDic["box01"] as! String
            loc02 = locDic["box02"] as! String
            loc10 = locDic["box10"] as! String
            loc11 = locDic["box11"] as! String
            loc12 = locDic["box12"] as! String
            loc20 = locDic["box20"] as! String
            loc21 = locDic["box21"] as! String
            loc22 = locDic["box22"] as! String
            
            POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
            POstVisEndTime = dict["postVisibilityEndTime"] as! CLong
            postLat = dict["postLat"] as! Double
            postLong = dict["postLong"] as! Double
            
            ratingBlend = dict["ratingBlend"] as! CLong
            textCount = dict["textCount"] as! Int
            postBranch1 = dict["postBranch1"] as! String
            postBranch2 = dict["postBranch2"] as! String
            postWasFlagged = dict["postWasFlagged"] as! Bool
            let specDic = dict["postSpecs"]  as! [String: Any]
            ISActive = specDic["isActive"] as! Bool
            HAsBeenCleared = specDic["hasBeenCleared"] as! Bool
            POstTime = specDic["postTime"] as! CLong
            POstRemovalTime = specDic["postRemovalTime"] as! CLong
            POstRemover = specDic["postRemover"] as! String
            POstRemovalReason = specDic["postRemovalReason"] as! Int
            
            postVersionType = dict["postVersionType"] as! Int
            
            
            
            //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
            // self.myList.append(titleText! as! String)
            // self.postTypeList.append(postType as! String)
            //self.userIDList.append(postCreatorID as! String)
            
            let postLocations = postLocationsClass(Box00:loc00!, Box01:loc01!,Box02:loc02!,
                                                   Box10:loc10!,Box11:loc11!,Box12:loc12!,
                                                   Box20:loc20!,Box21:loc21!,Box22:loc22!)
            
            let postSpecs = postSpecDetails(IsActive:ISActive, HasBeenCleared:HAsBeenCleared,PostTime:POstTime,
                                            PostRemovalTime:POstRemovalTime, PostRemovalReason: POstRemovalReason!, PostRemover: POstRemover!)
            
            var postChat = postObject(PostCreatorID:postCreatorID!,
                                      PostText:postText!,
                                      PostID:postID! ,
                                      PostLat:postLat! ,
                                      PostLong:postLong! ,
                                      PostTime:postTime! ,
                                      PostUserName:postUserName! ,
                                      PostType:postType! ,
                                      PostDESCRIPTION:postDescription!,
                                      CreatorName:creatorName!, PostLocations: postLocations,RatingBlend:ratingBlend!, PostSpecs:postSpecs, PostVisStart:POstVisStartTime!, PostVisEnd:POstVisEndTime!, TextCount:textCount!,Branch1:postBranch1!, Branch2:postBranch2!, PostFlagStatus:postWasFlagged, PostVersionType: postVersionType!)
            return postChat
            
        }
        
        
        
        var postChat = postObject(HEHE: true)
        return postChat
        
    }
    
    
    func postVersion1( dict: [String : AnyObject]) -> Bool {
        
        
        
        
        
        
        
        var ISActive:Bool = true
        var HAsBeenCleared:Bool = true
        var POstTime:CLong = 0
        var POstRemovalTime:CLong = 0
        
        
        var isValidPost:Bool = true
        var postID:String? = ""
        var postCreatorID:String? = ""
        var postText:String? = ""
        var postUserName:String? = ""
        var postType:String? = ""
        var postDescription:String? = ""
        var postTime:CLong? = 0
        var postTimeInverse:CLong? = 0
        var creatorName:String? = ""
        
        var loc00:String? = ""
        var loc01:String? = ""
        var loc02:String? = ""
        var loc10:String? = ""
        var loc11:String? = ""
        var loc12:String? = ""
        var loc20:String? = ""
        var loc21:String? = ""
        var loc22:String? = ""
        
        var POstVisStartTime:CLong? = 0
        var POstVisEndTime:CLong? = 0
        
        
        var postLat:Double? = 0.0
        var postLong:Double? = 0.0
        
        var ratingBlend:CLong? = 0
        var textCount:Int? = 0
        
        var POstRemovalReason:Int? = 0
        
        var postVersionType:Int? = 0
        
        var POstRemover:String? = ""
        
        var postBranch1:String? = ""
        var postBranch2:String? = ""
        
        var postWasFlagged:Bool = true
        
        
        
        
        if(dict["postID"] == nil){
            isValidPost = false
            print("1")
        }
        else{
            // postID = dict["postID"] as! String
            
            if dict["postID"] is String{
                //everything about the value works.
                postID = dict["postID"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postCreatorID"] == nil){
            isValidPost = false
            print("2")
            
        }
        else{
            //postCreatorID = dict["postCreatorID"] as! String
            
            if dict["postCreatorID"] is String{
                //everything about the value works.
                postCreatorID = dict["postCreatorID"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postText"] == nil){
            isValidPost = false
            print("3333")
            
        }
        else{
            //postText = dict["postText"] as! String
            
            if dict["postText"] is String{
                //everything about the value works.
                postText = dict["postText"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postUserName"] == nil){
            isValidPost = false
            print("4444")
            
        }
        else{
            //  postUserName = dict["postUserName"] as! String
            
            if dict["postUserName"] is String{
                //everything about the value works.
                postUserName = dict["postUserName"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postType"] == nil){
            isValidPost = false
            print("55555")
            
        }
        else{
            // postType = dict["postType"] as! String
            
            if dict["postType"] is String{
                //everything about the value works.
                postType = dict["postType"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postDescription"] == nil){
            isValidPost = false
            print("66666")
            
        }
        else{
            // postDescription = dict["postDescription"] as! String
            
            if dict["postDescription"] is String{
                //everything about the value works.
                postDescription = dict["postDescription"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postTime"] == nil){
            isValidPost = false
            print("77777")
            
        }
        else{
            // postTime = dict["postTime"] as! CLong
            
            if dict["postTime"] is CLong{
                //everything about the value works.
                postTime = dict["postTime"] as! CLong
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postTimeInverse"] == nil){
            isValidPost = false
            print("88888")
            
            
        }
        else{
            //postTimeInverse = dict["postTimeInverse"] as! CLong
            
            if dict["postTimeInverse"] is CLong{
                //everything about the value works.
                postTimeInverse = dict["postTimeInverse"] as! CLong
            } else {
                isValidPost = false
            }
        }
        
        if(dict["creatorName"] == nil){
            isValidPost = false
            print("99999")
            
        }
        else{
            //  creatorName = dict["creatorName"] as! String
            
            if dict["creatorName"] is String{
                //everything about the value works.
                creatorName = dict["creatorName"] as! String
            } else {
                isValidPost = false
            }
        }
        
        
        
        if(dict["postLocations"] == nil){
            isValidPost = false
            print("10000000")
            
        }
        else{
            
            
            if dict["postLocations"] is [String: Any]{
                //everything about the value works.
                let locDic = dict["postLocations"]  as! [String: Any]
                
                
                
                if(locDic["box00"] == nil){
                    isValidPost = false
                    
                }
                else{
                    // loc00 = locDic["box00"] as! String
                    
                    if locDic["box00"] is String{
                        //everything about the value works.
                        loc00 = locDic["box00"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE9")
                    }
                }
                
                if(locDic["box01"] == nil){
                    isValidPost = false
                }
                else{
                    //loc01 = locDic["box01"] as! String
                    
                    if locDic["box01"] is String{
                        //everything about the value works.
                        loc01 = locDic["box01"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE10")
                    }
                }
                
                if(locDic["box02"] == nil){
                    isValidPost = false
                }
                else{
                    // loc02 = locDic["box02"] as! String
                    
                    if locDic["box02"] is String{
                        //everything about the value works.
                        loc02 = locDic["box02"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE11")
                    }
                }
                
                if(locDic["box10"] == nil){
                    isValidPost = false
                }
                else{
                    //loc10 = locDic["box10"] as! String
                    
                    if locDic["box10"] is String{
                        //everything about the value works.
                        loc10 = locDic["box10"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE12")
                    }
                }
                
                if(locDic["box11"] == nil){
                    isValidPost = false
                }
                else{
                    // loc11 = locDic["box11"] as! String
                    
                    if locDic["box11"] is String{
                        //everything about the value works.
                        loc11 = locDic["box11"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE13")
                    }
                }
                
                if(locDic["box12"] == nil){
                    isValidPost = false
                }
                else{
                    // loc12 = locDic["box12"] as! String
                    
                    if locDic["box12"] is String{
                        //everything about the value works.
                        loc12 = locDic["box12"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE14")
                    }
                }
                
                if(locDic["box20"] == nil){
                    isValidPost = false
                }
                else{
                    // loc20 = locDic["box20"] as! String
                    
                    if locDic["box20"] is String{
                        //everything about the value works.
                        loc20 = locDic["box20"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE15")
                    }
                }
                
                if(locDic["box21"] == nil){
                    isValidPost = false
                }
                else{
                    //loc21 = locDic["box21"] as! String
                    
                    if locDic["box21"] is String{
                        //everything about the value works.
                        loc21 = locDic["box21"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE16")
                    }
                    
                }
                
                if(locDic["box22"] == nil){
                    isValidPost = false
                }
                else{
                    //loc22 = locDic["box22"] as! String
                    
                    if locDic["box22"] is String{
                        //everything about the value works.
                        loc22 = locDic["box22"] as! String
                        
                    } else {
                        
                        
                        isValidPost = false
                        print("HERRRREEE17")
                        
                        
                    }
                }
                
            } else {
                isValidPost = false
                
                print("locationOne")
                
            }
            
            
        }
        
        
        
        
        
        if(dict["postVisibilityStartTime"] == nil){
            isValidPost = false
        }
        else{
            
            if dict["postVisibilityStartTime"] is CLong{
                //everything about the value works.
                POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
            } else {
                isValidPost = false
            }
            
            //  POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
        }
        
        if(dict["postVisibilityEndTime"] == nil){
            isValidPost = false
        }
        else{
            //POstVisEndTime = dict["postVisibilityEndTime"] as! CLong
            
            if dict["postVisibilityEndTime"] is CLong{
                //everything about the value works.
                POstVisEndTime = dict["postVisibilityEndTime"] as! CLong
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postLat"] == nil){
            isValidPost = false
        }
        else{
            //postLat = dict["postLat"] as! Double
            
            if dict["postLat"] is Double{
                //everything about the value works.
                postLat = dict["postLat"] as! Double
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postLong"] == nil){
            isValidPost = false
        }
        else{
            // postLong = dict["postLong"] as! Double
            
            if dict["postLong"] is Double{
                //everything about the value works.
                postLong = dict["postLong"] as! Double
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postVersionType"] == nil){
            isValidPost = false
        }
        else{
            // postLong = dict["postLong"] as! Double
            
            if dict["postVersionType"] is Int{
                //everything about the value works.
                postVersionType = dict["postVersionType"] as! Int
            } else {
                isValidPost = false
            }
        }
        
        
        if(dict["ratingBlend"] == nil){
            isValidPost = false
        }
        else{
            //  ratingBlend = dict["ratingBlend"] as! CLong
            
            if dict["ratingBlend"] is CLong{
                //everything about the value works.
                ratingBlend = dict["ratingBlend"] as! CLong
            } else {
                isValidPost = false
            }
        }
        
        if(dict["textCount"] == nil){
            isValidPost = false
        }
        else{
            //textCount = dict["textCount"] as! Int
            
            if dict["textCount"] is Int{
                //everything about the value works.
                textCount = dict["textCount"] as! Int
            } else {
                isValidPost = false
            }
            
        }
        
        
        
        
        
        if(dict["postBranch1"] == nil){
            isValidPost = false
        }
        else{
            //postBranch1 = dict["postBranch1"] as! String
            
            if dict["postBranch1"] is String{
                //everything about the value works.
                postBranch1 = dict["postBranch1"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postBranch2"] == nil){
            isValidPost = false
        }
        else{
            //postBranch2 = dict["postBranch2"] as! String
            
            if dict["postBranch2"] is String{
                //everything about the value works.
                postBranch2 = dict["postBranch2"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postWasFlagged"] == nil){
            isValidPost = false
        }
        else{
            //postWasFlagged = dict["postWasFlagged"] as! Bool
            
            if dict["postWasFlagged"] is Bool{
                //everything about the value works.
                postWasFlagged = dict["postWasFlagged"] as! Bool
            } else {
                isValidPost = false
            }
        }
        
        
        
        if(dict["postSpecs"] != nil){
            
            
            
            
            
            if dict["postSpecs"] is [String: Any]{
                //everything about the value works.
                
                let specDic = dict["postSpecs"]  as! [String: Any]
                
                
                
                
                
                
                
                if(specDic["isActive"] != nil){
                    //ISActive = specDic["isActive"] as! Bool
                    
                    if specDic["isActive"] is Bool{
                        //everything about the value works.
                        ISActive = specDic["isActive"] as! Bool
                    } else {
                        isValidPost = false
                    }
                    
                }
                else{
                    isValidPost = false
                }
                
                if(specDic["hasBeenCleared"] != nil){
                    //HAsBeenCleared = specDic["hasBeenCleared"] as! Bool
                    
                    if specDic["hasBeenCleared"] is Bool{
                        //everything about the value works.
                        HAsBeenCleared = specDic["hasBeenCleared"] as! Bool
                    } else {
                        isValidPost = false
                    }
                    
                }
                else{
                    isValidPost = false
                }
                
                if(specDic["postTime"] != nil){
                    // POstTime = specDic["postTime"] as! CLong
                    
                    if specDic["postTime"] is CLong{
                        //everything about the value works.
                        POstTime = specDic["postTime"] as! CLong
                    } else {
                        isValidPost = false
                    }
                    
                }
                else{
                    isValidPost = false
                }
                
                if(specDic["postRemovalTime"] != nil){
                    // POstRemovalTime = specDic["postRemovalTime"] as! CLong
                    
                    if specDic["postRemovalTime"] is CLong{
                        //everything about the value works.
                        POstRemovalTime = specDic["postRemovalTime"] as! CLong
                    } else {
                        isValidPost = false
                    }
                    
                }
                else{
                    isValidPost = false
                }
                
                if(specDic["postRemovalReason"] != nil){
                    //POstRemovalReason = specDic["postRemovalReason"] as! Int
                    
                    if specDic["postRemovalReason"] is Int{
                        //everything about the value works.
                        POstRemovalReason = specDic["postRemovalReason"] as! Int
                    } else {
                        isValidPost = false
                    }
                    
                }
                else{
                    isValidPost = false
                }
                
                if(specDic["postRemover"] != nil){
                    // POstRemover = specDic["postRemover"] as! String
                    
                    if specDic["postRemover"] is String{
                        //everything about the value works.
                        POstRemover = specDic["postRemover"] as! String
                    } else {
                        isValidPost = false
                    }
                    
                }
                else{
                    isValidPost = false
                }
                
            }
            else {
                isValidPost = false
            }
            
            
        }
        else{
            
            isValidPost = false
            
        }
        
        
        
        //BLAHLHAHVG DB
        print(postText)
        print(postText)
        print(postText)
        print(postText)
        print(postText)
        print(postText)
        
        
        
        
        //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
        // self.myList.append(titleText! as! String)
        // self.postTypeList.append(postType as! String)
        //self.userIDList.append(postCreatorID as! String)
        
        
        if(!(postType == "STANDARDTEXTIOS" || postType == "STANDARDTEXTANDROID" || postType == "STANDARDTEXT") ){
            
            isValidPost = false
            
        }
        return isValidPost
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func postVersion2( dict: [String : AnyObject]) -> Bool {
        
        
        
        
        
        
        
        var ISActive:Bool = true
        var HAsBeenCleared:Bool = true
        var POstTime:CLong = 0
        var POstRemovalTime:CLong = 0
        
        
        var isValidPost:Bool = true
        var postID:String? = ""
        var postCreatorID:String? = ""
        var postText:String? = ""
        var postUserName:String? = ""
        var postType:String? = ""
        var postDescription:String? = ""
        var postTime:CLong? = 0
        var postTimeInverse:CLong? = 0
        var creatorName:String? = ""
        
        var loc00:String? = ""
        var loc01:String? = ""
        var loc02:String? = ""
        var loc10:String? = ""
        var loc11:String? = ""
        var loc12:String? = ""
        var loc20:String? = ""
        var loc21:String? = ""
        var loc22:String? = ""
        
        var POstVisStartTime:CLong? = 0
        var POstVisEndTime:CLong? = 0
        
        
        var postLat:Double? = 0.0
        var postLong:Double? = 0.0
        
        var ratingBlend:CLong? = 0
        var textCount:Int? = 0
        
        var POstRemovalReason:Int? = 0
        
        var postVersionType:Int? = 0
        
        var POstRemover:String? = ""
        
        var postBranch1:String? = ""
        var postBranch2:String? = ""
        
        var postLocationString:String = ""
        var postEventStartTime:CLong = 0
        var postEventEndTime:CLong = 0
        var postTimeDetailsString:String = ""

        
        
        
        var postWasFlagged:Bool = true
        
        
        
        
        if(dict["postID"] == nil){
            isValidPost = false
            print("1")
        }
        else{
            // postID = dict["postID"] as! String
            
            if dict["postID"] is String{
                //everything about the value works.
                postID = dict["postID"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postCreatorID"] == nil){
            isValidPost = false
            print("2")
            
        }
        else{
            //postCreatorID = dict["postCreatorID"] as! String
            
            if dict["postCreatorID"] is String{
                //everything about the value works.
                postCreatorID = dict["postCreatorID"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postText"] == nil){
            isValidPost = false
            print("3333")
            
        }
        else{
            //postText = dict["postText"] as! String
            
            if dict["postText"] is String{
                //everything about the value works.
                postText = dict["postText"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postUserName"] == nil){
            isValidPost = false
            print("4444")
            
        }
        else{
            //  postUserName = dict["postUserName"] as! String
            
            if dict["postUserName"] is String{
                //everything about the value works.
                postUserName = dict["postUserName"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postType"] == nil){
            isValidPost = false
            print("55555")
            
        }
        else{
            // postType = dict["postType"] as! String
            
            if dict["postType"] is String{
                //everything about the value works.
                postType = dict["postType"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postDescription"] == nil){
            isValidPost = false
            print("66666")
            
        }
        else{
            // postDescription = dict["postDescription"] as! String
            
            if dict["postDescription"] is String{
                //everything about the value works.
                postDescription = dict["postDescription"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postTime"] == nil){
            isValidPost = false
            print("77777")
            
        }
        else{
            // postTime = dict["postTime"] as! CLong
            
            if dict["postTime"] is CLong{
                //everything about the value works.
                postTime = dict["postTime"] as! CLong
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postTimeInverse"] == nil){
            isValidPost = false
            print("88888")
            
            
        }
        else{
            //postTimeInverse = dict["postTimeInverse"] as! CLong
            
            if dict["postTimeInverse"] is CLong{
                //everything about the value works.
                postTimeInverse = dict["postTimeInverse"] as! CLong
            } else {
                isValidPost = false
            }
        }
        
        if(dict["creatorName"] == nil){
            isValidPost = false
            print("99999")
            
        }
        else{
            //  creatorName = dict["creatorName"] as! String
            
            if dict["creatorName"] is String{
                //everything about the value works.
                creatorName = dict["creatorName"] as! String
            } else {
                isValidPost = false
            }
        }
        
        
        
        if(dict["postLocations"] == nil){
            isValidPost = false
            print("10000000")
            
        }
        else{
            
            
            if dict["postLocations"] is [String: Any]{
                //everything about the value works.
                let locDic = dict["postLocations"]  as! [String: Any]
                
                
                
                if(locDic["box00"] == nil){
                    isValidPost = false
                    
                }
                else{
                    // loc00 = locDic["box00"] as! String
                    
                    if locDic["box00"] is String{
                        //everything about the value works.
                        loc00 = locDic["box00"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE9")
                    }
                }
                
                if(locDic["box01"] == nil){
                    isValidPost = false
                }
                else{
                    //loc01 = locDic["box01"] as! String
                    
                    if locDic["box01"] is String{
                        //everything about the value works.
                        loc01 = locDic["box01"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE10")
                    }
                }
                
                if(locDic["box02"] == nil){
                    isValidPost = false
                }
                else{
                    // loc02 = locDic["box02"] as! String
                    
                    if locDic["box02"] is String{
                        //everything about the value works.
                        loc02 = locDic["box02"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE11")
                    }
                }
                
                if(locDic["box10"] == nil){
                    isValidPost = false
                }
                else{
                    //loc10 = locDic["box10"] as! String
                    
                    if locDic["box10"] is String{
                        //everything about the value works.
                        loc10 = locDic["box10"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE12")
                    }
                }
                
                if(locDic["box11"] == nil){
                    isValidPost = false
                }
                else{
                    // loc11 = locDic["box11"] as! String
                    
                    if locDic["box11"] is String{
                        //everything about the value works.
                        loc11 = locDic["box11"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE13")
                    }
                }
                
                if(locDic["box12"] == nil){
                    isValidPost = false
                }
                else{
                    // loc12 = locDic["box12"] as! String
                    
                    if locDic["box12"] is String{
                        //everything about the value works.
                        loc12 = locDic["box12"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE14")
                    }
                }
                
                if(locDic["box20"] == nil){
                    isValidPost = false
                }
                else{
                    // loc20 = locDic["box20"] as! String
                    
                    if locDic["box20"] is String{
                        //everything about the value works.
                        loc20 = locDic["box20"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE15")
                    }
                }
                
                if(locDic["box21"] == nil){
                    isValidPost = false
                }
                else{
                    //loc21 = locDic["box21"] as! String
                    
                    if locDic["box21"] is String{
                        //everything about the value works.
                        loc21 = locDic["box21"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE16")
                    }
                    
                }
                
                if(locDic["box22"] == nil){
                    isValidPost = false
                }
                else{
                    //loc22 = locDic["box22"] as! String
                    
                    if locDic["box22"] is String{
                        //everything about the value works.
                        loc22 = locDic["box22"] as! String
                        
                    } else {
                        
                        
                        isValidPost = false
                        print("HERRRREEE17")
                        
                        
                    }
                }
                
            } else {
                isValidPost = false
                
                print("locationOne")
                
            }
            
            
        }
        
        
        
        
        
        if(dict["postVisibilityStartTime"] == nil){
            isValidPost = false
        }
        else{
            
            if dict["postVisibilityStartTime"] is CLong{
                //everything about the value works.
                POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
            } else {
                isValidPost = false
            }
            
            //  POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
        }
        
        if(dict["postVisibilityEndTime"] == nil){
            isValidPost = false
        }
        else{
            //POstVisEndTime = dict["postVisibilityEndTime"] as! CLong
            
            if dict["postVisibilityEndTime"] is CLong{
                //everything about the value works.
                POstVisEndTime = dict["postVisibilityEndTime"] as! CLong
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postLat"] == nil){
            isValidPost = false
        }
        else{
            //postLat = dict["postLat"] as! Double
            
            if dict["postLat"] is Double{
                //everything about the value works.
                postLat = dict["postLat"] as! Double
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postLong"] == nil){
            isValidPost = false
        }
        else{
            // postLong = dict["postLong"] as! Double
            
            if dict["postLong"] is Double{
                //everything about the value works.
                postLong = dict["postLong"] as! Double
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postVersionType"] == nil){
            isValidPost = false
        }
        else{
            // postLong = dict["postLong"] as! Double
            
            if dict["postVersionType"] is Int{
                //everything about the value works.
                postVersionType = dict["postVersionType"] as! Int
            } else {
                isValidPost = false
            }
        }
        
        
        if(dict["ratingBlend"] == nil){
            isValidPost = false
        }
        else{
            //  ratingBlend = dict["ratingBlend"] as! CLong
            
            if dict["ratingBlend"] is CLong{
                //everything about the value works.
                ratingBlend = dict["ratingBlend"] as! CLong
            } else {
                isValidPost = false
            }
        }
        
        if(dict["textCount"] == nil){
            isValidPost = false
        }
        else{
            //textCount = dict["textCount"] as! Int
            
            if dict["textCount"] is Int{
                //everything about the value works.
                textCount = dict["textCount"] as! Int
            } else {
                isValidPost = false
            }
            
        }
        
        
        
        
        
        if(dict["postBranch1"] == nil){
            isValidPost = false
        }
        else{
            //postBranch1 = dict["postBranch1"] as! String
            
            if dict["postBranch1"] is String{
                //everything about the value works.
                postBranch1 = dict["postBranch1"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postBranch2"] == nil){
            isValidPost = false
        }
        else{
            //postBranch2 = dict["postBranch2"] as! String
            
            if dict["postBranch2"] is String{
                //everything about the value works.
                postBranch2 = dict["postBranch2"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postWasFlagged"] == nil){
            isValidPost = false
        }
        else{
            //postWasFlagged = dict["postWasFlagged"] as! Bool
            
            if dict["postWasFlagged"] is Bool{
                //everything about the value works.
                postWasFlagged = dict["postWasFlagged"] as! Bool
            } else {
                isValidPost = false
            }
        }
        
      
        
        if(dict["postLocationString"] == nil){
            isValidPost = false
        }
        else{
            //postWasFlagged = dict["postWasFlagged"] as! Bool
            
            if dict["postLocationString"] is String{
                //everything about the value works.
                postLocationString = dict["postLocationString"] as! String
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postEventStartTime"] == nil){
            isValidPost = false
        }
        else{
            //postWasFlagged = dict["postWasFlagged"] as! Bool
            
            if dict["postEventStartTime"] is CLong{
                //everything about the value works.
                postEventStartTime = dict["postEventStartTime"] as! CLong
            } else {
                isValidPost = false
            }
        }
        
        if(dict["postEventEndTime"] == nil){
            isValidPost = false
        }
        else{
            //postWasFlagged = dict["postWasFlagged"] as! Bool
            
            if dict["postEventEndTime"] is CLong{
                //everything about the value works.
                postEventEndTime = dict["postEventEndTime"] as! CLong
            } else {
                isValidPost = false
            }
        }
        
        
        
        
        
        if(dict["postTimeDetailsString"] == nil){
            isValidPost = false
        }
        else{
            //postWasFlagged = dict["postWasFlagged"] as! Bool
            
            if dict["postTimeDetailsString"] is String{
                //everything about the value works.
                postTimeDetailsString = dict["postTimeDetailsString"] as! String
            } else {
                isValidPost = false
            }
        }
        
        
        if(dict["postSpecs"] != nil){
            
            
            
            
            
            if dict["postSpecs"] is [String: Any]{
                //everything about the value works.
                
                let specDic = dict["postSpecs"]  as! [String: Any]
                
                
                
                
                
                
                
                if(specDic["isActive"] != nil){
                    //ISActive = specDic["isActive"] as! Bool
                    
                    if specDic["isActive"] is Bool{
                        //everything about the value works.
                        ISActive = specDic["isActive"] as! Bool
                    } else {
                        isValidPost = false
                    }
                    
                }
                else{
                    isValidPost = false
                }
                
                if(specDic["hasBeenCleared"] != nil){
                    //HAsBeenCleared = specDic["hasBeenCleared"] as! Bool
                    
                    if specDic["hasBeenCleared"] is Bool{
                        //everything about the value works.
                        HAsBeenCleared = specDic["hasBeenCleared"] as! Bool
                    } else {
                        isValidPost = false
                    }
                    
                }
                else{
                    isValidPost = false
                }
                
                if(specDic["postTime"] != nil){
                    // POstTime = specDic["postTime"] as! CLong
                    
                    if specDic["postTime"] is CLong{
                        //everything about the value works.
                        POstTime = specDic["postTime"] as! CLong
                    } else {
                        isValidPost = false
                    }
                    
                }
                else{
                    isValidPost = false
                }
                
                if(specDic["postRemovalTime"] != nil){
                    // POstRemovalTime = specDic["postRemovalTime"] as! CLong
                    
                    if specDic["postRemovalTime"] is CLong{
                        //everything about the value works.
                        POstRemovalTime = specDic["postRemovalTime"] as! CLong
                    } else {
                        isValidPost = false
                    }
                    
                }
                else{
                    isValidPost = false
                }
                
                if(specDic["postRemovalReason"] != nil){
                    //POstRemovalReason = specDic["postRemovalReason"] as! Int
                    
                    if specDic["postRemovalReason"] is Int{
                        //everything about the value works.
                        POstRemovalReason = specDic["postRemovalReason"] as! Int
                    } else {
                        isValidPost = false
                    }
                    
                }
                else{
                    isValidPost = false
                }
                
                if(specDic["postRemover"] != nil){
                    // POstRemover = specDic["postRemover"] as! String
                    
                    if specDic["postRemover"] is String{
                        //everything about the value works.
                        POstRemover = specDic["postRemover"] as! String
                    } else {
                        isValidPost = false
                    }
                    
                }
                else{
                    isValidPost = false
                }
                
            }
            else {
                isValidPost = false
            }
            
            
        }
        else{
            
            isValidPost = false
            
        }
        
        
        
        //BLAHLHAHVG DB
        print(postText)
        print(postText)
        print(postText)
        print(postText)
        print(postText)
        print(postText)
        
        
        
        
        //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
        // self.myList.append(titleText! as! String)
        // self.postTypeList.append(postType as! String)
        //self.userIDList.append(postCreatorID as! String)
        
        
        if(!(postType == "STANDARDTEXTIOS" || postType == "STANDARDTEXTANDROID" || postType == "STANDARDTEXT" || postType == "STANDARDDETAILEDPOST"
            || postType == "STANDARDDETAILEDPOSTIOS" || postType == "STANDARDDETAILEDPOSTANDROID") ){
            
            isValidPost = false
            
        }
        return isValidPost
        
        
        
        
        
        
    }
    
    
    
}

//
//  reportPostPOPOVERViewController.swift
//  tiatwpbnw
//
//  Created by David A on 4/1/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase
class reportPostPOPOVERViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var reportTypeList:[String] = ["A", "B", "C", "Just Sucks"]
    var passedObject:postObject?
    var ref:DatabaseReference?
    var uLat:Double = 200.0
    var uLong:Double = 200.0
    var postLong: Double!
    var postLat: Double!
    var timeZone:String!
    var userAbreivedLat:String!
    
    var userAccessLevel:String!
    
    @IBOutlet weak var viewPopup: UIView!
    var isModerator:Bool!

    @IBOutlet weak var lblRemoveOrReportFor: UILabel!
    
    @IBAction func btnReportPolitical(_ sender: Any) {
        
        
        if(isModerator == true){
            
          
            
            
            
            let refreshAlert = UIAlertController(title: "Remove Post", message: "reason: " + "political", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                var pID = self.passedObject?.postID
                var postSPecs = self.passedObject?.postSpecs
                postSPecs?.hasBeenCleared
                let currentTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
                
                print("hasBeenCleared: " + (postSPecs?.hasBeenCleared.description)!)
                print("postTime: " + (postSPecs?.postTime.description)!)
                print("postRemovalTime: " + currentTime.description)
                print("postRemovalReason: " + "political")
                
                
                let postSpecs:[String : AnyObject] = [
                    "isActive":false as AnyObject,
                    "hasBeenCleared":postSPecs?.hasBeenCleared as AnyObject,
                    "postTime":postSPecs?.postTime as AnyObject,
                    "postRemovalTime":currentTime as AnyObject,
                    "postRemovalReason":1 as AnyObject,
                    "postRemover":Auth.auth().currentUser?.uid as AnyObject,
                    ]
                
                
                let adminPostSpecs:[String : AnyObject] = [
                    "post": self.passedObject?.toFBObject() as AnyObject,
                    "postRemovalTime":currentTime as AnyObject,
                    "postRemovalReason":1 as AnyObject,
                    "postRemover":Auth.auth().currentUser?.uid as AnyObject,
                    "postCreatorID":self.passedObject?.postCreatorID as AnyObject,
                    
                    ]
                
                let strikedPostObject:[String : AnyObject] =  [
                    "postRemovalReason":1 as AnyObject,
                    "postRemoverPosition":"moderator" as AnyObject,
                    "postObject": self.passedObject!.toFBObject() as AnyObject,
                    "postRemoverID":Auth.auth().currentUser?.uid as AnyObject]
                
                
                self.ref?.child("userCreatedPosts").child((self.passedObject?.postCreatorID)!).child(pID!).child("postSpecs").setValue(postSpecs);
                self.ref?.child("reportedPostIndex").child(pID!).child("postStatus").setValue("REMOVED")
                
                
                self.ref?.child("strikedPostHistory").child((self.passedObject?.postCreatorID)!).child(pID!).setValue(strikedPostObject)
                
                self.ref?.child("Users").child((self.passedObject?.postCreatorID)!).child("showUserStrikeAlert").setValue(true)

                
                //This one goes to the user's admin history
                self.ref?.child("modHistory").child((Auth.auth().currentUser?.uid)!).child(pID!).setValue(adminPostSpecs);
                
                
                self.removeAnimate()
                
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            if(userAccessLevel == "ADMIN"){
                //Admin removing for a reason other than official rules

                refreshAlert.addAction(UIAlertAction(title: "ADMINREMOVE", style: .default, handler: { (action: UIAlertAction!) in
                    var pID = self.passedObject?.postID
                    var postSPecs = self.passedObject?.postSpecs
                    postSPecs?.hasBeenCleared
                    let currentTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
                    
                    print("hasBeenCleared: " + (postSPecs?.hasBeenCleared.description)!)
                    print("postTime: " + (postSPecs?.postTime.description)!)
                    print("postRemovalTime: " + currentTime.description)
                    print("postRemovalReason: " + "political")
                    
                    
                    let postSpecs:[String : AnyObject] = [
                        "isActive":false as AnyObject,
                        "hasBeenCleared":postSPecs?.hasBeenCleared as AnyObject,
                        "postTime":postSPecs?.postTime as AnyObject,
                        "postRemovalTime":currentTime as AnyObject,
                        "postRemovalReason":100 as AnyObject,
                        "postRemover":Auth.auth().currentUser?.uid as AnyObject,
                        ]
                    
                    
                    let adminPostSpecs:[String : AnyObject] = [
                        "post": self.passedObject?.toFBObject() as AnyObject,
                        "postRemovalTime":currentTime as AnyObject,
                        "postRemovalReason":100 as AnyObject,
                        "postRemover":Auth.auth().currentUser?.uid as AnyObject,
                        "postCreatorID":self.passedObject?.postCreatorID as AnyObject,
                        
                        ]
                    
                    let strikedPostObject:[String : AnyObject] =  [
                        "postRemovalReason":100 as AnyObject,
                        "postRemoverPosition":"moderator" as AnyObject,
                        "postObject": self.passedObject!.toFBObject() as AnyObject,
                        "postRemoverID":Auth.auth().currentUser?.uid as AnyObject]
                    
                    
                    self.ref?.child("userCreatedPosts").child((self.passedObject?.postCreatorID)!).child(pID!).child("postSpecs").setValue(postSpecs);
                    self.ref?.child("reportedPostIndex").child(pID!).child("postStatus").setValue("REMOVED")
                    
                    
                    //self.ref?.child("strikedPostHistory").child((self.passedObject?.postCreatorID)!).child(pID!).setValue(strikedPostObject)
                    
                    //self.ref?.child("Users").child((self.passedObject?.postCreatorID)!).child("showUserStrikeAlert").setValue(true)
                    
                    
                    //This one goes to the user's admin history
                    self.ref?.child("modHistory").child((Auth.auth().currentUser?.uid)!).child(pID!).setValue(adminPostSpecs);
                    
                    
                    self.removeAnimate()
                    
                    
                }))
                
                
            }

            
            
            self.present(refreshAlert, animated: true, completion: nil)
            
        
            
        }
        else{
            //            let reportPost = reportObject(PostReason:"political" ,

            let reportPost = reportObject(PostReportReason:1,
                                          PostObject:passedObject!, PostReporterID: (Auth.auth().currentUser?.uid)!)
            ref?.child("reportedPostIndex").child((passedObject?.postID)!).child("latestPost").setValue(reportPost.toFBObject())
            
            // ref?.child("reportedPostIndex").child((passedObject?.postID)!).child("testToBEDeleted").setValue(reportTypeList[indexPath.row])
            
            removeAnimate()
        }
        
        
        
        
        
        
        
        
    }
    @IBAction func btnReportBullying(_ sender: Any) {
        
        if(isModerator == true){
            
            
            
            
            let refreshAlert = UIAlertController(title: "Remove Post", message: "reason: " + "political", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                var pID = self.passedObject?.postID
                var postSPecs = self.passedObject?.postSpecs
                postSPecs?.hasBeenCleared
                let currentTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
                
                print("hasBeenCleared: " + (postSPecs?.hasBeenCleared.description)!)
                print("postTime: " + (postSPecs?.postTime.description)!)
                print("postRemovalTime: " + currentTime.description)
                print("postRemovalReason: " + "bullying")
                
                
                let postSpecs:[String : AnyObject] = [
                    "isActive":false as AnyObject,
                    "hasBeenCleared":postSPecs?.hasBeenCleared as AnyObject,
                    "postTime":postSPecs?.postTime as AnyObject,
                    "postRemovalTime":currentTime as AnyObject,
                    "postRemovalReason":2 as AnyObject,
                    "postRemover":Auth.auth().currentUser?.uid as AnyObject
                    ]
                
                
                let adminPostSpecs:[String : AnyObject] = [
                    "post": self.passedObject?.toFBObject() as AnyObject,
                    "postRemovalTime":currentTime as AnyObject,
                    "postRemovalReason":2 as AnyObject,
                    "postRemover":Auth.auth().currentUser?.uid as AnyObject,
                    "postCreatorID":self.passedObject?.postCreatorID as AnyObject
                    
                    ]
                
                
                let strikedPostObject:[String : AnyObject] =  [
                    "postRemovalReason":2 as AnyObject,
                    "postRemoverPosition":"moderator" as AnyObject,
                    "postObject": self.passedObject!.toFBObject() as AnyObject,
                    "postRemoverID":Auth.auth().currentUser?.uid as AnyObject]
                self.ref?.child("userCreatedPosts").child((self.passedObject?.postCreatorID)!).child(pID!).child("postSpecs").setValue(postSpecs);
                self.ref?.child("reportedPostIndex").child(pID!).child("postStatus").setValue("REMOVED")
                self.ref?.child("strikedPostHistory").child((self.passedObject?.postCreatorID)!).child(pID!).setValue(strikedPostObject)
                
                self.ref?.child("Users").child((self.passedObject?.postCreatorID)!).child("showUserStrikeAlert").setValue(true)


                //This one goes to the user's admin history
                self.ref?.child("modHistory").child((Auth.auth().currentUser?.uid)!).child(pID!).setValue(adminPostSpecs);
                
                
                self.removeAnimate()
                
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            
            
            if(userAccessLevel == "ADMIN"){
            //Admin removing for a reason other than official rules
                refreshAlert.addAction(UIAlertAction(title: "ADMINREMOVE", style: .default, handler: { (action: UIAlertAction!) in
                    var pID = self.passedObject?.postID
                    var postSPecs = self.passedObject?.postSpecs
                    postSPecs?.hasBeenCleared
                    let currentTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
                    
                    print("hasBeenCleared: " + (postSPecs?.hasBeenCleared.description)!)
                    print("postTime: " + (postSPecs?.postTime.description)!)
                    print("postRemovalTime: " + currentTime.description)
                    print("postRemovalReason: " + "bullying")
                    
                    
                    let postSpecs:[String : AnyObject] = [
                        "isActive":false as AnyObject,
                        "hasBeenCleared":postSPecs?.hasBeenCleared as AnyObject,
                        "postTime":postSPecs?.postTime as AnyObject,
                        "postRemovalTime":currentTime as AnyObject,
                        "postRemovalReason":100 as AnyObject,
                        "postRemover":Auth.auth().currentUser?.uid as AnyObject
                    ]
                    
                    
                    let adminPostSpecs:[String : AnyObject] = [
                        "post": self.passedObject?.toFBObject() as AnyObject,
                        "postRemovalTime":currentTime as AnyObject,
                        "postRemovalReason":100 as AnyObject,
                        "postRemover":Auth.auth().currentUser?.uid as AnyObject,
                        "postCreatorID":self.passedObject?.postCreatorID as AnyObject
                        
                    ]
                    
                    
                    let strikedPostObject:[String : AnyObject] =  [
                        "postRemovalReason":100 as AnyObject,
                        "postRemoverPosition":"moderator" as AnyObject,
                        "postObject": self.passedObject!.toFBObject() as AnyObject,
                        "postRemoverID":Auth.auth().currentUser?.uid as AnyObject]
                    self.ref?.child("userCreatedPosts").child((self.passedObject?.postCreatorID)!).child(pID!).child("postSpecs").setValue(postSpecs);
                    self.ref?.child("reportedPostIndex").child(pID!).child("postStatus").setValue("REMOVED")
                    //self.ref?.child("strikedPostHistory").child((self.passedObject?.postCreatorID)!).child(pID!).setValue(strikedPostObject)
                    
                    //self.ref?.child("Users").child((self.passedObject?.postCreatorID)!).child("showUserStrikeAlert").setValue(true)
                    
                    
                    //This one goes to the user's admin history
                    self.ref?.child("modHistory").child((Auth.auth().currentUser?.uid)!).child(pID!).setValue(adminPostSpecs);
                    
                    
                    self.removeAnimate()
                    
                    
                }))
            
            
            }
            self.present(refreshAlert, animated: true, completion: nil)
            
            
            
        }
        else{
            
            let reportPost = reportObject(PostReportReason:2,
                                          PostObject:passedObject!, PostReporterID: (Auth.auth().currentUser?.uid)!)
            ref?.child("reportedPostIndex").child((passedObject?.postID)!).child("latestPost").setValue(reportPost.toFBObject())
            
            // ref?.child("reportedPostIndex").child((passedObject?.postID)!).child("testToBEDeleted").setValue(reportTypeList[indexPath.row])
            
            removeAnimate()
        }
        
    }
    
    @IBOutlet weak var txtPostText: UILabel!
    

    @IBAction func btnExit(_ sender: Any) {
        removeAnimate()
    }
    @IBOutlet weak var collectionReportTypes: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)

showAnimate()
        txtPostText.text = passedObject?.postText
        
        viewPopup.layer.cornerRadius = 12
        viewPopup.clipsToBounds = true
        viewPopup.layer.borderWidth = 2
        viewPopup.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)

        
        
        if let uAllowedAccessLevel = UserDefaults.standard.object(forKey: "userAccessLevel") as? String{
            userAccessLevel = uAllowedAccessLevel
        }
        
        
        
  
        
        if((locationVariables.userLong != nil) && (locationVariables.userLat != nil)){
            
            uLat =  locationVariables.userLat
            uLong = locationVariables.userLong
        }
        else{
            if let userLat = UserDefaults.standard.object(forKey: "userLat") as? Double{
                uLat = userLat
            }
            if let userLong = UserDefaults.standard.object(forKey: "userLong") as? Double{
                uLong = userLong
            }
        }
        
        
        
        if(userAccessLevel == "NORMAL"){
        
            isModerator = false
        }
        else if (userAccessLevel == "MODLEVELOFFERED"){
            isModerator = false
        }
        else if(userAccessLevel == "LOCALMODERATOR"){
            isModerator = true
            lblRemoveOrReportFor.text = "Remove For:"
            
        }
        else if(userAccessLevel == "NORMALREJECTED"){
            isModerator = false
            
        }
        else if(userAccessLevel == "ADMIN"){
            isModerator = true
            
        }
            
        else{
            isModerator = false
        }
        
        
        
        if(uLat != 200.0 && uLong != 200.0){
            //Full, unedited latitude and longitude
            
          
            
            
            //postLat and postLong are used for the location boxes
            postLat = Double(floor(100*uLat)/100)
            postLong = Double(floor(100*uLong)/100)
            
            
            print(TimeZone.current.abbreviation()! + " boooya " + postLong.description)
            
            let postLongRoundedToNearestTen = 10 * Int((postLat / 10.0).rounded())

            
            let box11 = String(round(Double(postLongRoundedToNearestTen)))
            

            let bo02new = box11.replacingOccurrences(of: ".", with: "|", options: .literal, range: nil)
            print(bo02new)
            
         userAbreivedLat = bo02new

            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return reportTypeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:reportPostCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "reportPostCollectionViewCell", for: indexPath) as! reportPostCollectionViewCell
        
        cell.txtReportType.text = reportTypeList[indexPath.row]
   
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    
      
            let cell:reportPostCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "reportPostCollectionViewCell", for: indexPath) as! reportPostCollectionViewCell
        
        print(userAbreivedLat)
        print(TimeZone.current.abbreviation()!)

   
/*
        
        var reportPost = reportObject  ( PostCreatorID:(passedObject?.postCreatorID)! ,
                                         PostText:(passedObject?.postText)!,
                                         PostID:(passedObject?.postID)! ,
                                         PostLat:(passedObject?.postLat)! ,
                                         PostLong:(passedObject?.postLong)! ,
                                         PostTime:(passedObject?.postTime)! ,
                                         PostUserName:(passedObject?.postUserName)! ,
                                         PostType:(passedObject?.postType)! ,
                                         PostDESCRIPTION:(passedObject?.postDescription)!,
                                         CreatorName:(passedObject?.creatorName)!, PostLocations:(passedObject?.postLocations)!, RatingBlend:(passedObject?.ratingBlend)!, PostSpecs:(passedObject?.postSpecs)!, PostVisStart:(passedObject?.postVisibilityStartTime)!, PostVisEnd:(passedObject?.postVisibilityEndTime)!, TextCount:(passedObject?.textCount)!,Branch1:(passedObject?.postBranch1)!, Branch2:(passedObject?.postBranch2)!, Branch3:reportTypeList[indexPath.row] )
        
        */
        
        
       /* ref?.child("reportedPost").child(TimeZone.current.abbreviation()!).child(userAbreivedLat).child(reportTypeList[indexPath.row]).child((passedObject?.postID)!).setValue(reportPost.toFBObject());
        ref?.child("reportedPostsReporters").child((passedObject?.postID)!).child((Auth.auth().currentUser?.uid)!).setValue(reportTypeList[indexPath.row])
        
           */
        
        if(isModerator == true){
            
            
            
            
            let refreshAlert = UIAlertController(title: "Remove Post", message: "reason: " + self.reportTypeList[indexPath.row], preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                var pID = self.passedObject?.postID
                var postSPecs = self.passedObject?.postSpecs
                postSPecs?.hasBeenCleared
                let currentTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
                
                print("hasBeenCleared: " + (postSPecs?.hasBeenCleared.description)!)
                print("postTime: " + (postSPecs?.postTime.description)!)
                print("postRemovalTime: " + currentTime.description)
                print("postRemovalReason: " + self.reportTypeList[indexPath.row])
                
                
                let postSpecs:[String : AnyObject] = [
                    "isActive":false as AnyObject,
                    "hasBeenCleared":postSPecs?.hasBeenCleared as AnyObject,
                    "postTime":postSPecs?.postTime as AnyObject,
                    "postRemovalTime":currentTime as AnyObject,
                    "postRemovalReason":self.reportTypeList[indexPath.row] as AnyObject,
                    "postRemover":Auth.auth().currentUser?.uid as AnyObject,
                    ]
                
                
                let adminPostSpecs:[String : AnyObject] = [
                    "post": self.passedObject?.toFBObject() as AnyObject,
                    "postRemovalTime":currentTime as AnyObject,
                    "postRemovalReason":self.reportTypeList[indexPath.row] as AnyObject,
                    "postRemover":Auth.auth().currentUser?.uid as AnyObject,
                    "postCreatorID":self.passedObject?.postCreatorID as AnyObject,
                    
                    ]
               
                
               
                self.ref?.child("userCreatedPosts").child((self.passedObject?.postCreatorID)!).child(pID!).child("postSpecs").setValue(postSpecs);
                self.ref?.child("reportedPostIndex").child(pID!).child("postStatus").setValue("REMOVED")
                
                //This one goes to the user's admin history
                self.ref?.child("modHistory").child((Auth.auth().currentUser?.uid)!).child(pID!).setValue(adminPostSpecs);
                
                
                self.removeAnimate()
                
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            
            self.present(refreshAlert, animated: true, completion: nil)
            
            
            
        }
        
       
        
   
        
        
       //  User Admin
       
         
    

        
        return true
    }
    
    
    
  
    
    
    
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        
        self.dismiss(animated: true, completion: nil)

        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    

}

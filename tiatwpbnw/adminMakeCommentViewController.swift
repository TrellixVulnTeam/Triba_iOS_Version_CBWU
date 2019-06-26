//
//  adminMakeCommentViewController.swift
//  tiatwpbnw
//
//  Created by David A on 8/27/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase


class adminMakeCommentViewController: UIViewController {
    @IBAction func btnPost(_ sender: Any) {
        
  
        if( self.txtPost.text?.isEmpty)!{
            
            let alert = UIAlertController(title: "", message: "Enter text", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
                // self.canvas.image = nil
            }
            
            alert.addAction(okAction)
            present(alert, animated: true, completion:nil)
            
        }
     
            
        else{
            
            
            let postTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
            
            let post1Ref = ref?.childByAutoId()
            let postID = (post1Ref?.key)!
            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "postCreatorID":"ADMINPOSTACCOUNT" as AnyObject,
                "postText":txtPost.text as AnyObject,
                "postID":postID as AnyObject
                ,"postLat":latt as AnyObject
                ,"postLong":longg as AnyObject,
                 "postTime":postTime as AnyObject,
                 "postTimeInverse":-postTime as AnyObject,
                 "postUserName":txtUsername.text as AnyObject,
                 "postType":"CHATCOMMENT_IOS" as AnyObject,
                 "postDescription":"NONE" as AnyObject,
                 "creatorName":"ADMINPOSTACCOUNT" as AnyObject,
                 "ratingBlend":0 as AnyObject,
                 "postLocations":passedObject!.postLocations?.toFBObject() as AnyObject,
                 "postVisibilityStartTime":0 as AnyObject,
                 "postVisibilityEndTime":0 as AnyObject,
                 "messageRanking":0 as AnyObject,
                 "ratingRanking":0 as AnyObject,
                 "postIsActive":true as AnyObject,
                 "postSpecs": passedObject?.postSpecs?.toFBObject() as AnyObject,
                 "originalAuthorID":passedObject?.postCreatorID as AnyObject,
                 "postWasFlagged":false as AnyObject,
                 "originalPostID":passedObject?.postID as AnyObject,
                 "chatVersionType":1 as AnyObject
                
                
                
            ]
            
            self.view.endEditing(true);
            
            //ref?.child("b").childByAutoId().setValue("yo")
            txtPost.text = ""
            
            
            
            
            // ref?.child("Users").child((passedObject?.postCreatorID)!).child("POSTS").child((passedObject?.postID)!).child("CHATS").child(postID).setValue(post)
            ref?.child("Chats").child((passedObject?.postCreatorID)!).child((passedObject?.postID)!).child(postID).setValue(post)
            ref?.child("username_lookup").child(txtUsername.text!).setValue("ADMINPOSTACCOUNT")

            // self.collectionTexts.reloadData()
            
            self.postDelegate?.reloadChatCollectionview()
            
            removeAnimate()
            
            
        }
        
    }
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPost: UITextView!
    
    
    var fullLat: Double!
    var fullLong: Double!
    //lat and long used to create location boxes
    var postLong: Double!
    var postLat: Double!
    var postID:String!
    var univName:String!
    var creDate:String = ""
    var creNum:Int = 0
    var eventTypeNum = 0
    var userName: String!
    var userFullName = ""
    var userID = ""
    
    var postType = "standard"
    var passedObject:postObject?
    var latt: Double!
    var longg: Double!
    
    var postDelegate:chatCustomDelegate?
    
    
    var handle: DatabaseHandle?
    var ref:DatabaseReference?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        ref = Database.database().reference()
        
        
      
      
        latt = passedObject?.postLat
        
        longg = passedObject?.postLong

        
        txtUsername.becomeFirstResponder()
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    
    func removeAnimate()
    {
        
        self.dismiss(animated: true, completion: nil)
        
        
        
    }

}

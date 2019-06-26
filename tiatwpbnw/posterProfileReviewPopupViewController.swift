//
//  posterProfileReviewPopupViewController.swift
//  tiatwpbnw
//
//  Created by David A on 5/24/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase

class posterProfileReviewPopupViewController: UIViewController {
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblUserPost: UILabel!
    var ref:DatabaseReference?
   var passedSender : UIButton?
    var chatDelegate:chatCustomDelegate?

    @IBOutlet weak var popupView: UIView!
    @IBAction func btnRemovePost(_ sender: Any) {
        
        
        
        let refreshAlert = UIAlertController(title: "Remove Post?", message: " ", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.ref?.child("Chats").child((self.passedObject?.postCreatorID)!).child((self.passedObject?.postID)!).child((self.chatObject?.postID)!).child("postIsActive").setValue(false)
            self.removeAnimate()

            self.chatDelegate?.removePost(sender: self.passedSender!)
            
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        self.present(refreshAlert, animated: true, completion: nil)
        
        
        self.removeAnimate()

    }
    @IBAction func btnBanUser(_ sender: Any) {
        
        //Add to ban list
        
        ref?.child("ChatBanList").child((passedObject?.postCreatorID)!).child((passedObject?.postID)!).child(posterID!).setValue(true)
        
        
        //Add ban update to chat
        let postTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
        
        let post1Ref = ref?.childByAutoId()
        let postID = "P"+(post1Ref?.key)!
        
        
        let post:[String : AnyObject] = [
            //"eventTitle":txtEventName.text! as AnyObject,
            "postCreatorID":"" as AnyObject,
            "postText":posterName! + " was banned from this chat" as AnyObject,
            "postID":postID as AnyObject
            ,"postLat":0 as AnyObject
            ,"postLong":0 as AnyObject,
             "postTime":postTime as AnyObject,
             "postTimeInverse":-postTime as AnyObject,
             "postUserName":"chatAdmin" as AnyObject,
             "postType":"CHATBANUPDATE" as AnyObject,
             "postDescription":"NONE" as AnyObject,
             "creatorName":Auth.auth().currentUser?.displayName! as AnyObject,
             "ratingBlend":0 as AnyObject,
             "postLocations":passedObject!.postLocations?.toFBObject() as AnyObject,
             "postVisibilityStartTime":0 as AnyObject,
             "postVisibilityEndTime":0 as AnyObject,
             "postIsActive":true as AnyObject,
             "postSpecs": passedObject?.postSpecs?.toFBObject() as AnyObject,
             "messageRanking":0 as AnyObject,
             "ratingRanking":0 as AnyObject,
             "originalAuthorID":passedObject?.postCreatorID as AnyObject,
             "postWasFlagged":false as AnyObject,
             "originalPostID":passedObject?.postID as AnyObject,
             "chatVersionType":1 as AnyObject
            
        ]
        
        
      
        
     
        
        
        let refreshAlert = UIAlertController(title: "Ban user?", message: " ", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.ref?.child("Chats").child((self.passedObject?.postCreatorID)!).child((self.passedObject?.postID)!).child(postID).setValue(post)

            
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        self.present(refreshAlert, animated: true, completion: nil)
        
        

        
        self.removeAnimate()

    }
    
    @IBAction func btnExit(_ sender: Any) {
        
        self.removeAnimate()
    }
    var passedObject:postObject?
    var chatObject:postChatObject?
    var posterID:String?
    var posterName:String?

    var passedPostID:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblUsername.text = chatObject?.postUserName
        lblUserPost.text = chatObject?.postText
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.showAnimate()
        ref = Database.database().reference()
        
        popupView.layer.cornerRadius = 12
        popupView.clipsToBounds = true
        popupView.layer.borderWidth = 2
        popupView.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)

        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

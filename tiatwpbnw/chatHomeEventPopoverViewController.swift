//
//  chatHomeEventPopoverViewController.swift
//  tiatwpbnw
//
//  Created by David A on 4/6/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase

class chatHomeEventPopoverViewController: UIViewController , UIPopoverControllerDelegate {

    @IBOutlet weak var btnBlockUser: UIButton!
    @objc func funcBlockUser() {
        
        let refreshAlert = UIAlertController(title: "Block User?", message: " ", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Block", style: .default, handler: { (action: UIAlertAction!) in
            
            let postTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
            
            
            var blockedUser = blockedUserObject(BlockedUID: (self.passedObject?.postCreatorID)!, BlockedUsername: (self.passedObject?.postUserName)!, BlockedDate: postTime )
            
            
            self.ref?.child("blockedUserInfo").child((Auth.auth().currentUser?.uid)!).child(blockedUser.blockedUID).setValue(blockedUser.toFBObject());
            
            self.ref?.child("blockedUIDs").child((Auth.auth().currentUser?.uid)!).child(blockedUser.blockedUID).setValue(blockedUser.blockedUID);
            UserDefaults.standard.set(true , forKey: "resetOnAppear")

            self.removeAnimate()
            
            
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        self.present(refreshAlert, animated: true, completion: nil)
 
        
    }
    
    var passedObject:postObject?
       var ref:DatabaseReference?

    @IBAction func btnExit(_ sender: Any) {
        removeAnimate()

    }
    @IBOutlet weak var lblPostAuthor: UILabel!
   
    @IBOutlet weak var viewLabels: UIView!
    @IBOutlet weak var lblPostTime: UILabel!
    @IBOutlet weak var lblPostText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(passedObject?.postCreatorID == (Auth.auth().currentUser?.uid)!){
            
            
            btnBlockUser.isHidden = true
            
        }
        else{
            btnBlockUser.addTarget(self, action: #selector(funcBlockUser), for: .touchUpInside)

            btnBlockUser.isHidden = false

        }
        
        
        

        ref = Database.database().reference()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)

      //  showAnimate()

        
        viewLabels.layer.masksToBounds = true
        viewLabels.layer.cornerRadius = 8;
        viewLabels.layer.borderWidth = 1
        viewLabels.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)

      
        //            ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("POSTS").child(postID).child("postdata").setValue(post);
        
        
      //  ref?.child("Users").child((passedObject?.postCreatorID)!).child("POSTS").child((passedObject?.postID)!).child("postdata").observeSingleEvent(of: .value, with: { (snapshot) in
        

                
                self.lblPostAuthor.text = passedObject?.postUserName
                self.lblPostText.text  = passedObject?.postText
                
        let endDate = NSDate(timeIntervalSince1970: TimeInterval((passedObject?.postTime)! - TimeZone.current.secondsFromGMT()  ))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = TimeZone.current
        let localDate2 = dateFormatter.string(from: endDate as Date)
        self.lblPostTime.text = localDate2
        

        
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
        
        self.dismiss(animated: true, completion: nil)

      /*  UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
        
        */
    }
  

}

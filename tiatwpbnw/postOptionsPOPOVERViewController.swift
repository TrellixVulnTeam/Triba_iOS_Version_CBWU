//
//  postOptionsPOPOVERViewController.swift
//  tiatwpbnw
//
//  Created by David A on 4/3/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase


class postOptionsPOPOVERViewController: UIViewController {

    
    var ref:DatabaseReference?
    var passedObject:postObject?
    var delegate:aCustomDelegate?
    var isPostObjectNoted:Bool?
    var hasGottenNotedPostsNumber:Bool = false
    var numOfNoted:Int = 0

    @IBOutlet weak var btnNotePost: UIButton!
    @IBOutlet weak var txtStatus: UILabel!
    @IBOutlet weak var txtNumberOfNotes: UILabel!
    
    @objc func noteFunc(){
        if(hasGottenNotedPostsNumber && numOfNoted < 20){
            
            if(isPostObjectNoted)!{
                
                ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).child((passedObject?.postID)!).setValue(nil);
                //used when user is getting noted history for the box they're in
                
                
            }
            else{
                var postObject = passedObject?.toFBObject()
                let postSpecs = postSpecDetails(IsActive:true, HasBeenCleared:false,PostTime:0,
                                                PostRemovalTime:0, PostRemovalReason: 0, PostRemover: "")
                
                
                let post:[String : AnyObject] = [
                    //"eventTitle":txtEventName.text! as AnyObject,
                    "postNoterID":Auth.auth().currentUser?.uid as AnyObject,
                    "postID":passedObject!.postID as AnyObject,
                    "postLocations":passedObject!.postLocations?.toFBObject() as AnyObject,
                    "postSpecs": postSpecs.toFBObject() as AnyObject
                    
                    
                ]
                
                ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).child((passedObject?.postID)!).setValue(postObject);
                /*ref?.child("notedPostsHistory").child((Auth.auth().currentUser?.uid)!).child((passedObject?.postID)!).setValue(post);
 */
                
                
            }
            
            print("Noted")
            
        }
        else{
         
            print("That's a no from me, dog")

            
            
        }
  
  
        
        
        removeAnimate()

            
        
        
        
    }
    @IBAction func btnOpenChat(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "chatHomeViewController") as! chatHomeViewController
        
        myVC.passedObject = passedObject
        
        
        self.navigationController?.pushViewController(myVC, animated: true)
        
        
    }
    @IBAction func btnClose(_ sender: Any) {
        removeAnimate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

showAnimate()
        

        btnNotePost.addTarget(self, action: #selector(noteFunc), for: .touchUpInside)
        btnNotePost.isHidden = true
        
        ref = Database.database().reference()
        
        ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).child((passedObject?.postID)!).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value.debugDescription)
            if((snapshot.exists())){
                
                self.isPostObjectNoted = true
                self.btnNotePost.titleLabel?.text = "Unnote"
                self.btnNotePost.isHidden = false

                
            }
            else{
                self.isPostObjectNoted = false
                self.btnNotePost.titleLabel?.text = "Note"
                self.btnNotePost.isHidden = false

                
            }
        })
        
        
        
        self.ref?.child("UsersNotedPostsNumber").child((Auth.auth().currentUser?.uid)!).observe(.value) { (snapshot, key) in
          /*  if let item = snapshot.value as? Int{
                self.hasGottenNotedPostsNumber = true
                self.numOfNoted = item
                self.txtNumberOfNotes.text = self.numOfNoted.description

            }
            */
            
            if((snapshot.exists())){
                
                if let item = snapshot.value as? Int{
                    self.hasGottenNotedPostsNumber = true
                    self.numOfNoted = item
                    self.txtNumberOfNotes.text = "noted posts: "+self.numOfNoted.description
                    
                }
                
                
            }
            else{
                self.hasGottenNotedPostsNumber = true
                self.numOfNoted = 0
                self.txtNumberOfNotes.text = "noted posts: "+self.numOfNoted.description
                
                
            }
            
        }
        
        

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

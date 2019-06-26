//
//  becomeAdminPopoverViewController.swift
//  tiatwpbnw
//
//  Created by David A on 6/25/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase

class becomeAdminPopoverViewController: UIViewController {
    @IBOutlet weak var becomeAdminView: UIView!
    @IBAction func btnYes(_ sender: Any) {
        
        let post:[String : AnyObject] = [
            //"eventTitle":txtEventName.text! as AnyObject,
            "moderatorID":Auth.auth().currentUser?.uid as AnyObject,
            "postLat":userLat as AnyObject
            ,"postLong":userLong as AnyObject,
             "moderatorName":Auth.auth().currentUser?.displayName! as AnyObject
        ]
        
         self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("userAccessLevel").setValue("LOCALMODERATOR")
        UserDefaults.standard.set("LOCALMODERATOR", forKey: "userAccessLevel")
        self.ref?.child("mods").child("freeRange").child((Auth.auth().currentUser?.uid)!).setValue(post)
        self.removeAnimate()
    }
    @IBAction func btnNo(_ sender: Any) {
        
        self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("userAccessLevel").setValue("NORMALREJECTED")
        UserDefaults.standard.set("NORMALREJECTED", forKey: "userAccessLevel")
        self.removeAnimate()

    }
    
    
    var handle: DatabaseHandle?
    var ref:DatabaseReference?
    var userLat:Double?
    var userLong:Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
       
        self.showAnimate()
        
        ref = Database.database().reference()
        
        becomeAdminView.layer.masksToBounds = true
        becomeAdminView.layer.cornerRadius = 8;
      //  becomeAdminView.layer.borderColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        becomeAdminView.layer.borderWidth = 2
        becomeAdminView.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)

        
        
        var uLat:Double = 200.0
        var uLong:Double = 200.0
        
        if let uLat = UserDefaults.standard.object(forKey: "userLat") as? Double{
            userLat = uLat
        }
        if let uLong = UserDefaults.standard.object(forKey: "userLong") as? Double{
            userLong = uLong
        }

        // Do any additional setup after loading the view.
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

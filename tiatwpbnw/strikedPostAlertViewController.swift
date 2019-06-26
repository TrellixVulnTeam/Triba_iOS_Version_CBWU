//
//  strikedPostAlertViewController.swift
//  tiatwpbnw
//
//  Created by David A on 8/6/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth

class strikedPostAlertViewController: UIViewController {

    var passedStrikeNumber:Int?
    var ref:DatabaseReference?
    var userID = ""
    var homeDelegate:aCustomDelegate?

    @IBOutlet weak var viewPopUp: UIView!
    
    
    @IBOutlet weak var lblHowManyStrikesLeft: UILabel!
    @IBAction func btnClosePopup(_ sender: Any) {
        
        removeAnimate()

    }
    @IBAction func btnGoToUserAdvancedInfo(_ sender: Any) {

    // removeAnimate()
//removeAnimate()
        
        
       /* let myVC = storyboard?.instantiateViewController(withIdentifier: "advancedUserInfoViewController") as! advancedUserInfoViewController
        navigationController?.pushViewController(myVC, animated: true)
        */
        

      let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "navForUserAdvancedFromPopoverViewController")
        self.present(newViewController, animated: true, completion: nil)

        //removeAnimate()

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.showAnimate()
        userID = (Auth.auth().currentUser?.uid)!

        
        ref = Database.database().reference()

        
        self.ref?.child("Users").child(self.userID).child("showUserStrikeAlert").setValue(false)

        
        let strikesLeft = 3 - passedStrikeNumber!
        
        if(strikesLeft > 1){
        lblHowManyStrikesLeft.text = "You have "+strikesLeft.description+" strikes left"
        }
        else if(strikesLeft == 1){
            lblHowManyStrikesLeft.text = "You have 1 strike left"
        }
    
    
        
        viewPopUp.layer.masksToBounds = true
        viewPopUp.layer.cornerRadius = 8;
        viewPopUp.layer.borderColor =  #colorLiteral(red: 1, green: 0.2483450174, blue: 0, alpha: 1)
        viewPopUp.layer.borderWidth = 1
        
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

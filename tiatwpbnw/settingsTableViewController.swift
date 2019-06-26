//
//  settingsTableViewController.swift
//  tiatwpbnw
//
//  Created by David A on 5/15/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit

class settingsTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    var ref:DatabaseReference?
    var postTime:CLong = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        self.tabBarController?.tabBar.isHidden = true
         self.hidesBottomBarWhenPushed = true;
   
        
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated);
      
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        postTime = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))

        tableView.tableFooterView = UIView(frame: .zero)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 0.8994809504)
        UITableViewCell.appearance().selectedBackgroundView = backgroundColorView

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "advancedUserInfoViewController") as! advancedUserInfoViewController
            navigationController?.pushViewController(myVC, animated: true)
            
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            //Change Username
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = tableView.cellForRow(at: indexPath)
            
            //cell?.backgroundColor = #colorLiteral(red: 0.579462111, green: 0.88346982, blue: 0.7369065881, alpha: 1)
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "usernameCreateViewController") as! usernameCreateViewController
            myVC.alreadyHasUsername = true
            navigationController?.pushViewController(myVC, animated: true)
     
        }
        if indexPath.section == 0 && indexPath.row == 2 {
            //Log Out
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                FBSDKLoginManager().logOut()
                //self.Username.text = ""
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "fbLoginPageViewController") as! fbLoginPageViewController
            navigationController?.pushViewController(myVC, animated: true)
            
            
            
            
            
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            //App Info
            

            
       
            if let vc = self.storyboard?.instantiateViewController(withIdentifier:"newUserTutorialViewController") {
                vc.modalTransitionStyle   = .crossDissolve;
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
            }
            
            
        }
      
        if indexPath.section == 1 && indexPath.row == 1 {
            //Privacy Policy
            
            //  let url = URL(string: "https://www.freeprivacypolicy.com/privacy/view/5ae34555bd83ee1c9bc81feeaa87fcc8")!
            
            let url = URL(string: "http://triba.co/privacyPolicy.html")!
            
            
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    
        
        if indexPath.section == 2 && indexPath.row == 0 {
            //Deactivate Account
            
            
            let refreshAlert = UIAlertController(title: "Are you sure?", message: "All of your posts will be locked and you will lose all your Karma", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                let inverseTime = -self.postTime
                self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("ActiveStatus").setValue("INACTIVE")
                self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("userLastAccountResetDate").setValue(self.postTime)
                self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("userLastAccountResetDateInverse").setValue(inverseTime)
                self.ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).setValue(nil)
                self.ref?.child("UsersNotedPostsIDList").child((Auth.auth().currentUser?.uid)!).setValue(nil)

                
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    FBSDKLoginManager().logOut()
                    //self.Username.text = ""
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
                
                let myVC = self.storyboard?.instantiateViewController(withIdentifier: "fbLoginPageViewController") as! fbLoginPageViewController
                self.navigationController?.pushViewController(myVC, animated: true)
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
             
                
            }))
            
            
            self.present(refreshAlert, animated: true, completion: nil)
            
            /*
            let inverseTime = -postTime
            ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("ActiveStatus").setValue("INACTIVE")
            ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("userLastAccountResetDate").setValue(postTime)
            ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("userLastAccountResetDateInverse").setValue(inverseTime)

            ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).setValue(nil)
            ref?.child("UsersNotedPostsNumber").child((Auth.auth().currentUser?.uid)!).setValue(nil)
            ref?.child("UsersNotedPostsIDList").child((Auth.auth().currentUser?.uid)!).setValue(nil)

            */
         
            
 
            
            
            
        }
        
        
        //appSuggestionViewController
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

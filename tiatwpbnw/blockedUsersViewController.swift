//
//  blockedUsersViewController.swift
//  tiatwpbnw
//
//  Created by David A on 9/4/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase

class blockedUsersViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return bannedUserList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionUsers.frame.width * 0.95 , height: 135)
        
    }
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var lblText: UILabel!
    
    
    
    @objc func tagUnPostFunction(sender : UIButton){
        let myIndexPath = collectionUsers.indexPathForView(view: sender)

        self.ref?.child("blockedUserInfo").child((Auth.auth().currentUser?.uid)!).child(self.bannedUserList[(myIndexPath?.row)!].blockedUID).setValue(nil);
        
        self.ref?.child("blockedUIDs").child((Auth.auth().currentUser?.uid)!).child(self.bannedUserList[(myIndexPath?.row)!].blockedUID).setValue(nil);
        
        
        
       
        
        //removes from personal list on device
        self.bannedUserList.remove(at: (myIndexPath?.row)!)
        
        
        self.collectionUsers.deleteItems(at: [myIndexPath!])
        UserDefaults.standard.set(true , forKey: "resetOnAppear")

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:blockedUserCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "blockedUserCollectionViewCell", for: indexPath) as! blockedUserCollectionViewCell
        cell.btnUnblock.addTarget(self, action: #selector(tagUnPostFunction(sender:)), for: .touchUpInside)

        cell.lblUsername.text = bannedUserList[indexPath.row].blockedUsername.description
        
        //cell.lblRemovalReason.text = "Removed for breaking rule #" + strikedPostsList[indexPath.row].postRemovalReason.description
        
        let endDate = NSDate(timeIntervalSince1970: TimeInterval((bannedUserList[indexPath.row].blockedDate) - TimeZone.current.secondsFromGMT()  ))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = TimeZone.current
        let localDate2 = dateFormatter.string(from: endDate as Date)
        cell.lblBanDate.text = "Banned: " + localDate2
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8;
        cell.layer.borderColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.borderWidth = 1
        
        
        return cell
    }
    


    
    @IBOutlet weak var collectionUsers: UICollectionView!
    var bannedUserList:[blockedUserObject] = []
var ref:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        //lblBack.setTextColorToGradient(image: #imageLiteral(resourceName: "backgroundTextTriba"))
      //  viewBack.alpha = CGFloat(0.25)
        
        
        ref = Database.database().reference()

        
        
        lblText.setTextColorToGradient(image: #imageLiteral(resourceName: "backgroundTextTriba"))
        viewBack.alpha = CGFloat(0.25)
        

       ref?.child("blockedUserInfo").child((Auth.auth().currentUser?.uid)!).queryLimited(toLast: 350).observe(.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
                
             
           
                var isValidPost = true
                
                
                var blockedUID:String = ""
                var blockedUsername:String = ""
                var blockedDate:CLong = 0
                
                
                if(dict["blockedUID"] == nil){
                    isValidPost = false
                    print("postID")
                    
                }
                else{
                    // postID = dict["postID"] as! String
                    
                    if dict["blockedUID"] is String{
                        //everything about the value works.
                        blockedUID = dict["blockedUID"] as! String
                    } else {
                        isValidPost = false
                        
                    }
                }
                
                if(dict["blockedUsername"] == nil){
                    isValidPost = false
                    
                }
                else{
                    // postID = dict["postID"] as! String
                    
                    if dict["blockedUsername"] is String{
                        //everything about the value works.
                        blockedUsername = dict["blockedUsername"] as! String
                    } else {
                        isValidPost = false
                        
                    }
                }
                
                
                if(dict["blockedDate"] == nil){
                    isValidPost = false
                    
                }
                else{
                    // postID = dict["postID"] as! String
                    
                    if dict["blockedDate"] is CLong{
                        //everything about the value works.
                        blockedDate = dict["blockedDate"] as! CLong
                    } else {
                        isValidPost = false
                        
                    }
                }
                
               
                
                if(isValidPost){
                
                    
                    
                    
                    
                    let bannedPost = blockedUserObject(BlockedUID: blockedUID, BlockedUsername: blockedUsername, BlockedDate: blockedDate )
                    
                    self.bannedUserList.append(bannedPost)
                    self.collectionUsers.reloadData()
                    
                }
                
                
                
                
            }
        })
        
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

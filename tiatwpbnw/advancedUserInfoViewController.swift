//
//  advancedUserInfoViewController.swift
//  tiatwpbnw
//
//  Created by David A on 8/5/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase
import SDWebImage

class advancedUserInfoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    
    var strikedPostsList:[strikedPostObject] = []
    
    var userFullName = ""
    var userID = ""
    var ref:DatabaseReference?

    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var lblUserRealName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblUserKarma: UILabel!
    @IBOutlet weak var lblUserAccessLevel: UILabel!
    @IBOutlet weak var lblStrikeNumber: UILabel!
    
    
    var userAccessLevel = ""

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return strikedPostsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:strikedPostsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "strikedPostsCollectionViewCell", for: indexPath) as! strikedPostsCollectionViewCell
   
        cell.lblPostTextt.text = strikedPostsList[indexPath.row].postObject?.postText.description
        cell.lblRemovalReason.text = "Removed for breaking rule #" + strikedPostsList[indexPath.row].postRemovalReason.description
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8;
        cell.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)

        cell.layer.borderWidth = 1
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionStrikeHistory.frame.width * 0.95 , height: 135)
        
    }

    
    @IBOutlet weak var collectionStrikeHistory: UICollectionView!
    
    
    @IBOutlet weak var viewBackText: UIView!
    
    @IBOutlet weak var lblBackText: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        

        userFullName = (Auth.auth().currentUser?.displayName!)!
        userID = (Auth.auth().currentUser?.uid)!
        
        
        if let uAllowedAccessLevel = UserDefaults.standard.object(forKey: "userAccessLevel") as? String{
            userAccessLevel = uAllowedAccessLevel
        }
        
        if(userAccessLevel == "LOCALMODERATOR"){
            lblUserAccessLevel.text = "Status: Moderator"
            
        }
        else{
            lblUserAccessLevel.text = "Status: Active User"
            
        }
        
        
        
        lblBackText.setTextColorToGradient(image: #imageLiteral(resourceName: "backgroundTextTriba"))
        viewBackText.alpha = CGFloat(0.25)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        
        self.lblUserRealName.text = userFullName
        
        
        if let waiveUsername = UserDefaults.standard.object(forKey: "Username") as? String{
            self.lblUsername.text = waiveUsername
        }
        if let userRating = UserDefaults.standard.object(forKey: "userRating") as? Int{
            
          //  self.lblUserKarma.text = "Karma: " + (userRating.description)
        }
        
    
        
        
        
    }
    
    @objc func gtBlockedUsers(){
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "blockedUsersViewController") as! blockedUsersViewController

        
        self.navigationController?.pushViewController(myVC, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let btnGoToBlockedUsers = UIBarButtonItem(title: "Blocked Users", style:  .plain, target: self, action: #selector(gtBlockedUsers))
        btnGoToBlockedUsers.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.rightBarButtonItem = btnGoToBlockedUsers
        
        
        userFullName = (Auth.auth().currentUser?.displayName!)!
        userID = (Auth.auth().currentUser?.uid)!
        ref = Database.database().reference()
  let photoUrl:String = "https://graph.facebook.com/" + (Auth.auth().currentUser?.providerData[0].uid)! + "/picture?height=400";
        let imageUrl = URL(string: photoUrl)
        
       /*
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.gradientLayer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor,UIColor.black.cgColor,#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
            
            self.view.gradientLayer.gradient = GradientPoint.bottomToTop.draw()
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            
            self.view.insertSubview(blurEffectView, at: 0)//if you have more UIViews, use an insertSubview API to place it where needed
            
       
            
            
            
        }
        */
        
      
        
        
       
        
        imgProfileImage.sd_setImage(with: imageUrl)
        // self.imageProfilePic.layer.cornerRadius = 10
        imgProfileImage.layer.cornerRadius = 12
        imgProfileImage.clipsToBounds = true
        imgProfileImage.layer.borderWidth = 2
        imgProfileImage.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)

        self.lblUserRealName.text = userFullName as? String

        
        self.ref?.child("Users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let item = snapshot.value as? [String: AnyObject]{
                let uName = item["userName"]
                let userFullName = item["userFullName"]
                
                if(item["userStrikes"] != nil){
                    //let uStrikes = item["userStrikes"] as! Int
                    
                    if item["userStrikes"] is Int{
                        //everything about the value works.
                        let uStrikes = item["userStrikes"] as! Int
                        self.lblStrikeNumber.text = "Strikes: " + (uStrikes.description)
                        
                    }
                    
                    
                    
                    
                }
                
                if(item["userRating"] != nil){
                    
                    
                    
                    if item["userRating"] is CLong{
                        //everything about the value works.
                        let uKarma = item["userRating"] as! CLong
                        
                    //    self.lblUserKarma.text = "Karma: " + (uKarma.description)
                        
                    }
                    
                    
                }
                if(item["userName"] != nil){
                    
                    
                    if item["userName"] is String{
                        //everything about the value works.
                        let userName = item["userName"] as! String
                        
                        self.lblUsername.text = userName.description
                        
                    }
                    
                    
                }
                

             
               
                
            }
          
        })
        
        
        ref?.child("strikedPostHistory").child(userID).queryLimited(toLast: 10).observe(.childAdded, with: { (snapshot) in
            if let strikedPostObjectDict = snapshot.value as? [String: AnyObject]{
                 let dict = strikedPostObjectDict["postObject"] as! [String: Any]
                
                
                var ISActive:Bool? = nil
                var HAsBeenCleared:Bool? = nil
                var POstTime:CLong? = nil
                var POstRemovalTime:CLong? = nil
                
                
                var isValidPost:Bool = true
                var postID:String? = nil
                var postCreatorID:String? = nil
                var postText:String? = nil
                var postUserName:String? = nil
                var postType:String? = nil
                var postDescription:String? = nil
                var postTime:CLong? = nil
                var postTimeInverse:CLong? = nil
                var creatorName:String? = nil
                
                var loc00:String? = nil
                var loc01:String? = nil
                var loc02:String? = nil
                var loc10:String? = nil
                var loc11:String? = nil
                var loc12:String? = nil
                var loc20:String? = nil
                var loc21:String? = nil
                var loc22:String? = nil
                
                var POstVisStartTime:CLong? = nil
                var POstVisEndTime:CLong? = nil
                
                
                var postLat:Double? = nil
                var postLong:Double? = nil
                
                var ratingBlend:CLong? = nil
                var textCount:Int? = nil
                
                var POstRemovalReason:Int? = nil
                var POstRemover:String? = nil
                
                var postBranch1:String? = nil
                var postBranch2:String? = nil
                
                var postWasFlagged:Bool = true
                
                var strikedPostRemoverPosition = ""
                var strikedPostReason = 0
                var strikedPostRemoverID = ""
                
                if(dict["postID"] == nil){
                    isValidPost = false
                }
                else{
                    // postID = dict["postID"] as! String
                    
                    if dict["postID"] is String{
                        //everything about the value works.
                        postID = dict["postID"] as! String
                    } else {
                        print("pID")
                        isValidPost = false
                    }
                }
                
                if(dict["postCreatorID"] == nil){
                    isValidPost = false
                }
                else{
                    //postCreatorID = dict["postCreatorID"] as! String
                    
                    if dict["postCreatorID"] is String{
                        //everything about the value works.
                        postCreatorID = dict["postCreatorID"] as! String
                    } else {
                        isValidPost = false
                        print("pCD")

                    }
                }

                if(dict["postText"] == nil){
                    isValidPost = false
                }
                else{
                    //postText = dict["postText"] as! String
                    
                    if dict["postText"] is String{
                        //everything about the value works.
                        postText = dict["postText"] as! String
                    } else {
                        isValidPost = false
                        print("PT")

                    }
                }
                
                if(dict["postUserName"] == nil){
                    isValidPost = false
                }
                else{
                    //  postUserName = dict["postUserName"] as! String
                    
                    if dict["postUserName"] is String{
                        //everything about the value works.
                        postUserName = dict["postUserName"] as! String
                    } else {
                        isValidPost = false
                        print("pUN")

                    }
                }
                
                if(dict["postType"] == nil){
                    isValidPost = false
                }
                else{
                    // postType = dict["postType"] as! String
                    
                    if dict["postType"] is String{
                        //everything about the value works.
                        postType = dict["postType"] as! String
                    } else {
                        isValidPost = false
                        print("PT")

                    }
                }
                
                if(dict["postDescription"] == nil){
                    isValidPost = false
                }
                else{
                    // postDescription = dict["postDescription"] as! String
                    
                    if dict["postDescription"] is String{
                        //everything about the value works.
                        postDescription = dict["postDescription"] as! String
                    } else {
                        isValidPost = false
                        print("PD")

                    }
                }
                
                if(dict["postTime"] == nil){
                    isValidPost = false
                }
                else{
                    // postTime = dict["postTime"] as! CLong
                    
                    if dict["postTime"] is CLong{
                        //everything about the value works.
                        postTime = dict["postTime"] as! CLong
                    } else {
                        isValidPost = false
                        print("pTime")

                    }
                }
                
                if(dict["postTimeInverse"] == nil){
                    isValidPost = false
                    
                    
                }
                else{
                    //postTimeInverse = dict["postTimeInverse"] as! CLong
                    
                    if dict["postTimeInverse"] is CLong{
                        //everything about the value works.
                        postTimeInverse = dict["postTimeInverse"] as! CLong
                    } else {
                        isValidPost = false
                        print("pTINV")

                    }
                }

                if(dict["creatorName"] == nil){
                    isValidPost = false
                }
                else{
                    //  creatorName = dict["creatorName"] as! String
                    
                    if dict["creatorName"] is String{
                        //everything about the value works.
                        creatorName = dict["creatorName"] as! String
                    } else {
                        isValidPost = false
                        print("PCN")

                    }
                }
                
                
                
                if(dict["postLocations"] == nil){
                    isValidPost = false
                    print("pL")

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
                    print("pV")

                }
                else{
                    
                    if dict["postVisibilityStartTime"] is CLong{
                        //everything about the value works.
                        POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
                    } else {
                        isValidPost = false
                        print("PVV")

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
                        print("pVEND")

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
                        print("PLAT")

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
                        print("pLONG")

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
                        print("rBLEND")

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
                        print("tCOUNT")

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
                        print("PB1")

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
                        print("PB2")

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
                        print("FLAGGY")

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
                                print("PISACTI")

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
                                print("PCLEARED")

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
                                print("PSPECTIME")

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
                                print("pREMOVAL")

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
                                print("PREMREAS")

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
                                print("pREMOVERR")

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
                // strikedPostObjectDict["postObject"]
                if(strikedPostObjectDict["postRemoverPosition"] == nil){
                    isValidPost = false
                }
                else{
                    //strikedPostRemoverPosition = strikedPostObjectDict["postRemoverPosition"] as! String
                    
                    if strikedPostObjectDict["postRemoverPosition"] is String{
                        //everything about the value works.
                        strikedPostRemoverPosition = strikedPostObjectDict["postRemoverPosition"] as! String
                    } else {
                        isValidPost = false
                        print("specREM")

                    }
                    
                }
                
                if(strikedPostObjectDict["postRemovalReason"] == nil){
                    isValidPost = false
                }
                else{
                    //strikedPostReason = strikedPostObjectDict["postRemovalReason"] as! Int
                    
                    
                    if strikedPostObjectDict["postRemovalReason"] is Int{
                        //everything about the value works.
                        strikedPostReason = strikedPostObjectDict["postRemovalReason"] as! Int
                    } else {
                        isValidPost = false
                        print("specREAS")

                    }
                    
                }
                if(strikedPostObjectDict["postRemoverID"] == nil){
                    isValidPost = false
                }
                else{
                    // strikedPostRemoverID = strikedPostObjectDict["postRemoverID"] as! String
                    
                    if strikedPostObjectDict["postRemoverID"] is String{
                        //everything about the value works.
                        strikedPostRemoverID = strikedPostObjectDict["postRemoverID"] as! String
                    } else {
                        isValidPost = false
                        print("specREMID")

                    }
                }
                
                /*
                let strikedPostRemoverPosition = strikedPostObjectDict["postRemoverPosition"] as! String
                let strikedPostReason = strikedPostObjectDict["postRemovalReason"] as! Int
                let strikedPostRemoverID = strikedPostObjectDict["postRemoverID"] as! String
                
                */
                
                //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
                // self.myList.append(titleText! as! String)
                // self.postTypeList.append(postType as! String)
                //self.userIDList.append(postCreatorID as! String)
                
                
                /*
                let postLocations = postLocationsClass(Box00:loc00!, Box01:loc01!,Box02:loc02!,
                                                       Box10:loc10!,Box11:loc11!,Box12:loc12!,
                                                       Box20:loc20!,Box21:loc21!,Box22:loc22!)
                
                let postSpecs = postSpecDetails(IsActive:ISActive!, HasBeenCleared:HAsBeenCleared!,PostTime:POstTime!,
                                                PostRemovalTime:POstRemovalTime!, PostRemovalReason: POstRemovalReason!, PostRemover: POstRemover!)
                
                var postObjectt = postObject(PostCreatorID:postCreatorID!,
                                             PostText:postText!,
                                             PostID:postID! ,
                                             PostLat:postLat! ,
                                             PostLong:postLong! ,
                                             PostTime:postTime! ,
                                             PostUserName:postUserName! ,
                                             PostType:postType! ,
                                             PostDESCRIPTION:postDescription!,
                                             CreatorName:creatorName!, PostLocations: postLocations,RatingBlend:ratingBlend!, PostSpecs:postSpecs, PostVisStart:POstVisStartTime!, PostVisEnd:POstVisEndTime!, TextCount:textCount!,Branch1:postBranch1!, Branch2:postBranch2!, PostFlagStatus:postWasFlagged)
                
                var strikedObjectt =   strikedPostObject(
                    PostRemovalReason:strikedPostReason ,
                    PostRemovePosition:strikedPostRemoverPosition ,
                    PostRemoverID: strikedPostRemoverID ,
                    PostObject:postObjectt
                )
                
                self.strikedPostsList.append(strikedObjectt)
                self.collectionStrikeHistory.reloadData()
                
                */
                if(isValidPost){
                    let postLocations = postLocationsClass(Box00:loc00!, Box01:loc01!,Box02:loc02!,
                                                           Box10:loc10!,Box11:loc11!,Box12:loc12!,
                                                           Box20:loc20!,Box21:loc21!,Box22:loc22!)
                    
                    let postSpecs = postSpecDetails(IsActive:ISActive!, HasBeenCleared:HAsBeenCleared!,PostTime:POstTime!,
                                                    PostRemovalTime:POstRemovalTime!, PostRemovalReason: POstRemovalReason!, PostRemover: POstRemover!)
                    
                    var postObjectt = postObject(PostCreatorID:postCreatorID!,
                                              PostText:postText!,
                                              PostID:postID! ,
                                              PostLat:postLat! ,
                                              PostLong:postLong! ,
                                              PostTime:postTime! ,
                                              PostUserName:postUserName! ,
                                              PostType:postType! ,
                                              PostDESCRIPTION:postDescription!,
                                              CreatorName:creatorName!, PostLocations: postLocations,RatingBlend:ratingBlend!, PostSpecs:postSpecs, PostVisStart:POstVisStartTime!, PostVisEnd:POstVisEndTime!, TextCount:textCount!,Branch1:postBranch1!, Branch2:postBranch2!, PostFlagStatus:postWasFlagged)
                    
                    var strikedObjectt =   strikedPostObject(
                        PostRemovalReason:strikedPostReason ,
                        PostRemovePosition:strikedPostRemoverPosition ,
                        PostRemoverID: strikedPostRemoverID ,
                        PostObject:postObjectt
                    )
                    
                    self.strikedPostsList.append(strikedObjectt)
                    self.collectionStrikeHistory.reloadData()
                    
                }
                
                
                /*
                let strikedPostRemoverPosition = strikedPostObjectDict["postRemoverPosition"] as! String
                let strikedPostReason = strikedPostObjectDict["postRemovalReason"] as! Int
                let strikedPostRemoverID = strikedPostObjectDict["postRemoverID"] as! String

                
                let postID = dict["postID"] as! String
                let postCreatorID = dict["postCreatorID"] as! String
                
                //The thing missing from the posthome
                let postText = dict["postText"] as! String
                
                let postUserName = dict["postUserName"] as! String
                let postType = dict["postType"] as! String
                let postDescription = dict["postDescription"] as! String
                let postTime = dict["postTime"] as! CLong
                
                
                let creatorName = dict["creatorName"]  as! String
                
                
                let locDic = dict["postLocations"]  as! [String: Any]
                let loc00 = locDic["box00"] as! String
                let loc01 = locDic["box01"] as! String
                let loc02 = locDic["box02"] as! String
                let loc10 = locDic["box10"] as! String
                let loc11 = locDic["box11"] as! String
                let loc12 = locDic["box12"] as! String
                let loc20 = locDic["box20"] as! String
                let loc21 = locDic["box21"] as! String
                let loc22 = locDic["box22"] as! String
                
                
                
                // let postLocations = dict["postLocations"]  as! postLocationsClass
                let postLocations = postLocationsClass(Box00:loc00, Box01:loc01,Box02:loc02,
                                                       Box10:loc10,Box11:loc11,Box12:loc12,
                                                       Box20:loc20,Box21:loc21,Box22:loc22)
                
                let specDic = dict["postSpecs"]  as! [String: Any]
                let ISActive = specDic["isActive"] as! Bool
                let HAsBeenCleared = specDic["hasBeenCleared"] as! Bool
                let POstTime = specDic["postTime"] as! CLong
                let POstRemovalTime = specDic["postRemovalTime"] as! CLong
                
                let POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
                let POstVisEndTime = dict["postVisibilityEndTime"] as! CLong
                
                let postLat = dict["postLat"] as! Double
                let postLong = dict["postLong"] as! Double
                let ratingBlend = dict["ratingBlend"] as! CLong
                let textCount = dict["textCount"] as! Int
                
                print(" ")
                print(" ")
                print(" ")
                print(" ")
                print(" ")
                print(" ")
                print(postText)
                print(" ")
                print(" ")
                print(" ")
                print(" ")
                print(" ")
                print(" ")
                
                let POstRemovalReason = specDic["postRemovalReason"] as! String
                let POstRemover = specDic["postRemover"] as! String
                
                
                let postBranch1 = dict["postBranch1"] as! String
                let postBranch2 = dict["postBranch2"] as! String
                
                */
                
                
                
                
                
                /*
                let postSpecs = postSpecDetails(IsActive:ISActive, HasBeenCleared:HAsBeenCleared,PostTime:POstTime,
                                                PostRemovalTime:POstRemovalTime, PostRemovalReason: POstRemovalReason, PostRemover: POstRemover)
                
                //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
                // self.myList.append(titleText! as! String)
                
                var postObjectt = postObject(PostCreatorID:postCreatorID,
                                          PostText:postText,
                                          PostID:postID ,
                                          PostLat:postLat ,
                                          PostLong:postLong ,
                                          PostTime:postTime ,
                                          PostUserName:postUserName ,
                                          PostType:postType ,
                                          PostDESCRIPTION:postDescription,
                                          CreatorName:creatorName, PostLocations: postLocations,RatingBlend:ratingBlend, PostSpecs:postSpecs, PostVisStart:POstVisStartTime, PostVisEnd:POstVisEndTime, TextCount:textCount,Branch1:postBranch1, Branch2:postBranch2)
              
          

                var strikedObjectt =   strikedPostObject(
                    PostRemovalReason:strikedPostReason ,
                    PostRemovePosition:strikedPostRemoverPosition ,
                    PostRemoverID: strikedPostRemoverID ,
                    PostObject:postObjectt
                )
                
                self.strikedPostsList.append(strikedObjectt)
                
                
                self.collectionStrikeHistory.reloadData()
                
                
                */
                
                
                
                
                
                //self.scrollToLastItem()
                
                
                
                
            }
        })
        
        // Do any additional setup after loading the view.
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

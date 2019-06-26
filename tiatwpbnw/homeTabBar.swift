//
//  homeTabBar.swift
//  tiatwpbnw
//
//  Created by David A on 3/22/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
//import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit

//CLLocationManagerDelegate

struct notedNumbers {
    static var numOfNotedPosts = 0
 
    
    
}

class homeTabBar: UITabBarController, UITabBarControllerDelegate, UIPopoverControllerDelegate {
    var isLocEnabled = false
    var locationManager = CLLocationManager()
    var ref:DatabaseReference?
    var isFirstTimeAccount:Bool?
    var userFullName = ""
    var userID = ""
    var homeDelegate:aCustomDelegate?

    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)  {
        print("Selected Index :\(self.selectedIndex)");
        print("Selected Index :\(self.selectedIndex)");
        print("Selected Index :\(self.selectedIndex)");
        print("Selected Index :\(self.selectedIndex)");
        print("Selected Index :\(self.selectedIndex)");
        print("Selected Index :\(self.selectedIndex)");
        print("Selected Index :\(self.selectedIndex)");
        print("Selected Index :\(self.selectedIndex)");
        print("Selected Index :\(self.selectedIndex)");

       
   
    }
    

     func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.title == "notToBeSeen" //set an unique title for the view controller in storyboard or the view controller class.
        {
            if isLocEnabled{
                //menuButton.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                
              /*  let popOverVC = storyboard?.instantiateViewController(withIdentifier: "createPostPopupViewController") as! createPostPopupViewController
                self.addChildViewController(popOverVC)
                popOverVC.view.frame = self.view.frame
                self.view.addSubview(popOverVC.view)
                popOverVC.didMove(toParentViewController: self)
                
                */
                
                
                if let vc = self.storyboard?.instantiateViewController(withIdentifier:"createPostPopupViewController") {
                    vc.modalTransitionStyle   = .crossDissolve;
                    vc.modalPresentationStyle = .overCurrentContext
                    self.present(vc, animated: true, completion: nil)
                }
                
            }
            else{
                showLocationDisabledPopUp()
                
            }
            
            
            
            
       
          //  performSegueWithIdentifier("YourModalViewIdentifier", sender: nil)
            
            
            
            //returns false so that the tab connected to the post button won't launch.
            //That post is never to be seen.
            return false
        } else {
        
            //If it isn't the middle button, it returns true so that it's tab will open
            return true
        }
    }
    
    /*
    @objc
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {

     
     
        if tabBarController.selectedIndex == 0  {
            viewController.viewDidLoad()
            
            print("heyoo")
            print("heyoo")
            print("heyoo")
            print("heyoo")
            print("heyoo")
            print("heyoo")
            print("heyoo")
            print("heyoo")

            
        }
    }
    */
  


    
    func centerButtonDisappear() {
        //menuButton.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        
        
        //self.view.viewWithTag(1119)?.isHidden = true
        print("DISAPPEAR")
        print("DISAPPEAR")
        print("DISAPPEAR")
        print("DISAPPEAR")
        print("DISAPPEAR")
        print("DISAPPEAR")
        print("DISAPPEAR")

       
    }
    func centerButtonAppear() {
        //menuButton.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        self.tabBar.isHidden = false

        //self.view.viewWithTag(1119)?.isHidden = false
        //self.view.bringSubview(toFront: self.view.viewWithTag(1119)! )
        print("APPEAR")
        print("APPEAR")
        print("APPEAR")
        print("APPEAR")
        print("APPEAR")
        print("APPEAR")

        
    }
    
    func tabBarVisible() {
        //menuButton.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        self.tabBar.isHidden = false
       
        
        
    }
    func tabBarInvisible() {
        //menuButton.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        self.tabBar.isHidden = true
        
        
        
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
       
        
        //New User
        
        if(   isFirstTimeUserVar.isFirstTimeUser){
            
        /*
            let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "newUserTutorialViewController") as! newUserTutorialViewController
            self.addChildViewController(popOverVC)
            // popOverVC.delegate = self
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            
            */
            
            
            if let vc = self.storyboard?.instantiateViewController(withIdentifier:"newUserTutorialViewController") {
                vc.modalTransitionStyle   = .crossDissolve;
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
            }
            
        }
        
       
        
        
        
        
        
        
        self.ref?.child("1A_TribaSystemData").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let item = snapshot.value as? [String: AnyObject]{
                
                
                print("BBBBBBBBB")
                print(self.description)
                print(self.description)
                print(self.description)
                print(self.description)
                print(self.description)
                print(self.description)
                print(self.description)
                print("BBBBBBBBB")
                
                var siteLink:String = ""
                var minimumVersion:Double = 0.0
                
                
                let currentVersion = 1.19
                
                if(item["minimumAppVersion"] != nil){
                    
                    minimumVersion = item["minimumAppVersion"] as! Double
                    
                    
                    if( currentVersion < minimumVersion ){
                        
                        
                        if(item["updateLink"] != nil){
                            
                            siteLink = item["updateLink"] as! String
                            
                            
                            let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "updateForcedViewController") as! updateForcedViewController
                            
                            
                            self.addChildViewController(popOverVC)
                            popOverVC.passedURL = siteLink
                            
                            popOverVC.view.frame = self.view.frame
                            self.view.addSubview(popOverVC.view)
                            popOverVC.didMove(toParentViewController: self)
                            
                            
                        }
                        else{
                            
                            
                            
                            let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "updateForcedViewController") as! updateForcedViewController
                            
                            
                            self.addChildViewController(popOverVC)
                            popOverVC.passedURL = "http://triba.co/"
                            
                            popOverVC.view.frame = self.view.frame
                            self.view.addSubview(popOverVC.view)
                            popOverVC.didMove(toParentViewController: self)
                            
                        }
                        
                        
                        
                    }
                    else{
                        // self.loadNewUserPopover()
                    }
                    
                }
                
                if(item["updateLink"] != nil){
                    
                    
                }
                
                print("A")
                print("A")
                print("A")
                print("A")
                
                
                
                
                
                
                
            }})
        
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated);
      /* // menuButton.isHidden = false
        menuButton.backgroundColor = #colorLiteral(red: 0.03622988128, green: 0.08384140301, blue: 0.1620972056, alpha: 1)

        
        
        //self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.red
        UIApplication.shared.statusBarStyle = .lightContent


        self.view.bringSubview(toFront: self.menuButton);

       // (self.tabBarController as! CustomTabBarController).showCenterButton();
        
        
        
        if  let arrayOfTabBarItems = self.tabBarController?.tabBar.items as AnyObject as? NSArray,let tabBarItem = arrayOfTabBarItems[1] as? UITabBarItem {
            tabBarItem.isEnabled = false
        }
        
        */

        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated);
      //  menuButton.isHidden = true
        //menuButton.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
       
        
        
        
        
        
        //This used to be in it
     //   self.view.viewWithTag(1119)?.isHidden = true

        
        
        
        
        
        

        //self.hidesBottomBarWhenPushed = false;
     //   (self.tabBarController as! CustomTabBarController).hideCenterButton();
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.delegate = self


        userFullName = (Auth.auth().currentUser?.displayName!)!
        userID = (Auth.auth().currentUser?.uid)!
        
        if(!locationVariables.userLat.description.isEmpty && !locationVariables.userLong.description.isEmpty){
            
           
            isLocEnabled = true
        }


        let user = Auth.auth().currentUser
        ref = Database.database().reference()
        //self.tabBarController?.delegate = self
        
        print("AAAAAAAAAA")
       print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print("AAAAAAAAAA")

        
//    8/13
//IF ERRORS OCCUR (EXTRA TAB APPEARS), MOVE THIS TO VIEWDIDLOAD
        
        self.ref?.child("Users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
         
            
            if let item = snapshot.value as? [String: AnyObject]{
                
                
                
                var isValidPost:Bool = true
                var uName:String? = ""
                var uRating:CLong? = 0
                var userFullName:String? = ""
                var userAllowedAccessDate:CLong? = 0
                var userAccessLevel:String? = ""
                var userNecessaryAlertType:String? = ""
                var userNecessaryAlertType2:String? = ""
                var userStrikes:Int? = 0
                var showUserStrikeAlert:Bool? = false
             
                /*
                 uName = item["userName"]
                 uRating = item["userRating"]
                 userFullName = item["userFullName"]
                 userAllowedAccessDate = item["userAllowedAccessDate"]
                 userAccessLevel = item["userAccessLevel"]
                 userNecessaryAlertType = item["userNecessaryAlertType"]
                 userNecessaryAlertType2 = item["userNecessaryAlertType2"]
                 userStrikes = item["userStrikes"]

                 showUserStrikeAlert = item["showUserStrikeAlert"]

                
                */
                
             
                
                
                if(item["userStrikes"] == nil){
                }
                else{
                    
                    userStrikes = item["userStrikes"] as! Int
                    var uStrikes = 0
                        //let uStrikes = item["userStrikes"] as! Int
                        
                        if item["userStrikes"] is Int{
                            //everything about the value works.
                            let uStrikes = item["userStrikes"] as! Int
                            userStrikes = item["userStrikes"] as! Int

                        }
                        else{
                             uStrikes = 0

                    }
                        
                        
                        
                        
                    
                    
                 
                    
                    
                   // let uStrikes = userStrikes as! Int

                    print("STRIKES")
                    print("STRIKES")
                    print("STRIKES")
                    print("STRIKES")
                    print(uStrikes.description)
                    print("STRIKES")
                    print("STRIKES")
                    print("STRIKES")

//bannedUser
                    if(uStrikes > 2){
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "bannedUserViewController")
                        self.present(newViewController, animated: true, completion: nil)
                        
                    }
                   
                    
                    if(item["showUserStrikeAlert"] != nil){
                        
                        
                        var showUStrikeAlert = false
                        
                        if item["showUserStrikeAlert"] is Bool{
                            //everything about the value works.
                            showUserStrikeAlert = item["showUserStrikeAlert"] as! Bool
                            showUStrikeAlert = showUserStrikeAlert!
                            
                        }
                        else{
                            showUserStrikeAlert = false
                            showUStrikeAlert = false
                            
                        }
                        
                        
                        if(showUStrikeAlert){
                            
                            print("A")
                            print("A")
                            print("A")
                            print("A")
                            print("A")
                            print(uStrikes.description)
                            print("A")
                            print("A")
                            print("A")
                            print("A")

                          /*
                            let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "strikedPostAlertViewController") as! strikedPostAlertViewController
                            self.addChildViewController(popOverVC)
                            popOverVC.passedStrikeNumber = uStrikes as! Int

                            popOverVC.view.frame = self.view.frame
                            self.view.addSubview(popOverVC.view)
                            popOverVC.didMove(toParentViewController: self)
                            */
                            
                            let savingsInformationViewController = self.storyboard?.instantiateViewController(withIdentifier: "strikedPostAlertViewController") as! strikedPostAlertViewController
                            
                            //   savingsInformationViewController.delegate = self
                            savingsInformationViewController.passedStrikeNumber = uStrikes as! Int
                            
                            savingsInformationViewController.modalPresentationStyle = .overFullScreen
                            if let popoverController = savingsInformationViewController.popoverPresentationController {
                             //   popoverController.sourceView = sender
                             //   popoverController.sourceRect = sender.bounds
                                
                                
                                //popoverController.permittedArrowDirections = .anyany
                              //  popoverController.delegate = self as! UIPopoverPresentationControllerDelegate
                            }
                            self.present(savingsInformationViewController, animated: true, completion: nil)
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")
                            print("POPOVERRRRR")

                            
                            
                        }
                    }
                }
                
           
                
            
                
                if(item["userName"] == nil){
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "usernameCreateViewController")
                    self.present(newViewController, animated: true, completion: nil)
                    
                }
                else{
                    var uName = ""
                    if item["userName"] is String{
                        //everything about the value works.
                        uName = item["userName"] as! String

                        
                    }
                    else{uName = ""}
                    

                    UserDefaults.standard.set(uName, forKey: "Username")
                }
                
              /*  if(   isFirstTimeUserVar.isFirstTimeUser == true){
             
                    
                    let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "newUserTutorialViewController") as! newUserTutorialViewController
                    self.addChildViewController(popOverVC)
                    // popOverVC.delegate = self
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    
                    
                    
                    
                }
                */
                
                
                if(item["userRating"] == nil){
                    UserDefaults.standard.set(0, forKey: "userRating")

                   
                    
                }
                else{
                    var uRating = 0
                    if item["userRating"] is CLong{
                        //everything about the value works.
                        uRating = item["userRating"] as! CLong

                        
                    }
                    
                    UserDefaults.standard.set(uRating, forKey: "userRating")

                }
                
                

                if(item["userAllowedAccessDate"] == nil){
                    
                    UserDefaults.standard.set(0, forKey: "userAllowedAccessDate")

                    
                }
                else{
                    var userAllowedAccessDate = 0
                    if item["userAllowedAccessDate"] is CLong{
                        //everything about the value works.
                        userAllowedAccessDate = item["userAllowedAccessDate"] as! CLong

                        
                    }
                    

                    UserDefaults.standard.set(userAllowedAccessDate, forKey: "userAllowedAccessDate")

                }
                

                
                if(item["userAccessLevel"] != nil){
                    //If access level exists in database
                    
                    var unameString = "NORMAL"
                    userAccessLevel = "NORMAL"
                    if item["userAccessLevel"] is String{
                        //everything about the value works.
                        userAccessLevel = item["userAccessLevel"] as! String
                         unameString = userAccessLevel as! String

                        
                    }
                    
                    


                    
                    print(unameString)
                    print(unameString)
                    print(unameString)
                    print(unameString)
                    print(unameString)

                    

                 if(unameString == "MODLEVELOFFERED"){
                    
            
                    /*
                    
                    let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "becomeAdminPopoverViewController") as! becomeAdminPopoverViewController
                    self.addChildViewController(popOverVC)
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                 */
                    
                    
                    let savingsInformationViewController = self.storyboard?.instantiateViewController(withIdentifier: "becomeAdminPopoverViewController") as! becomeAdminPopoverViewController
                    
                    //   savingsInformationViewController.delegate = self
                    
                    savingsInformationViewController.modalPresentationStyle = .overFullScreen
                    if let popoverController = savingsInformationViewController.popoverPresentationController {
                        //   popoverController.sourceView = sender
                        //   popoverController.sourceRect = sender.bounds
                        
                        
                        //popoverController.permittedArrowDirections = .anyany
                        //  popoverController.delegate = self as! UIPopoverPresentationControllerDelegate
                    }
                    self.present(savingsInformationViewController, animated: true, completion: nil)
                    
                    
                    
                }
                else{
                    //if value isn't an offer, set value
                    //UserDefaults.standard.set("normal", forKey: "userAccessLevel")
                    UserDefaults.standard.set(userAccessLevel as! String, forKey: "userAccessLevel")


                    
                    
                    

                }
                }
                else{
                    //If accesslevel doesn't exist, set to normal
                    self.ref?.child("Users").child(self.userID).child("userAccessLevel").setValue("NORMAL")
                    UserDefaults.standard.set("NORMAL", forKey: "userAccessLevel")
                    
                }

                
                
            }
          
        })
        
 
        
        
        
        
        
      /*
        ref?.child("Users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists(){
                
                print("true rooms exist")
                
                let uName = snapshot.value as! String
                print(uName)
                print(uName)
                print(uName)
                print(uName)
                print(uName)
                print(uName)
                print(uName)

                UserDefaults.standard.set(uName, forKey: "WaiveUsername")
                
                /*
                - Enable create button here
                 Stuff like the upvote/downvote features SHOULD already have a username attached
                 */

                
            }else{
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "usernameCreateViewController")
                self.present(newViewController, animated: true, completion: nil)            }
            
            
        })
        
        
        
       */
        
        
        
        
        
       //UITabBar.appearance().layer.borderWidth = 1
        //UITabBar.appearance().clipsToBounds = true
        //self.selectedIndex = 0;
        //UITabBar.appearance().layer.borderColor = #colorLiteral(red: 0.9750739932, green: 0.9750967622, blue: 0.9750844836, alpha: 1)

        
        self.tabBarController?.hidesBottomBarWhenPushed = true
      
        
      
        

       // setupMiddleButton()

        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
     
            
            
        }
        
        
        
        print("BBBBBBBBB")
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print("BBBBBBBBB")


        // Do any additional setup after loading the view.
    }
    
    var postLong: Double!


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    struct GlobalVariablesandArrays {
        static var removedNotes = [String]();
    }

    
    
    let menuButton = UIButton(frame: CGRect.zero)
    
    func setupMiddleButton() {
       /* let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        menuButton.frame = CGRect(x: 0, y: 0, width: tabBarItemSize.width, height: tabBar.frame.size.height)
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height - self.view.safeAreaInsets.bottom
        menuButtonFrame.origin.x = self.view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        menuButton.backgroundColor = UIColor.green
        */
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height
        menuButtonFrame.origin.x = self.view.bounds.width / 2 - menuButtonFrame.size.width / 2
        menuButton.frame = menuButtonFrame
        menuButton.tag = 1119
        menuButton.backgroundColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1)
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
      //  self.view.addSubview(menuButton)
        
        menuButton.setImage(UIImage(named: "tribaAddv0|01"), for: UIControlState.normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction), for: UIControlEvents.touchUpInside)
        
       // self.view.layoutIfNeeded()
        
        
        self.view.addSubview(menuButton)
        self.view.layoutIfNeeded()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuButton.frame.origin.y = self.view.bounds.height - menuButton.frame.height - self.view.safeAreaInsets.bottom
    }
    
    @objc func menuButtonAction(sender: UIButton) {
        //self.selectedIndex = 2
        // console print to verify the button works
        print("Middle Button was just pressed!")
        
        
        
        
       if isLocEnabled{
       // menuButton.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
/*
            let popOverVC = storyboard?.instantiateViewController(withIdentifier: "createPostPopupViewController") as! createPostPopupViewController
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
        */
        if let vc = self.storyboard?.instantiateViewController(withIdentifier:"createPostPopupViewController") {
            vc.modalTransitionStyle   = .crossDissolve;
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
            
       }
        else{
            showLocationDisabledPopUp()
            
        }
 
        
        
        
        
        
    }
    
    
    
    
    func showLocationDisabledPopUp() {
        //txtBooya.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        // imgLocationSet.isHidden = false
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver za we need your location",
                                                preferredStyle: .alert)
        
        // let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //  alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate)
            //txtEventDesc.text = location.coordinate.latitude.description
            
        }
        //imgLocationSet.isHidden = true
        
        
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        print(coord.latitude)
        print(coord.longitude)
        
        let latt = coord.latitude
        // postLat = Double(round(1000*latt)/1000)
        
        let longg = coord.longitude
        // postLong = Double(round(1000*longg)/1000)
        
        locationVariables.userLat = latt
        locationVariables.userLong = longg
        
     /*   UserDefaults.standard.set(latt, forKey: "userLat")
        UserDefaults.standard.set(longg, forKey: "userLong")
        
        */
        
        print("userlat part: " + locationVariables.userLat.description)
        print("userlong part: " + locationVariables.userLong.description)
        
        isLocEnabled = true
        
        //put handle here
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
            isLocEnabled = false
            
        }
    }
    /*
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     if let location = locations.first {
     print(location.coordinate)
     //txtEventDesc.text = location.coordinate.latitude.description
     
     }
     imgLocationSet.isHidden = true
     
     
     let locationArray = locations as NSArray
     let locationObj = locationArray.lastObject as! CLLocation
     let coord = locationObj.coordinate
     print(coord.latitude)
     print(coord.longitude)
     
     let latt = coord.latitude
     // postLat = Double(round(1000*latt)/1000)
     
     let longg = coord.longitude
     // postLong = Double(round(1000*longg)/1000)
     
     txtYAy.text = "" + latt.description + " " + longg.description
     UserDefaults.standard.set(latt, forKey: "userLat")
     UserDefaults.standard.set(longg, forKey: "userLong")
     isLocEnabled = true
     
     //put handle here
     
     
     
     
     
     }
     
     
     
     func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
     if(status == CLAuthorizationStatus.denied) {
     showLocationDisabledPopUp()
     isLocEnabled = false
     
     }
     
     }
     */
    
    func checkLocation()  -> Bool{
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            }
        } else {
            return false
        }
    }
    
    func loadNewUserPopover() {

      let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "newUserTutorialViewController") as! newUserTutorialViewController
        self.addChildViewController(popOverVC)
//        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)

        print("CCCCC")
        
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print("CCCCC")

       
     
    }
    
}
    
    


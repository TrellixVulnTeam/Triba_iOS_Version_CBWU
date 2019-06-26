//
//  ViewController.swift
//  tiatwpbnw
//
//  Created by David A on 3/5/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
//import Toast_Swift


class ViewController: UIViewController {
    var ref:DatabaseReference?
    var isAccountMessedUp:Bool = false


    @IBOutlet weak var btnLogin: UIButton!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationItem.setHidesBackButton(true, animated:true);

        
        btnLogin.addTarget(self, action: #selector(nSignIn), for: .touchUpInside)
        //btnLOGINN.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        ref = Database.database().reference()
        
        
        if Auth.auth().currentUser != nil {
            //  self.Username.text = currentUser.displayName
            
            // userName.text = passedValueID
            
            
        }
        else{
            
            btnLogin.isHidden = false
        }
        
        
        
        //submitForms()
        
        let accessToken = FBSDKAccessToken.current()
        if accessToken?.tokenString == nil && Auth.auth().currentUser != nil {
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                FBSDKLoginManager().logOut()
                //self.Username.text = ""
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
        
        if Auth.auth().currentUser != nil {
       
            
            let user = Auth.auth().currentUser
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
      
            user?.reauthenticate(with: credential) { error in
                if error != nil {
                    // An error happened.
                    
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                        FBSDKLoginManager().logOut()
                        //self.Username.text = ""
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                    self.btnLogin.isHidden = false
                    //                    Auth.auth().currentUser?.description
                    
                    
                    let alert = UIAlertController(title: "Login Error", message: "The user account has been disabled by an administrator.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
                        
                    }
                    
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion:nil)
                    
                } else {
                    // User re-authenticated.
                    /*  self.btnLOGINN.isHidden = false
                     let alert = UIAlertController(title: "", message: "B", preferredStyle: .alert)
                     let okAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
                     
                     }
                     
                     alert.addAction(okAction)
                     self.present(alert, animated: true, completion:nil)
                     
                     
                     */
                    // Auth.auth().currentUser?.description
                    self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("UserInfo").observeSingleEvent(of: .value, with: { (snapshot) in
                        var uName = ""
                        
                        //If everything is there
                        if (snapshot.hasChild("userID") && snapshot.hasChild("inviteKey") && snapshot.hasChild("userName")
                            && snapshot.hasChild("userProfilePic") && snapshot.hasChild("ActiveStatus")  && snapshot.hasChild("userFullName") ){
                            
                            
                            if let item = snapshot.value as? [String: AnyObject]{
                                uName = item["userName"] as! String
                            }
                            if(uName.isEmpty){
                                //Basically, If the username is not there, if goes to the username set up page
                                
                                
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "usernameCreateViewController")
                                self.present(newViewController, animated: true, completion: nil)
                            }
                            
                            //Sets uName for later use in the app
                            UserDefaults.standard.set(uName, forKey: "WaiveUsername")
                            
                            
                            self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("UserInfo").child("ActiveStatus").setValue("ACTIVE")
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "tabHome")
                            self.present(newViewController, animated: true, completion: nil)
                            
                        }
                            //If everything but the username is there
                        else if(snapshot.hasChild("userID") && snapshot.hasChild("inviteKey")
                            && snapshot.hasChild("userProfilePic") && snapshot.hasChild("ActiveStatus") && snapshot.hasChild("userFullName")){
                            
                            /*
                             let alertController = UIAlertController(title: "A", message: error?.localizedDescription, preferredStyle: .alert)
                             let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                             alertController.addAction(okayAction)
                             self.present(alertController, animated: true, completion: nil)
                             */
                            
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "usernameCreateViewController")
                            self.present(newViewController, animated: true, completion: nil)
                            
                            
                        }
                            //If the username is there but account info isn't
                        else if(snapshot.hasChild("userName")){
                            
                            if let item = snapshot.value as? [String: AnyObject]{
                                uName = item["userName"] as! String
                            }
                            
                            //Another safeguard in case the uName comes up as null
                            if(uName.isEmpty){
                                //Basically, If the username is also not there, it just sets everything(basic account info) up again and has the user reset their username
                                let autoKomKey = "P"+(self.ref?.childByAutoId().key)!
                                //let indexy = autoKomKey?.index(after: "-")
                                let photoUrl:String = "https://graph.facebook.com/" + (Auth.auth().currentUser?.providerData[0].uid)! + "/picture?height=400";
                                let post:[String : AnyObject] = [
                                    "ActiveStatus":"ACTIVE" as AnyObject,
                                    "userID":Auth.auth().currentUser?.uid as AnyObject,
                                    "inviteKey": autoKomKey as AnyObject,
                                    "userFullName":Auth.auth().currentUser?.displayName as AnyObject,
                                    "userProfilePic":photoUrl as AnyObject,
                                    "userName": uName as AnyObject
                                    
                                    
                                ]
                                self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("UserInfo").setValue(post)
                                
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "usernameCreateViewController")
                                self.present(newViewController, animated: true, completion: nil)
                            }
                            
                            //Sets uName for later use in the app
                            UserDefaults.standard.set(uName, forKey: "WaiveUsername")
                            
                            
                            
                            //Sets user account info
                            let autoKomKey = "P"+(self.ref?.childByAutoId().key)!
                            //let indexy = autoKomKey?.index(after: "-")
                            let photoUrl:String = "https://graph.facebook.com/" + (Auth.auth().currentUser?.providerData[0].uid)! + "/picture?height=400";
                            let post:[String : AnyObject] = [
                                "ActiveStatus":"ACTIVE" as AnyObject,
                                "userID":Auth.auth().currentUser?.uid as AnyObject,
                                "inviteKey": autoKomKey as AnyObject,
                                "userFullName":Auth.auth().currentUser?.displayName as AnyObject,
                                "userProfilePic":photoUrl as AnyObject,
                                "userName": uName as AnyObject
                                
                                
                            ]
                            self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("UserInfo").setValue(post)
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "tabHome")
                            self.present(newViewController, animated: true, completion: nil)
                            
                            
                            
                        }
                            //If nether account info nor username are there
                        else{
                            let autoKomKey = "P"+(self.ref?.childByAutoId().key)!
                            //let indexy = autoKomKey?.index(after: "-")
                            let photoUrl:String = "https://graph.facebook.com/" + (Auth.auth().currentUser?.providerData[0].uid)! + "/picture?height=400";
                            let post:[String : AnyObject] = [
                                "ActiveStatus":"ACTIVE" as AnyObject,
                                "userID":Auth.auth().currentUser?.uid as AnyObject,
                                "inviteKey": autoKomKey as AnyObject,
                                "userFullName":Auth.auth().currentUser?.displayName as AnyObject,
                                "userProfilePic":photoUrl as AnyObject
                                
                                
                            ]
                            self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("UserInfo").setValue(post)
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "usernameCreateViewController")
                            self.present(newViewController, animated: true, completion: nil)
                        }
                        
                        
                    })
                }
            }
    
            if Auth.auth().currentUser != nil {
                
            }
  
        }
        else{
     
            btnLogin.isHidden = false
            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   



    
    @objc func nSignIn() {
        let fbLoginManager = FBSDKLoginManager()
        //self.view.makeToastActivity(.bottom)
        btnLogin.isHidden = true
        
        activityIndicator.frame.origin = CGPoint(x: 50 , y: 100)//Set the origin related to your button
        
        //activityIndicator.center = self.view.
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3);
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
        
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                self.btnLogin.isHidden = false
               // self.view.hideToastActivity()
                self.activityIndicator.stopAnimating()

                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                self.btnLogin.isHidden = false
             //  self.view.hideToastActivity()
                
                self.activityIndicator.stopAnimating()
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    self.btnLogin.isHidden = false
                  //  self.view.hideToastActivity()
                    self.activityIndicator.stopAnimating()

                    
                    return
                }
                
                
                
                
                if (Auth.auth().currentUser != nil) {
                    
                    //  self.Username.text = currentUser.displayName
                    
                    
                    self.ref = Database.database().reference()
                    self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("UserInfo").observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        //username string
                        var uName = ""
                        
                        //If everything is there
                        if (snapshot.hasChild("userID") && snapshot.hasChild("inviteKey") && snapshot.hasChild("userName")
                            && snapshot.hasChild("userProfilePic") && snapshot.hasChild("ActiveStatus")  && snapshot.hasChild("userFullName") ){
                            
                            
                            if let item = snapshot.value as? [String: AnyObject]{
                                uName = item["userName"] as! String
                            }
                            if(uName.isEmpty){
                                //Basically, If the username is not there, if goes to the username set up page
                                
                                
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "usernameCreateViewController")
                                self.present(newViewController, animated: true, completion: nil)
                            }
                            
                            //Sets uName for later use in the app
                            UserDefaults.standard.set(uName, forKey: "WaiveUsername")
                            
                            
                            self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("UserInfo").child("ActiveStatus").setValue("ACTIVE")
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "tabHome")
                            self.present(newViewController, animated: true, completion: nil)
                            
                        }
                            //If everything but the username is there
                        else if(snapshot.hasChild("userID") && snapshot.hasChild("inviteKey")
                            && snapshot.hasChild("userProfilePic") && snapshot.hasChild("ActiveStatus") && snapshot.hasChild("userFullName")){
                            
                            /*
                             let alertController = UIAlertController(title: "A", message: error?.localizedDescription, preferredStyle: .alert)
                             let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                             alertController.addAction(okayAction)
                             self.present(alertController, animated: true, completion: nil)
                             */
                            
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "usernameCreateViewController")
                            self.present(newViewController, animated: true, completion: nil)
                            
                            
                        }
                            //If the username is there but account info isn't
                        else if(snapshot.hasChild("userName")){
                            
                            if let item = snapshot.value as? [String: AnyObject]{
                                uName = item["userName"] as! String
                            }
                            
                            //Another safeguard in case the uName comes up as null
                            if(uName.isEmpty){
                                //Basically, If the username is also not there, it just sets everything(basic account info) up again and has the user reset their username
                                let autoKomKey = "P"+(self.ref?.childByAutoId().key)!
                                //let indexy = autoKomKey?.index(after: "-")
                                let photoUrl:String = "https://graph.facebook.com/" + (Auth.auth().currentUser?.providerData[0].uid)! + "/picture?height=400";
                                let post:[String : AnyObject] = [
                                    "ActiveStatus":"ACTIVE" as AnyObject,
                                    "userID":Auth.auth().currentUser?.uid as AnyObject,
                                    "inviteKey": autoKomKey as AnyObject,
                                    "userFullName":Auth.auth().currentUser?.displayName as AnyObject,
                                    "userProfilePic":photoUrl as AnyObject,
                                    "userName": uName as AnyObject
                                    
                                    
                                ]
                                self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("UserInfo").setValue(post)
                                
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "usernameCreateViewController")
                                self.present(newViewController, animated: true, completion: nil)
                            }
                            
                            //Sets uName for later use in the app
                            UserDefaults.standard.set(uName, forKey: "WaiveUsername")
                            
                            
                            
                            //Sets user account info
                            let autoKomKey = "P"+(self.ref?.childByAutoId().key)!
                            //let indexy = autoKomKey?.index(after: "-")
                            let photoUrl:String = "https://graph.facebook.com/" + (Auth.auth().currentUser?.providerData[0].uid)! + "/picture?height=400";
                            let post:[String : AnyObject] = [
                                "ActiveStatus":"ACTIVE" as AnyObject,
                                "userID":Auth.auth().currentUser?.uid as AnyObject,
                                "inviteKey": autoKomKey as AnyObject,
                                "userFullName":Auth.auth().currentUser?.displayName as AnyObject,
                                "userProfilePic":photoUrl as AnyObject,
                                "userName": uName as AnyObject
                                
                                
                            ]
                            self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("UserInfo").setValue(post)
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "tabHome")
                            self.present(newViewController, animated: true, completion: nil)
                            
                            
                            
                        }
                            //If nether account info nor username are there
                        else{
                            let autoKomKey = "P"+(self.ref?.childByAutoId().key)!
                            //let indexy = autoKomKey?.index(after: "-")
                            let photoUrl:String = "https://graph.facebook.com/" + (Auth.auth().currentUser?.providerData[0].uid)! + "/picture?height=400";
                            let post:[String : AnyObject] = [
                                "ActiveStatus":"ACTIVE" as AnyObject,
                                "userID":Auth.auth().currentUser?.uid as AnyObject,
                                "inviteKey": autoKomKey as AnyObject,
                                "userFullName":Auth.auth().currentUser?.displayName as AnyObject,
                                "userProfilePic":photoUrl as AnyObject
                                
                                
                            ]
                            self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("UserInfo").setValue(post)
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "usernameCreateViewController")
                            self.present(newViewController, animated: true, completion: nil)
                        }
                        
                        
                    })
                    
                    /*
                     self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
                     if let item = snapshot.value as? [String: AnyObject]{
                     
                     let uName = item["ActiveStatus"]
                     
                     
                     
                     if(uName != nil){
                     
                     if(uName?.text == "ACTIVE"){
                     self.view.hideToastActivity()
                     
                     let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                     let newViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController")
                     self.present(newViewController, animated: true, completion: nil)
                     
                     }
                     else{
                     self.view.makeToast("Welcome Back")
                     self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("ActiveStatus").setValue("ACTIVE")
                     self.view.hideToastActivity()
                     
                     let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                     let newViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController")
                     self.present(newViewController, animated: true, completion: nil)
                     
                     
                     }
                     
                     
                     
                     
                     }
                     
                     
                     }
                     else{
                     
                     
                     
                     
                     let photoUrl:String = "https://graph.facebook.com/" + (Auth.auth().currentUser?.providerData[0].uid)! + "/picture?height=400";
                     
                     let post:[String : AnyObject] = [
                     "ActiveStatus":"ACTIVE" as AnyObject,
                     "userID":Auth.auth().currentUser?.uid as AnyObject,
                     "inviteKey":self.ref?.childByAutoId().key as AnyObject,
                     "userName":Auth.auth().currentUser?.displayName as AnyObject
                     ,"userProfilePic":photoUrl as AnyObject
                     
                     
                     ]
                     
                     
                     self.ref?.child("Users").child((Auth.auth().currentUser?.uid)!).setValue(post
                     )
                     self.view.hideToastActivity()
                     
                     let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                     let newViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController")
                     self.present(newViewController, animated: true, completion: nil)
                     
                     
                     
                     }
                     })
                     */
                    
                    
                    
                }
                
            })
            
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 50) {
           // self.view.hideToastActivity()
            self.activityIndicator.stopAnimating()
            self.btnLogin.isHidden = false
            
            
            
        }
        
    }
}







class roundedCornerButton: UIButton {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // layer.borderWidth = 1/UIScreen.main.nativeScale
        // layer.borderColor = UIColor.blue.cgColor
        
        layer.cornerRadius = 12
        clipsToBounds = true
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        // contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 16)
    }
    /*
     override func layoutSubviews() {
     super.layoutSubviews()
     //layer.corner = frame.height/2
     }
     */
    /*
     @IBInspectable var cornerRadius: CGFloat = 0{
     didSet{
     self.layer.cornerRadius = cornerRadius
     }
     }
     
     @IBInspectable var borderWidth: CGFloat = 0{
     didSet{
     self.layer.borderWidth = borderWidth
     }
     }
     
     @IBInspectable var borderColor: UIColor = UIColor.clear{
     didSet{
     self.layer.borderColor = borderColor.cgColor
     }
     }
     */
}





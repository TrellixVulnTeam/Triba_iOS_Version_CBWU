//
//  usernameCreateViewController.swift
//  tiatwpbnw
//
//  Created by David A on 3/9/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase

struct isFirstTimeUserVar {
    static var isFirstTimeUser = false

}

class usernameCreateViewController: UIViewController ,  UITextViewDelegate {
    @IBOutlet weak var viewBackText: UIView!
    @IBOutlet weak var lblBackText: UILabel!
    
    
    var handle: DatabaseHandle?
    var ref:DatabaseReference?
    var uName: String?
    var alreadyHasUsername: Bool?
    var postTime:CLong = 0
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBAction func btnSetUsername(_ sender: Any) {
        let usernameLowercased = self.txtUsername.text?.lowercased()

        let username = self.txtUsername.text
        
        
        let containsInvalidCharacter = username?.characters.contains {".#$[]".characters.contains($0)} // true
        
               let containsSpace = username?.characters.contains {" ".characters.contains($0)} // true
        if(containsInvalidCharacter)!{
            
            
            let refreshAlert = UIAlertController(title: "Banned Character", message: "Cannot use '.', '#', '$', '[', or ']'", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
        }
        else if(self.txtUsername.text?.isEmpty)!{
            let refreshAlert = UIAlertController(title:"" , message: "Enter a username", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
        }
        else if(containsSpace)!{
            let refreshAlert = UIAlertController(title:"" , message: "Username cannot include space", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            

            
        }
        else{
            //Writes to username section. If returns error, username exists. If not error, username now belongs to them
        ref!.child("username_lookup").child(usernameLowercased!).setValue(Auth.auth().currentUser?.uid) { (error, ref) in
            if error == nil {
                
                self.setUsernameInAccount(username: username!)
            }
            else{
                let alert = UIAlertController(title: "", message: "Sorry, that username is taken", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
                    // self.canvas.image = nil
                }
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion:nil)
                
            }
            
        }
        
        
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        txtUsername.becomeFirstResponder()
        txtUsername.delegate = self as! UITextFieldDelegate;
       txtUsername.returnKeyType = UIReturnKeyType.done


         postTime = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
        
        
        lblBackText.setTextColorToGradient(image: #imageLiteral(resourceName: "backgroundTextTriba"))
       viewBackText.alpha = CGFloat(0.25)

        //alreadyHasUsername is passed but only if it comes from the settings page, not sign in.
        //This part just ensuresit doesn't crash everything since it'd be nil if
        //it wasn't passed from settings
        
        if(alreadyHasUsername != nil){}
        else{
            alreadyHasUsername = false

        }
        
        if(alreadyHasUsername != true)
        {
            //Just making sure
            alreadyHasUsername = false
        }
        else{
            if let univName = UserDefaults.standard.object(forKey: "Username") as? String{
                uName = univName
                
            }
        }
        
        
        let rightBarButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(usernameCreateViewController.doneSettingName(_:)))
        if(alreadyHasUsername)!{
            //Prevents back button from appearing if user is not comming from the settings page
            //self.navigationItem.rightBarButtonItem = rightBarButton
        }
        
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func doneSettingName(_ sender : UIButton) {
        
        /* if let navController = self.navigationController {
         navController.popViewController(animated: true)
         }
         */
        
        //goes to home page
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "tabHome")
        self.present(newViewController, animated: true, completion: nil)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func closeTheKeyboard(){
        self.view.endEditing(true)
        
    }
    
    
    //Limits username to 18 characters
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = txtUsername.text ?? ""
        
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 15 // Change limit based on your requirement.
    }
    
    func setUsernameInAccount(username: String){
     //Prevents characters that aren't allowed on firebase
        //'.', '#', '$', '[', or ']'
        
        let containsInvalidCharacter = username.characters.contains {".#$[]".characters.contains($0)} // true
        if(containsInvalidCharacter){
            
            
            let refreshAlert = UIAlertController(title: "Banned Character", message: "Cannot use '.', '#', '$', '[', or ']'", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
        }
        else{
        //Write Username
 ref?.child("Users").child((Auth.auth().currentUser?.uid)!).child("userName").setValue(username)
ref!.child("username_lookup_history").child(username).child((Auth.auth().currentUser?.uid)!).setValue(postTime)

        if(alreadyHasUsername)!{
            

            ref!.child("username_lookup").child(uName!).setValue(nil)

            
        }
        else{
            //Sets first time user data to show new user pop-up later
            isFirstTimeUserVar.isFirstTimeUser = true
            }
     
        UserDefaults.standard.set(username, forKey: "Username")
       // UserDefaults.standard.set(uName, forKey: "WaiveUsername")

        //uName = username
        // alreadyHasUsername = true
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "tabHome")
         
        self.present(newViewController, animated: true, completion: nil)
        }
        
    }
    

}
extension usernameCreateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtUsername {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
}

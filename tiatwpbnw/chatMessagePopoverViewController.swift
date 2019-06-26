//
//  chatMessagePopoverViewController.swift
//  tiatwpbnw
//
//  Created by David A on 6/20/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase




class chatMessagePopoverViewController: UIViewController,  UITextViewDelegate {
   
    

    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var btnSendMessage: UIButton!
    
    @IBAction func btnExit(_ sender: Any) {
        
        removeAnimate()

    }
    
    @objc func sendPost() {
        
        print(passedObject?.postText)
        print(passedObject?.postText)
        print(passedObject?.postText)
        print(passedObject?.postText)
        print(passedObject?.postText)
        print(passedObject?.postText)
        print(passedObject?.postText)
        print(passedObject?.postText)

        if( self.txtUserEntry.text?.isEmpty)!{
            
            let alert = UIAlertController(title: "", message: "Enter text", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
                // self.canvas.image = nil
            }
            
            alert.addAction(okAction)
            present(alert, animated: true, completion:nil)
            
        }
        else if(!checkForTerms(postText: txtUserEntry.text!)){
            
            
        }
            
        else{
        
        
        let postTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
        
        let post1Ref = ref?.childByAutoId()
        let postID = (post1Ref?.key)!
        
        let post:[String : AnyObject] = [
            //"eventTitle":txtEventName.text! as AnyObject,
            "postCreatorID":userID as AnyObject,
            "postText":txtUserEntry.text as AnyObject,
            "postID":postID as AnyObject
            ,"postLat":latt as AnyObject
            ,"postLong":longg as AnyObject,
             "postTime":postTime as AnyObject,
             "postTimeInverse":-postTime as AnyObject,
             "postUserName":userName as AnyObject,
             "postType":"CHATCOMMENT_IOS" as AnyObject,
             "postDescription":"NONE" as AnyObject,
             "creatorName":userFullName as AnyObject,
             "ratingBlend":0 as AnyObject,
             "postLocations":passedObject!.postLocations?.toFBObject() as AnyObject,
             "postVisibilityStartTime":0 as AnyObject,
             "postVisibilityEndTime":0 as AnyObject,
             "messageRanking":0 as AnyObject,
             "ratingRanking":0 as AnyObject,
             "postIsActive":true as AnyObject,
             "postSpecs": passedObject?.postSpecs?.toFBObject() as AnyObject,
             "originalAuthorID":passedObject?.postCreatorID as AnyObject,
             "postWasFlagged":false as AnyObject,
             "originalPostID":passedObject?.postID as AnyObject,
             "chatVersionType":1 as AnyObject

            
            
        ]
        
        self.view.endEditing(true);
        
        //ref?.child("b").childByAutoId().setValue("yo")
        txtUserEntry.text = ""
        
        
        
        
        // ref?.child("Users").child((passedObject?.postCreatorID)!).child("POSTS").child((passedObject?.postID)!).child("CHATS").child(postID).setValue(post)
        ref?.child("Chats").child((passedObject?.postCreatorID)!).child((passedObject?.postID)!).child(postID).setValue(post)
        
       // self.collectionTexts.reloadData()
        
        self.postDelegate?.reloadChatCollectionview()
        
        removeAnimate()

        
        }
        
    }
    @IBOutlet weak var txtUserEntry: UITextView!
    //Full, unedited lat and long
    var fullLat: Double!
    var fullLong: Double!
    //lat and long used to create location boxes
    var postLong: Double!
    var postLat: Double!
    var postID:String!
    var univName:String!
    var creDate:String = ""
    var creNum:Int = 0
    var eventTypeNum = 0
    var userName: String!
    var userFullName = ""
    var userID = ""
 
    var postType = "standard"
    var passedObject:postObject?
    var latt: Double!
    var longg: Double!
    
    var postDelegate:chatCustomDelegate?
    

    var handle: DatabaseHandle?
    var ref:DatabaseReference?
    
   
    
    
 
    
    /*
     func textView(_ txtvwPostText: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
     
     let currentText = txtvwPostText.text ?? ""
     guard let stringRange = Range(range, in: currentText) else { return false }
     let changedText = currentText.replacingCharacters(in: stringRange, with: text)
     return changedText.count <= 10 // Pass your character count here
     }
     */
    /*
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = txtUserEntry.text ?? ""
        
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 120 // Change limit based on your requirement.
    }
    */
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = txtUserEntry.text ?? ""
        
        
        let isDeleting = (range.length > 0) && text.isEmpty
        if isDeleting == true {
            // trim last character
            // you may want to drop based on the range.length, however you'll need
            // to determine if the character is an emoji and adjust the number of characters
            // as range.length returns a length > 1 for emojis
            let newStr = String(currentText.dropLast())
            return newStr.count <= 120
            
        }
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 120 // Change limit based on your requirement.
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.showAnimate()
        
        ref = Database.database().reference()

        
        if let univName = UserDefaults.standard.object(forKey: "Username") as? String{
            userName = univName
        }
    
        userFullName = (Auth.auth().currentUser?.displayName!)!
        userID = (Auth.auth().currentUser?.uid)!
      
        
        if((locationVariables.userLong != nil) && (locationVariables.userLat != nil)){
            
            latt =  locationVariables.userLat
            longg = locationVariables.userLong
        }
        else{
            if let userLat = UserDefaults.standard.object(forKey: "userLat") as? Double{
                latt = userLat
            }
            if let userLong = UserDefaults.standard.object(forKey: "userLong") as? Double{
                longg = userLong
            }
        }
        
        
        
        txtUserEntry.becomeFirstResponder()

        btnSendMessage.contentHorizontalAlignment = .right
        btnSendMessage.addTarget(self, action: #selector(sendPost), for: .touchUpInside)

        viewPopup.layer.cornerRadius = 12
        viewPopup.clipsToBounds = true
        viewPopup.layer.borderWidth = 1
       // viewPopup.layer.borderColor = #colorLiteral(red: 0.9750739932, green: 0.9750967622, blue: 0.9750844836, alpha: 1)
        viewPopup.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)

    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "gtPost" {
            removeAnimate()
            /*let navigation: UINavigationController = segue.destination as! UINavigationController
             
             var vc = createEventGeneralMeetSecondViewController.init()
             vc = navigation.viewControllers[0] as! createEventGeneralMeetSecondViewController
             */
            //if you need send something to destnation View Controller
            //vc.delegate = self
        }
        else if segue.identifier == "gtCreateTopic" {
            /* removeAnimate()
             let navigation: UINavigationController = segue.destination as! UINavigationController
             
             var vc = createEventGeneralMeetSecondViewController.init()
             vc = navigation.viewControllers[0] as! createEventGeneralMeetSecondViewController
             */
            removeAnimate()
        }
        
    }
    
    func checkForTerms(postText: String)->Bool{
        
        var myStringArr = postText.lowercased().components(separatedBy: " ")
        
         var elements = ["obama", "trump", "suicide", "kill", "9/11", "clinton", "nigger", "niggers", "jews", "blacks", "shoot", "nigga", "death", "cunt", "republican", "democrat", "liberal", "conservative"]
        
        var isValid = true
        var bannedWordString:String
        
        
        for item in myStringArr {
            // Do this
            
            if elements.contains(item) {
                print("Array contains 3")
                
                isValid = false
                bannedWordString = item
                print("word: " + item)
                
                
                
                let refreshAlert = UIAlertController(title: "Banned Word", message: "Do not use: " + bannedWordString, preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    return isValid
                    
                }))
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
                
            }
            
        }
        
        print("isValid: " + isValid.description)
        
        
        return isValid
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

        
       
    }
    
}
extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        
        return String(self[(start ..< end)])
    }
}

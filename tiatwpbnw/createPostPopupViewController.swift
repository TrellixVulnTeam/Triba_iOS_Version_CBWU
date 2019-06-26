//
//  createPostPopupViewController.swift
//  tiatwpbnw
//
//  Created by David A on 3/7/18.
//  Copyright © 2018 David A. All rights reserved.
//
//
//Popover for creating post
//
//DON"T DELETE COMMENTED STUFF!! VALUABLE THINGS ARE IN THERE!!!!

import UIKit
import CoreLocation
import Firebase
//import FirebaseDatabase

protocol filleTextViewDelegate : class {
    func fillTextview(filledData: String, boxNum: Int)
}

class createPostPopupViewController: UIViewController,  UITextViewDelegate  , UIPopoverControllerDelegate , UIGestureRecognizerDelegate, filleTextViewDelegate{

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
    var uLat:Double = 200.0
    var uLong:Double = 200.0
    var postType = "STANDARDTEXT"
    var userFullName = ""
    var userID = ""

    
    var isDetailed:Bool = false

    
    @IBOutlet weak var txtDetailedText: UITextView!
    @IBOutlet weak var txtDetailedDescription: UITextView!
    @IBOutlet weak var txtDetailedLocation: UITextView!
    
 
    @IBOutlet weak var txtDetailedTimeDetails: UITextView!
    
    @IBOutlet weak var txtvwPostText: UITextView!
    
    var handle: DatabaseHandle?
    var ref:DatabaseReference?
    
  
    @IBOutlet weak var viewDetailedPopup: UIView!
    
    @IBOutlet weak var viewPopup: UIView!
    
    
    func fillTextview(filledData: String, boxNum: Int) {
        print("THISCALLED")
        print("THISCALLED")
        print("THISCALLED")
        print("THISCALLED")
        print("THISCALLED")
        print("THISCALLED")
        print("THISCALLED")
        print("THISCALLED")
        print("THISCALLED")
        
        if(boxNum == 1){
        txtDetailedText.text = filledData
        }
        else if(boxNum == 2){
            txtDetailedDescription.text = filledData
        }
        else if(boxNum == 3){
            txtDetailedTimeDetails.text = filledData
        }
        else{
            txtDetailedLocation.text = filledData
        }
    }
    

    @IBAction func btnClosePopup(_ sender: Any) {
        removeAnimate()

    }
    @IBAction func btnSendPost(_ sender: Any) {
        
        
        if( self.txtvwPostText.text?.isEmpty)!{
            
            let alert = UIAlertController(title: "", message: "Enter text", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
                // self.canvas.image = nil
            }
            
            alert.addAction(okAction)
            present(alert, animated: true, completion:nil)
            
        }
        else if(!checkForTerms(postText: txtvwPostText.text!)){
            
        }
            
        else{
            //Post is ready to go
            
            
          /*
            if(txtPostText.text?.description[0] == "@"){
                postType = "CHAT"
            }
            
            */
            var postDesc = ""
            var postVisStartTime:CLong = 0
            var postVisEndTime:CLong = 0

            
              
                postType = "STANDARDTEXTIOS"
                
            
            
            let postText = txtvwPostText.text!
            
            
      let postTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
          

            
            ref = Database.database().reference()
            
            let post1Ref = ref?.childByAutoId()
            postID = (post1Ref?.key)!
            
            
            
            
          //  Double(String(format: "%.1f", labaRounded))!
            
            //This is the new shit
          /*  var nLat =  Double(floor(10*fullLat)/10)
            var nLong =  Double(floor(10*fullLong)/10)
         */
            
            var nLat = 0.0
            var nLong = 0.0
            
            
            //postLat and postLong are used for the location boxes
            /* postLat = Double(floor(100*uLat)/100)
             postLong = Double(floor(100*uLong)/100)
             */
            
            if(uLat > 0){
                nLat = Double(floor(10*uLat)/10)
                
                
            }
            else{
                var positiveLat =   abs(uLat)
                nLat = -1 * Double(floor(10*positiveLat)/10)
                
                
            }
            
            if(uLong > 0){
                nLong = Double(floor(10*uLong)/10)
                
                
            }
            else{
                var positiveLong =   abs(uLong)
                nLong = -1 * Double(floor(10*positiveLong)/10)
                
                
            }
            //This is the end of the enw shit
            
            //Post location box names
            //This is old stuff
            /*
            let box00 = String(format: "%.1f", postLat - 0.1)+"_"+String(format: "%.1f", postLong - 0.1)
            let box01 = String(format: "%.1f", postLat)+"_"+String(format: "%.1f", postLong - 0.1)
            let box02 = String(format: "%.1f", postLat + 0.1)+"_"+String(format: "%.1f", postLong - 0.1)
            let box10 = String(format: "%.1f", postLat - 0.1)+"_"+String(format: "%.1f", postLong)
            let box11 = String(format: "%.1f", postLat)+"_"+String(format: "%.1f", postLong)
            let box12 = String(format: "%.1f", postLat + 0.1)+"_"+String(format: "%.1f", postLong)
            let box20 = String(format: "%.1f", postLat - 0.1)+"_"+String(format: "%.1f", postLong + 0.1)
            let box21 = String(format: "%.1f", postLat)+"_"+String(format: "%.1f", postLong + 0.1)
            let box22 = String(format: "%.1f", postLat + 0.1)+"_"+String(format: "%.1f", postLong + 0.1)
            
            
            */
            let box00 = String(format: "%.1f", nLat - 0.1)+"_"+String(format: "%.1f", nLong - 0.1)
            let box01 = String(format: "%.1f", nLat)+"_"+String(format: "%.1f", nLong - 0.1)
            let box02 = String(format: "%.1f", nLat + 0.1)+"_"+String(format: "%.1f", nLong - 0.1)
            let box10 = String(format: "%.1f", nLat - 0.1)+"_"+String(format: "%.1f", nLong)
            let box11 = String(format: "%.1f", nLat)+"_"+String(format: "%.1f", nLong)
            let box12 = String(format: "%.1f", nLat + 0.1)+"_"+String(format: "%.1f", nLong)
            let box20 = String(format: "%.1f", nLat - 0.1)+"_"+String(format: "%.1f", nLong + 0.1)
            let box21 = String(format: "%.1f", nLat)+"_"+String(format: "%.1f", nLong + 0.1)
            let box22 = String(format: "%.1f", nLat + 0.1)+"_"+String(format: "%.1f", nLong + 0.1)
            
            /*
            //Post location box names
            let box00 = String(postLat - 0.1)+"_"+String(postLong - 0.1)
            let box01 = String(postLat )+"_"+String(postLong - 0.1)
            let box02 = String(postLat + 0.1)+"_"+String(postLong - 0.1)
            let box10 = String(postLat - 0.1)+"_"+String(postLong)
            let box11 = String(postLat)+"_"+String(postLong)
            let box12 = String(postLat + 0.1)+"_"+String(postLong )
            let box20 = String(postLat - 0.1)+"_"+String(postLong + 0.1)
            let box21 = String(postLat )+"_"+String(postLong + 0.1)
            let box22 = String(postLat + 0.1)+"_"+String(postLong + 0.1)
            */
            //Replaces decimals with the | symbol because decimals aren't allowed in node names
            let bo00new = box00.replacingOccurrences(of: ".", with: "|", options: .literal, range: nil)
            let bo01new = box01.replacingOccurrences(of: ".", with: "|", options: .literal, range: nil)
            let bo02new = box02.replacingOccurrences(of: ".", with: "|", options: .literal, range: nil)
            let bo10new = box10.replacingOccurrences(of: ".", with: "|", options: .literal, range: nil)
            let bo11new = box11.replacingOccurrences(of: ".", with: "|", options: .literal, range: nil)
            let bo12new = box12.replacingOccurrences(of: ".", with: "|", options: .literal, range: nil)
            let bo20new = box20.replacingOccurrences(of: ".", with: "|", options: .literal, range: nil)
            let bo21new = box21.replacingOccurrences(of: ".", with: "|", options: .literal, range: nil)
            let bo22new = box22.replacingOccurrences(of: ".", with: "|", options: .literal, range: nil)
            
            
            let postLocations:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "box00":bo00new as AnyObject,
                "box01":bo01new as AnyObject,
                "box02":bo02new as AnyObject,
                "box10":bo10new as AnyObject,
                "box11":bo11new as AnyObject,
                "box12":bo12new as AnyObject,
                "box20":bo20new as AnyObject,
                "box21":bo21new as AnyObject,
                "box22":bo22new as AnyObject,
                
                ]
            /*
            
            //let numOfSelectedBubbles =  addedBubbles.count
            let numOfSelectedBubbles =  0
            //Remove eventually
            var addedBubbles:[bubbleClass] = []
            
            
            addedBubbles.append(bubbleClass(BubbleID: "", BubbleName: "" ,BubbleState: "",BubbleCity: "",BubbleBorough: "", BubbleType: 0))
            addedBubbles.append(bubbleClass(BubbleID: "", BubbleName: "" ,BubbleState: "",BubbleCity: "",BubbleBorough: "", BubbleType: 0))
            addedBubbles.append(bubbleClass(BubbleID: "", BubbleName: "" ,BubbleState: "",BubbleCity: "",BubbleBorough: "", BubbleType: 0))
            addedBubbles.append(bubbleClass(BubbleID: "", BubbleName: "" ,BubbleState: "",BubbleCity: "",BubbleBorough: "", BubbleType: 0))
            addedBubbles.append(bubbleClass(BubbleID: "", BubbleName: "" ,BubbleState: "",BubbleCity: "",BubbleBorough: "", BubbleType: 0))
            
            */
            
            
            let postLatDOUBLE = Double(floor(100*postLat)/100)
            
            var postTimeZone = TimeZone.current.abbreviation()!
            
            if(postTimeZone.isEmpty){
                
                postTimeZone = "unavailableAtTimeOFTZCall"
            }
            
           // print(TimeZone.current.abbreviation()! + " boooya " + postLong.description)
            
            let postLatRoundedToNearestTen = 10 * Int((postLatDOUBLE / 10.0).rounded())
            
            
            let postLatRegionWithDecimal = String(round(Double(postLatRoundedToNearestTen)))
            
            let postLatRegionNODecimal = postLatRegionWithDecimal.replacingOccurrences(of: ".", with: "|", options: .literal, range: nil)

            
            
            //Bubbles are not used in the current version of app
           /*
            
            let postBubbles:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "bubble1":addedBubbles[0].toFBObject()as AnyObject,
                "bubble2":addedBubbles[1].toFBObject() as AnyObject,
                "bubble3":addedBubbles[2].toFBObject() as AnyObject,
                "bubble4":addedBubbles[3].toFBObject() as AnyObject,
                "bubble5":addedBubbles[4].toFBObject() as AnyObject,
                
                
                ]
            */
            
            let postSpecs = postSpecDetails(IsActive:true, HasBeenCleared:false,PostTime:postTime,
                                            PostRemovalTime:0, PostRemovalReason: 0, PostRemover: "")
           

           let ratingRanking =  -Double(Double(postTime + (1 * 1800)) / 1000000000);
            //let ratingRanking = Double(nan: "%.9f",  signaling: -((postTime + (1 * 1800)) / 1000000000))
            //let roundedValue1 = -(ratingRanking * 1000000000).rounded() / 1000000000
            
        //    let a = round(Double(ratingRanking * 1000000000)) / 1000000000
           // print("AAAAAAAAA"+ratingRanking.description)
            //print("BBBBBBB"+a.description)

          //messageranking is left empty because it's set when the first text is automatically written in the chat
            
            let post:[String : AnyObject] = [
                "postCreatorID":userID as AnyObject,
                "postText":postText as AnyObject,
                "postID":postID as AnyObject
                ,"postLat":fullLat as AnyObject
                ,"postLong":fullLong as AnyObject,
                 "postTime":postTime as AnyObject,
                 "postTimeInverse":(postTime * -1)as AnyObject,
                 "postUserName":userName as AnyObject,
                 "postType":postType as AnyObject,
                 "postDescription":postDesc as AnyObject,
                 "creatorName":userFullName as AnyObject,
                 "postLocations":postLocations as AnyObject,
                 "ratingBlend":1 as AnyObject,
                 "textCount":0 as AnyObject,
                 "messageRanking":0 as AnyObject,
                 "ratingRanking":ratingRanking as AnyObject,
                 "postVisibilityStartTime":postTime as AnyObject,
                 "postVisibilityEndTime":postVisEndTime as AnyObject,
                 "postBranch1":postTimeZone as AnyObject,
                 "postBranch2":postLatRegionNODecimal as AnyObject,
                 "postWasFlagged":false as AnyObject,
                 "postSpecs": postSpecs.toFBObject() as AnyObject,
                 "postVersionType":2 as AnyObject,
                  "postLocationString": "" as AnyObject,
             "postEventStartTime": 0 as AnyObject,
             "postEventEndTime": 0 as AnyObject,
                "postTimeDetailsString": "" as AnyObject

                
                
            
            ]
            //
            // This line was taken out. If something like this is needed in the future, it can be added back in or better yet, something better can be added:                                                       "postBubbles":postBubbles as AnyObject,
            
            
            ref?.child("userCreatedPosts").child(userID).child(postID).setValue(post);
            
            
            
      
            
           

            //ref?.child("Chats").child(userID).child(postID).child(chatPostRefID).setValue(chatPost)

            
            removeAnimate()
            
            
            
        }
        
        
        
    }
    
    /*
    func textView(_ txtvwPostText: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = txtvwPostText.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= 10 // Pass your character count here
    }
    */
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = txtvwPostText.text ?? ""
      

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
        
        
        if let univName = UserDefaults.standard.object(forKey: "Username") as? String{
            userName = univName
        }
        
        userFullName = (Auth.auth().currentUser?.displayName!)!
        userID = (Auth.auth().currentUser?.uid)!
    
        if((locationVariables.userLong != nil) && (locationVariables.userLat != nil)){
            
            uLat =  locationVariables.userLat
            uLong = locationVariables.userLong
        }
            else{
        if let userLat = UserDefaults.standard.object(forKey: "userLat") as? Double{
            uLat = userLat
        }
        if let userLong = UserDefaults.standard.object(forKey: "userLong") as? Double{
            uLong = userLong
        }
            }
        
        txtvwPostText.becomeFirstResponder()

        
        

        viewPopup.layer.cornerRadius = 12
        viewPopup.clipsToBounds = true
        viewPopup.layer.borderWidth = 1
        //viewPopup.layer.borderColor = #colorLiteral(red: 0.9750739932, green: 0.9750967622, blue: 0.9750844836, alpha: 1)
        
        viewPopup.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)

        
        if(uLat != 200.0 && uLong != 200.0){
            //Full, unedited latitude and longitude
            
            fullLat = uLat
            fullLong = uLong
            
            
            //postLat and postLong are used for the location boxes
         /*   postLat = Double(floor(100*uLat)/100)
            postLong = Double(floor(100*uLong)/100)
 */
            postLat = Double(floor(10*uLat)/10)
            postLong = Double(floor(10*uLong)/10)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    func hihi() -> Void {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier:"createDetailedPostViewController") {
            
            vc.modalTransitionStyle   = .crossDissolve;
            vc.modalPresentationStyle = .overCurrentContext
            
            self.present(vc, animated: true, completion: nil)
        }
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
        //Checks for banned terms
        var myStringArr = postText.lowercased().components(separatedBy: " ")

        var elements = ["obama", "trump", "suicide", "9/11", "clinton", "nigger", "niggers", "jews","nigga", "death", "cunt", "republican", "democrat", "liberal", "conservative", "chink"]
        
        var isValid = true
        var bannedWordString:String
        
        
        for item in myStringArr {
            // Do this
            
            if elements.contains(item) {
                print("Array contains 3")
                
                isValid = false
                bannedWordString = item
                print("word: " + item)
                
                
                
                let refreshAlert = UIAlertController(title: "Banned Word", message:  "Do not use: " + bannedWordString, preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                   
//bubble closes without returning true
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
/*
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
        
        */
    }
    
    
    
    
    @objc func tapOnText1(_ gestureRecognizer: UITapGestureRecognizer) {
   
        let textContollerPopover = storyboard?.instantiateViewController(withIdentifier: "createDetailedPostTextPopoverViewController") as! createDetailedPostTextPopoverViewController
        
        //   savingsInformationViewController.delegate = self
        textContollerPopover.mDelegate = self
        textContollerPopover.textBoxNum = 1
        textContollerPopover.txtTextboxText = txtDetailedText.text

        textContollerPopover.modalPresentationStyle = .overFullScreen
        if let popoverController = textContollerPopover.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = view.bounds
            //popoverController.permittedArrowDirections = .anyany
            popoverController.delegate = self as! UIPopoverPresentationControllerDelegate
        }
        present(textContollerPopover, animated: true, completion: nil)

    }
    
    @objc func tapOnText2(_ gestureRecognizer: UITapGestureRecognizer) {
        
        let textContollerPopover = storyboard?.instantiateViewController(withIdentifier: "createDetailedPostTextPopoverViewController") as! createDetailedPostTextPopoverViewController
        
        //   savingsInformationViewController.delegate = self
        textContollerPopover.mDelegate = self
        textContollerPopover.textBoxNum = 2
        textContollerPopover.txtTextboxText = txtDetailedDescription.text

        
        textContollerPopover.modalPresentationStyle = .overFullScreen
        if let popoverController = textContollerPopover.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = view.bounds
            //popoverController.permittedArrowDirections = .anyany
            popoverController.delegate = self as! UIPopoverPresentationControllerDelegate
        }
        present(textContollerPopover, animated: true, completion: nil)
        
    }
    
    @objc func tapOnText3(_ gestureRecognizer: UITapGestureRecognizer) {
        
        let textContollerPopover = storyboard?.instantiateViewController(withIdentifier: "createDetailedPostTextPopoverViewController") as! createDetailedPostTextPopoverViewController
        
        //   savingsInformationViewController.delegate = self
        textContollerPopover.mDelegate = self
        textContollerPopover.textBoxNum = 3
        textContollerPopover.txtTextboxText = txtDetailedTimeDetails.text

        textContollerPopover.modalPresentationStyle = .overFullScreen
        if let popoverController = textContollerPopover.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = view.bounds
            //popoverController.permittedArrowDirections = .anyany
            popoverController.delegate = self as! UIPopoverPresentationControllerDelegate
        }
        present(textContollerPopover, animated: true, completion: nil)
        
    }
    
    @objc func tapOnText4(_ gestureRecognizer: UITapGestureRecognizer) {
        
        let textContollerPopover = storyboard?.instantiateViewController(withIdentifier: "createDetailedPostTextPopoverViewController") as! createDetailedPostTextPopoverViewController
        
        //   savingsInformationViewController.delegate = self
        textContollerPopover.mDelegate = self
        textContollerPopover.textBoxNum = 4
        textContollerPopover.txtTextboxText = txtDetailedLocation.text

        textContollerPopover.modalPresentationStyle = .overFullScreen
        if let popoverController = textContollerPopover.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = view.bounds
            //popoverController.permittedArrowDirections = .anyany
            popoverController.delegate = self as! UIPopoverPresentationControllerDelegate
        }
        present(textContollerPopover, animated: true, completion: nil)
        
    }
    

}


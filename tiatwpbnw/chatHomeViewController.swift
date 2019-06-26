//
//  chatHomeViewController.swift
//  tiatwpbnw
//
//  Created by David A on 3/7/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase

protocol chatCustomDelegate{
    
    func reloadChatCollectionview()
    func removePost(sender : UIButton)
}

class chatHomeViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, chatCustomDelegate, UIGestureRecognizerDelegate, UIPopoverControllerDelegate {
    func reloadChatCollectionview() {
        self.collectionTexts.reloadData()
    }
    
    
    @IBOutlet weak var viewTopBar: UIView!
    func removePost(sender : UIButton) {

        let indexPath = collectionTexts.indexPathForView(view: sender)
        
        let cell = collectionTexts.cellForItem(at: indexPath as! IndexPath) as! chatHomeCollectionViewCell

        self.postChatList.remove(at: (indexPath?.row)!)
        
        
        self.collectionTexts.deleteItems(at: [indexPath!])


    }
    
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var postDetailView: GradientView!
    
    @IBOutlet weak var bottomTextView: UIView!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    
    var passedColor:UIColor!
    
    var userAccessLevel:String? = ""

    @IBOutlet weak var viewBottomBar: UIView!
    
    @IBAction func btnShowDetails(_ sender: Any) {
        /*
        let popOverVC = storyboard?.instantiateViewController(withIdentifier: "chatHomeEventPopoverViewController") as! chatHomeEventPopoverViewController
        
        
        self.addChildViewController(popOverVC)
        popOverVC.passedObject = passedObject
        
        
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
        
        
        */
        
        
        
        /*
        
              if(passedObject?.postType == "STANDARDDETAILEDPOSTIOS" || passedObject?.postType == "STANDARDDETAILEDPOSTANDROID" || passedObject?.postType == "STANDARDDETAILEDPOST"){
       
                let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "detailedPostViewController") as! detailedPostViewController
                
                //   savingsInformationViewController.delegate = self
                savingsInformationViewController.passedObject = passedObject
                
                savingsInformationViewController.modalPresentationStyle = .overFullScreen
                
                present(savingsInformationViewController, animated: true, completion: nil)
              
              }
        else{
        
        */
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "chatHomeEventPopoverViewController") as! chatHomeEventPopoverViewController
        
        //   savingsInformationViewController.delegate = self
        savingsInformationViewController.passedObject = passedObject
        
        savingsInformationViewController.modalPresentationStyle = .overFullScreen
   
        present(savingsInformationViewController, animated: true, completion: nil)
        
        //}
        
    }
    @IBOutlet weak var scrollMessageView: UIScrollView!
  
    @IBOutlet weak var btnNotePost: UIButton!

    @IBOutlet weak var lblPostAuthor: UILabel!
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postChatList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionTexts.frame.width  * 1 , height: 95)
        
    }
    
    
    @IBOutlet weak var txtChatText: UITextField!
    
    @IBAction func btnSend(_ sender: Any) {
        
      
        
    }
    @IBAction func btnGoBack(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)

    }
    
    @IBOutlet weak var collectionTexts: UICollectionView!
    
    
  /*
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
         let cell:chatHomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatHomeCollectionViewCell", for: indexPath) as! chatHomeCollectionViewCell
        

        return CGSize(width:collectionView.frame.width, height:   cell.lblMessageText.intrinsicContentSize.height)
        }
    
    */
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             let cell:chatHomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatHomeCollectionViewCell", for: indexPath) as! chatHomeCollectionViewCell
        
        
        if(postChatList[indexPath.row].postType == "CHATBANUPDATE"){
            
            
            cell.btnLikePostCell1.isHidden = true
            cell.btnRemovePostCell1.isHidden = true
            cell.lblPostUsernameCell1.isHidden = true
            cell.lblPostTextCell1.text = postChatList[indexPath.row].postText
            cell.layer.masksToBounds = true
           // cell.layer.cornerRadius = 8;
            cell.layer.borderWidth = 1
            //cell.layer.borderColor =  #colorLiteral(red: 1, green: 0.2483450174, blue: 0, alpha: 1)
            
            
        }else{
        cell.lblPostTextCell1.text = postChatList[indexPath.row].postText
            cell.btnLikePostCell1.addTarget(self, action: #selector(upFunc(sender:)), for: .touchUpInside)
            cell.btnLikePostCell1.tag = indexPath.row
            cell.lblPostUsernameCell1.text = postChatList[indexPath.row].postUserName
        
        if(userID == passedObject?.postCreatorID){
            if(userID != postChatList[indexPath.row].postCreatorID){
            //cell.btnRemovePostCell1.isHidden = false
                cell.btnRemovePostCell1.isHidden = true

            }
            else{
                cell.btnRemovePostCell1.isHidden = true

            }

            cell.btnRemovePostCell1.addTarget(self, action: #selector(posterPreferences(sender:)), for: .touchUpInside)
            cell.btnRemovePostCell1.tag = indexPath.row
        }
        else{
            cell.btnRemovePostCell1.isHidden = true

            
        }
        
        
            //cell.layer.borderColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 8;
            cell.layer.borderWidth = 1
            
      
    
            //If you wrote the post
           
         /*   else{
                cell.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)
                
            }
 */
            
            var strHasLikedPost = postChatList[indexPath.row].postID+":L"
            if(userID == postChatList[indexPath.row].postCreatorID){
                cell.layer.borderColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            }
            else{
            cell.layer.borderColor =  passedColor.cgColor
            }
            
            if userBoxLikeHistoryList.contains(strHasLikedPost) {
                print("LikedIt")
                print(strHasLikedPost)
                cell.btnLikePostCell1.tintColor = #colorLiteral(red: 0.2901960784, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                
                if(userID == postChatList[indexPath.row].postCreatorID){
                    
                }
                else{
                    
                }
            }
                
            else{
                print("Nothin")
                print(postChatList[indexPath.row].postID)
                cell.btnLikePostCell1.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            }
        
    
            
        }
            
            return cell

       
/*
           let cell:chatHomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatHomeCollectionViewCell", for: indexPath) as! chatHomeCollectionViewCell
        cell.lblMessageText.text = postChatList[indexPath.row].postText
        cell.btnLikePost.addTarget(self, action: #selector(upFunc(sender:)), for: .touchUpInside)
        cell.btnLikePost.tag = indexPath.row
        cell.lblPostUsername.text = postChatList[indexPath.row].postUserName
        */
      
    }
    
 

     
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let text = postChatList[indexPath.row].postText
        let author = postChatList[indexPath.row].postUserName
     let basicString = "blah blah blah blah blah blah blah blah"

  
        
        let defaultTextSize =  CGSize(width: collectionView.bounds.width, height:99)
     
        let combinedUserTextSize = text.height(withConstrainedWidth: collectionView.bounds.width, font: UIFont.systemFont(ofSize: 17.0)) + author.height(withConstrainedWidth: collectionView.bounds.width, font: UIFont.systemFont(ofSize: 17.0))
    if (combinedUserTextSize > 99)
        {
           return CGSize(width: collectionView.bounds.width, height: combinedUserTextSize)
        }
        
 
        return defaultTextSize
 


    }
    */

    
    @objc func upFunc(sender : UIButton){
        

        
        
        
        
            print(sender.tag)
      /*      let myIndexPath = IndexPath(row: sender.tag, section: 0)
            let cell = collectionTexts.cellForItem(at: myIndexPath) as! chatHomeCollectionViewCell
            */
            let myIndexPath = collectionTexts.indexPathForView(view: sender)
            let cell = collectionTexts.cellForItem(at: myIndexPath as! IndexPath) as! chatHomeCollectionViewCell
            
            var userRating = "L"
            
            if(cell.btnLikePostCell1.tintColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)){
                cell.btnLikePostCell1.tintColor = #colorLiteral(red: 0.2901960784, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                if userBoxLikeHistoryList.contains(postChatList[sender.tag].postID+":NL")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[sender.tag].postID+":NL")!)
                }
                userBoxLikeHistoryList.append((postChatList[sender.tag].postID+":L"))
                
            }
            else{
                cell.btnLikePostCell1.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                userRating = "NL"
                if userBoxLikeHistoryList.contains(postChatList[sender.tag].postID+":L")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[sender.tag].postID+":L")!)
                }
                userBoxLikeHistoryList.append((postChatList[sender.tag].postID+":NL"))
                //  cell.btnLikeText.backgroundColor =  UIColor.black.withAlphaComponent(0.8)
            }
            
            
            
            var commentID = postChatList[sender.tag].postID
            //  var postLink = "Users/"+(passedObject?.postCreatorID)!+"/POSTS/"+(passedObject?.postID)!+"/CHATS/"+commentID+"/RATINGBLEND"
            var postLink = "Chats/"+(passedObject?.postCreatorID)!+"/"+(passedObject?.postID)!+"/"+commentID+"/ratingBlend"
            
            let post:[String : AnyObject] = [
                "rating":userRating as AnyObject,
                "postLink":postLink as AnyObject,
                "postLocations":postChatList[sender.tag].postLocations?.toFBObject() as AnyObject,
                "likedUserID": Auth.auth().currentUser?.uid   as AnyObject,
                "postID":passedObject?.postID as AnyObject,
                "commentID":commentID as AnyObject
                
            ]
            ref?.child("CHATLIKESDISLIKES").child((passedObject?.postID)!).child(postChatList[sender.tag].postID).child("LDNOTES").child((Auth.auth().currentUser?.uid)!).setValue(post);
            
            
        
       
        
       
        
    }
    
    
    
    
    
    
    
    
    @objc func posterPreferences(sender : UIButton){
        print(sender.tag)
        let myIndexPath = collectionTexts.indexPathForView(view: sender)

        
       // let myIndexPath = collectionTexts.indexPathForView(view: sender)
        let cell = collectionTexts.cellForItem(at: myIndexPath as! IndexPath) as! chatHomeCollectionViewCell
        
        var commentID = postChatList[sender.tag].postID
        var posterID = postChatList[sender.tag].postCreatorID
        var posterName = postChatList[sender.tag].postUserName
        
       /* let popOverVC = storyboard?.instantiateViewController(withIdentifier: "posterProfileReviewPopupViewController") as! posterProfileReviewPopupViewController
        popOverVC.chatDelegate = self

        
        self.addChildViewController(popOverVC)
        popOverVC.passedObject = passedObject
        popOverVC.chatObject = postChatList[(myIndexPath?.row)!]
        popOverVC.passedPostID = commentID
        popOverVC.posterID = posterID
        popOverVC.posterName = posterName
        popOverVC.passedSender = sender

        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
        */
        
        let savingsInformationViewController = self.storyboard?.instantiateViewController(withIdentifier: "posterProfileReviewPopupViewController") as! posterProfileReviewPopupViewController
        
        //   savingsInformationViewController.delegate = self
       // savingsInformationViewController.passedStrikeNumber = uStrikes as! Int
        
        savingsInformationViewController.passedObject = passedObject
        savingsInformationViewController.chatObject = postChatList[(myIndexPath?.row)!]
        savingsInformationViewController.passedPostID = commentID
        savingsInformationViewController.posterID = posterID
        savingsInformationViewController.posterName = posterName
        savingsInformationViewController.passedSender = sender
        
        savingsInformationViewController.modalPresentationStyle = .popover
        if let popoverController = savingsInformationViewController.popoverPresentationController {
            //   popoverController.sourceView = sender
            //   popoverController.sourceRect = sender.bounds
            
            
            //popoverController.permittedArrowDirections = .anyany
          popoverController.delegate = self as! UIPopoverPresentationControllerDelegate
        }
        self.present(savingsInformationViewController, animated: true, completion: nil)
        
        print("uuu")
        print("uuu")
        print("uuu")
        print("uuu")
        print("uuu")
        print("uuu")
        print("uuu")
        print("uuu")
        print("uuu")
        print("uuu")
        print("uuu")
        print("uuu")
        print("uuu")
        print("uuu")
        print("uuu")

        
    }
    
    
    func scrollToLastItem() {
      
        let lastItem =   collectionView(self.collectionTexts!, numberOfItemsInSection: 0) - 1
        let indexPath: NSIndexPath = NSIndexPath.init(item: lastItem, section: 0)

        
        if(hasRunBottomWithoutAnimationOnce == false){
            collectionTexts?.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.top, animated: false)
            print("nah")

        }
        else{
            collectionTexts?.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.top, animated: true)
            print("yah")
        }
        
 
    }
    
    
    
    
    @objc func notePost(sender : UIButton){
        
    
        
        
        if(self.isPostObjectNoted){
            //If already noted, unnote
            self.btnNotePost.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)


            self.isPostObjectNoted = false
            
            ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).child((passedObject?.postID)!).setValue(nil);
            ref?.child("UsersNotedPostsIDList").child((Auth.auth().currentUser?.uid)!).child((passedObject?.postID)!).setValue(nil)

            //used when user is getting noted history for the box they're in
            
                }
        else{
            
            print("SIZE:  " + notedNumbers.numOfNotedPosts.description)
            print("SIZE: " + notedNumbers.numOfNotedPosts.description)
            print("SIZE: " + notedNumbers.numOfNotedPosts.description)
            print("SIZE: " + notedNumbers.numOfNotedPosts.description)
            print("SIZE: " + notedNumbers.numOfNotedPosts.description)
            print("SIZE: " + notedNumbers.numOfNotedPosts.description)
            
            if(notedNumbers.numOfNotedPosts > 19){
                
                
                let popOverVC = storyboard?.instantiateViewController(withIdentifier: "noteLimitPopoverViewController") as! noteLimitPopoverViewController
                self.addChildViewController(popOverVC)
                popOverVC.view.frame = self.view.frame
                self.view.addSubview(popOverVC.view)
                popOverVC.didMove(toParentViewController: self)
                
            }
                
            else{
            //If  unnoted, note
            self.btnNotePost.tintColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2156862745, alpha: 1)
             self.isPostObjectNoted = true
            
            var postObject = passedObject?.toFBObject()
            let postSpecs = postSpecDetails(IsActive:true, HasBeenCleared:false,PostTime:0,
                                            PostRemovalTime:0, PostRemovalReason: 0, PostRemover: "")
            
          
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "postNoterID":Auth.auth().currentUser?.uid as AnyObject,
                "postID":passedObject!.postID as AnyObject,
                "postLocations":passedObject!.postLocations?.toFBObject() as AnyObject,
                "postSpecs": postSpecs.toFBObject() as AnyObject
                
                
            ]
            
            ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).child((passedObject?.postID)!).setValue(postObject);
            ref?.child("UsersNotedPostsIDList").child((Auth.auth().currentUser?.uid)!).child((passedObject?.postID)!).setValue((passedObject?.postID)!)
            }
            }
       
        
    }
    
    
    
    

    var passedObject:postObject?
    let inputTextField = UITextField()
    var handle: DatabaseHandle?
    var userAccessHandle: DatabaseHandle?

    var ref:DatabaseReference?
    var postChatList:[postChatObject] = []
    var userBoxLikeHistoryList:[String] = []
    
    
    @IBOutlet weak var passedObjectText: UILabel!
    var latt: Double!
    var longg: Double!
    var postLong: Double!
    var postLat: Double!
    var creDate:String = ""
    var creNum:Int = 0
    var eventTypeNum = 0
    var userName: String!
    var isPostObjectNoted:Bool!
    var hasRunBottomWithoutAnimationOnce = false
    var delegate:aCustomDelegate?
    var chatDelegate:profileCustomDelegate?
    var userID:String!
    var passedIsPostObjectNotedInitialValue:Bool!
   var passedObjectIndex:Int!
    var passedWasFromProfileTab:Bool!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
   
     
        
      // self.postDetailView.gradientLayer.colors = [passedColor.cgColor, UIColor.black.cgColor]
        
     //  self.postDetailView.gradientLayer.gradient = GradientPoint.bottomToTop.draw()
        
        
 
 
        /*
        self.bottomTextView.layer.masksToBounds = true
        self.bottomTextView.layer.cornerRadius = 8;
        self.bottomTextView.layer.borderWidth = 0.25
        self.bottomTextView.layer.borderColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.bottomTextView.backgroundColor =  UIColor.black
*/
        
       
    }
    
    
  
    
    
    /*
    override func viewDidLayoutSubviews() {
     let lastItem =   collectionView(self.collectionTexts!, numberOfItemsInSection: 0) - 1
        let indexPath: NSIndexPath = NSIndexPath.init(item: lastItem, section: 0)
        collectionTexts?.scrollToItem(at: IndexPath(item: 3, section: 0), at: UICollectionViewScrollPosition.top, animated: false)


    }
    
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
 
        
        
       // setupInputComponents()
/*
        (self.tabBarController as! homeTabBar).centerButtonDisappear();
        (self.tabBarController as! homeTabBar).centerButtonDisappear();
        (self.tabBarController as! homeTabBar).centerButtonDisappear();
        
        */
        
        
        //Repitition for certainty that it works
        //It didn't work once so it will not work again

        ref = Database.database().reference()
        
        userID = Auth.auth().currentUser?.uid
        
        activityIndicator.center = self.view.center
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3);
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.color = passedColor
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        if let uAllowedAccessLevel = UserDefaults.standard.object(forKey: "userAccessLevel") as? String{
            userAccessLevel = uAllowedAccessLevel
        }
        else{
            
            userAccessLevel = "NORMAL"

        }
        
        
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            //self.view.gradientLayer.colors = [passedColor.cgColor, UIColor.black.cgColor,UIColor.black.cgColor,UIColor.black.cgColor,passedColor.cgColor]
            
         //   self.view.gradientLayer.gradient = GradientPoint.bottomToTop.draw()
            
          /*  let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            
            //self.bottomTextView.insertSubview(blurEffectView, at: 0)//if you have more UIViews, use an insertSubview API to place it where needed
            
            self.view.insertSubview(blurEffectView, at: 0)//if you have more UIViews, use an insertSubview API to place it where needed
            */
            viewTopBar.layer.backgroundColor = passedColor.cgColor
            viewBottomBar.layer.backgroundColor = passedColor.cgColor
        } else {
            // self.bottomTextView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.view.backgroundColor = passedColor
            
        }

        
      /*
         
         Button for
         
         NOTED POST
         
         Part 1
         
         The Second part is where the button is changed based on the state, it is later in this viewDidLoad
         
         
         
        let btn2 = UIButton(type: .custom)
       // btn2.setImage(UIImage(named: "down"), for: .normal)
        btn2.setTitle("note", for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(notePost(sender:)), for: .touchUpInside)
        btn2.titleLabel?.adjustsFontSizeToFitWidth = true
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.setRightBarButtonItems([item2], animated: true)

        */
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnBottomView(_:)))
        tap.delegate = self
        bottomTextView.addGestureRecognizer(tap)
        
        
        let customBackButton = UIBarButtonItem(image: UIImage(named: "backArrow") , style: .plain, target: self, action: #selector(backAction(sender:)))
        customBackButton.imageInsets = UIEdgeInsets(top: 2, left: -8, bottom: 0, right: 0)
        customBackButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.leftBarButtonItem = customBackButton

        
        
        btnNotePost.addTarget(self, action: #selector(notePost(sender:)), for: .touchUpInside)

        
        if let univName = UserDefaults.standard.object(forKey: "Username") as? String{
            userName = univName
        }
        
      // navBar.titleView?.tintColor = passedColor

       // self.title = passedObject?.creatorName
        passedObjectText.text = passedObject?.postText
      //  lblPostAuthor.text = passedObject?.postUserName
        
        
        /*
        NotificationCenter.default.addObserver(self, selector: #selector(chatHomeViewController.keyboardWillShow(notify:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(chatHomeViewController.keyboardWillHide(notify:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
*/
        
      
      
   
        
       // self.btnNote.addTarget(self, action: #selector(notePost), for: .touchUpInside)

        //    btn2.addTarget(self, action: #selector(Class.MethodName), for: .touchUpInside)


        
        var uLat:Double = 200.0
        var uLong:Double = 200.0
        
     
        
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
        
        ref?.child("deactivatedChat").child((passedObject?.postID)!).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value.debugDescription)
            if((snapshot.exists())){
                
                
                let refreshAlert = UIAlertController(title: "", message: "This post has been removed", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    self.navigationController?.popToRootViewController(animated: true)

                    
                }))
              
                
                self.present(refreshAlert, animated: true, completion: nil)
                
                
                


            }
            else{

            }
        })
       
        ref?.child("Users").child((passedObject?.postCreatorID)!).child("ActiveStatus").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value.debugDescription)
            if((snapshot.value as! String) == "INACTIVE"){
                
                
                let refreshAlert = UIAlertController(title: "", message: "This chat has been deactivated", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    self.navigationController?.popToRootViewController(animated: true)
                    
                    
                }))
                
                
                self.present(refreshAlert, animated: true, completion: nil)
                
                
                
                
                
            }
            else{
                
            }
        })
        
        
        
        
         
        ref?.child("UsersNotedPostsIDList").child((Auth.auth().currentUser?.uid)!).child((passedObject?.postID)!).observeSingleEvent(of: .value, with: { (snapshot) in
            print("snappy:" + snapshot.value.debugDescription)
            if((snapshot.exists())){

               self.isPostObjectNoted = true
                //btn2.setTitle("unNote", for: .normal)
                self.btnNotePost.tintColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2156862745, alpha: 1)

                
            }
            else{

                self.isPostObjectNoted = false
                self.btnNotePost.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

            }
        })
 
        
        
        
        ref?.child("LIKEDPOSTCHAT").child((passedObject?.postID)!).child((Auth.auth().currentUser?.uid)!).queryLimited(toLast: 350).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                let dataArray = Array(data)
                let keys = dataArray.map { $0.0 }
                let values = dataArray.map { $0.1 }
                self.userBoxLikeHistoryList = values.flatMap{String(describing: $0)}
                self.collectionTexts.reloadData()
                
                //  print(self.userBoxLikeHistoryList[0].description)
                
                
            }
        })
        
        
        
             ref?.child("ChatBanList").child((passedObject?.postCreatorID)!).child((passedObject?.postID)!).child((Auth.auth().currentUser?.uid)!).observe(.value) { (snapshot, key) in

      
            
            if(snapshot.exists()){
                print("ya")
                print("ya")
                print("ya")
                print("ya")
                print("ya")
                print("ya")
                print("ya")
                print("ya")
                
                
                let refreshAlert = UIAlertController(title: "You have been banned from this chat", message: " ", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    // self.navigationController?.popToRootViewController(animated: true)
                    self.navigationController?.popToRootViewController(animated: true)

                    
                }))
                
                self.present(refreshAlert, animated: true, completion: nil)

            }
            else{
                print("no")
                print("no")
                print("no")
                print("no")
                print("no")
                print("no")
                print("no")
                print("no")
                
                
                
           

            }

        }
        
   /*
        ref?.child("UsersNotedPostsNumber").child((Auth.auth().currentUser?.uid)!).observe(DataEventType.value, with: { (snapshot) in
            
            
            if(snapshot.exists()){
                
                self.favoriteBoardNumber = snapshot.value as! Int
                print("FAVNUM: " + self.favoriteBoardNumber.description)
                print("FAVNUM: " + self.favoriteBoardNumber.description)
                print("FAVNUM: " + self.favoriteBoardNumber.description)
                print("FAVNUM: " + self.favoriteBoardNumber.description)
                print("FAVNUM: " + self.favoriteBoardNumber.description)
                print("FAVNUM: " + self.favoriteBoardNumber.description)
                
            }
            
            
            
        })
        
        */
        
    //    ref?.child("Chats").child((passedObject?.postCreatorID)!).child((passedObject?.postID)!).queryOrdered(byChild: "postIsActive").queryEqual(toValue: true)
        
        
        handle = ref?.child("Chats").child((passedObject?.postCreatorID)!).child((passedObject?.postID)!).queryOrdered(byChild: "postIsActive").queryEqual(toValue: true).queryLimited(toLast: 350).observe(.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
                
                var isValidPost:Bool = true
                var postID:String? = ""
                var postCreatorID:String? = ""
                var postText:String? = ""
                var postUserName:String? = ""
                var postType:String? = ""
                var postDescription:String? = ""
                var postTime:CLong? = 0
                var postTimeInverse:CLong? = 0
                var creatorName:String? = ""

                var loc00:String? = ""
                var loc01:String? = ""
                var loc02:String? = ""
                var loc10:String? = ""
                var loc11:String? = ""
                var loc12:String? = ""
                var loc20:String? = ""
                var loc21:String? = ""
                var loc22:String? = ""
 
                var POstVisStartTime:CLong? = 0
                var POstVisEndTime:CLong? = 0

                
                var postLat:Double? = 0.0
                var postLong:Double? = 0.0
                
 

                self.activityIndicator.stopAnimating()
              
                
                if(dict["postID"] == nil){
                    isValidPost = false
                    print("postID")

                }
                else{
                    // postID = dict["postID"] as! String
                    
                    if dict["postID"] is String{
                        //everything about the value works.
                        postID = dict["postID"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE")

                    }
                }
                
                if(dict["postCreatorID"] == nil){
                    isValidPost = false
                    print("postCreatorID")

                }
                else{
                   // postCreatorID = dict["postCreatorID"] as! String
                    
                    if dict["postCreatorID"] is String{
                        //everything about the value works.
                        postCreatorID = dict["postCreatorID"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE1")

                    }
                }
                
                if(dict["postText"] == nil){
                    isValidPost = false
                    print("postText")

                }
                else{
                  //  postText = dict["postText"] as! String
                    
                    if dict["postText"] is String{
                        //everything about the value works.
                        postText = dict["postText"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE2")
                    }
                }
                
                if(dict["postUserName"] == nil){
                    isValidPost = false
                    print("postUserName")

                }
                else{
                    //postUserName = dict["postUserName"] as! String
                    
                    if dict["postUserName"] is String{
                        //everything about the value works.
                        postUserName = dict["postUserName"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE3")
                    }
                }
                
                if(dict["postType"] == nil){
                    isValidPost = false
                    
                    print("postType")

                }
                else{
                    //postType = dict["postType"] as! String
                    
                    if dict["postType"] is String{
                        //everything about the value works.
                        postType = dict["postType"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE4")
                    }
                }
                
                if(dict["postDescription"] == nil){
                    isValidPost = false
                    print("postDescription")

                }
                else{
                 //   postDescription = dict["postDescription"] as! String
                    
                    if dict["postDescription"] is String{
                        //everything about the value works.
                        postDescription = dict["postDescription"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE5")
                    }
                }
                
                if(dict["postTime"] == nil){
                    isValidPost = false
                    print("postTime")

                }
                else{
                   // postTime = dict["postTime"] as! CLong
                    
                    if dict["postTime"] is CLong{
                        //everything about the value works.
                        postTime = dict["postTime"] as! CLong
                    } else {
                        isValidPost = false
                        print("HERRRREEE6")
                    }
                }
                
                if(dict["postTimeInverse"] == nil){
                        isValidPost = false
                    print("postTimeInverse")

                    
                }
                else{
                    
                    if dict["postTimeInverse"] is CLong{
                        //everything about the value works.
                        postTimeInverse = dict["postTimeInverse"] as! CLong
                    } else {
                        isValidPost = false
                        print("HERRRREEE7")
                    }
                    
                  //  postTimeInverse = dict["postTimeInverse"] as! CLong
                }
                
                if(dict["creatorName"] == nil){
                    isValidPost = false
                    
                    print("creatorName")

                }
                else{
                    
                    if dict["creatorName"] is String{
                        //everything about the value works.
                        creatorName = dict["creatorName"] as! String
                    } else {
                        isValidPost = false
                        print("HERRRREEE8")
                    }
                }
                
                
                
                if(dict["postLocations"] == nil){
                    isValidPost = false
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
                    print("postVisibilityStartTime")

                }
                else{
                   // POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
                
                
                    if dict["postVisibilityStartTime"] is CLong{
                        //everything about the value works.
                        POstVisStartTime = dict["postVisibilityStartTime"] as! CLong

                    } else {
                        
                        
                        isValidPost = false
                        print("HERRRREEE18")
                        
                    }
                }
                
                if(dict["postVisibilityEndTime"] == nil){
                    isValidPost = false
                    
                    print("postVisibilityEndTime")

                }
                else{
                    
                    if dict["postVisibilityEndTime"] is CLong{
                        //everything about the value works.
                        POstVisEndTime = dict["postVisibilityEndTime"] as! CLong

                    } else {
                        
                        
                        isValidPost = false
                        print("HERRRREEE19")
                        
                        
                    }
                }
                
                if(dict["postLat"] == nil){
                    isValidPost = false
                    
                    print("postLat")

                }
                else{
                    
                    
                    if dict["postLat"] is Double{
                        //everything about the value works.
                        postLat = dict["postLat"] as! Double

                    } else {
                        
                        
                        isValidPost = false
                        print("HERRRREEE20")
                        
                    }
                }
                
                if(dict["postLong"] == nil){
                    isValidPost = false
                    
                    print("postLong")

                }
                else{
                    
                    if dict["postLong"] is Double{
                        //everything about the value works.
                        postLong = dict["postLong"] as! Double

                    } else {
                        

                        isValidPost = false
print("HERRRREEE21")
                        
                    }
                }
                
              /*
                let postCreatorID = dict["postCreatorID"] as! String
                
                //The thing missing from the posthome
                let postText = dict["postText"] as! String
                
                let postUserName = dict["postUserName"] as! String
                let postType = dict["postType"] as! String
                let postDescription = dict["postDescription"] as! String
                let postTime = dict["postTime"] as! CLong
                
                
                var postTimeInverse = dict["postTimeInverse"] as! CLong
                if(postTimeInverse.description.isEmpty){
                    
                    postTimeInverse = -postTime
                }
                
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
                */
                
                
                // let postLocations = dict["postLocations"]  as! postLocationsClass
                
                
         
                
            
               /*
                let POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
                let POstVisEndTime = dict["postVisibilityEndTime"] as! CLong
                
                let postLat = dict["postLat"] as! Double
                let postLong = dict["postLong"] as! Double
               */
                
                
                
                
             /*
                let postBranch1 = dict["postBranch1"] as! String
                let postBranch2 = dict["postBranch2"] as! String
              */
                
                
                // self.myList.append(titleText! as! String)
                
                
                
                
               
                
                if(isValidPost){
                    //If nothing is wrong, add to list
                    
                    let postLocations = postLocationsClass(Box00:loc00!, Box01:loc01!,Box02:loc02!,
                                                           Box10:loc10!,Box11:loc11!,Box12:loc12!,
                                                           Box20:loc20!,Box21:loc21!,Box22:loc22!)
                
                    var postChat = postChatObject(PostCreatorID:postCreatorID!,
                                                  PostText:postText!,
                                                  PostID:postID! ,
                                                  PostLat:postLat! ,
                                                  PostLong:postLong! ,
                                                  PostTime:postTime! , PostTimeInverse:postTimeInverse!,
                                                  PostUserName:postUserName! ,
                                                  PostType:postType! ,
                                                  PostDESCRIPTION:postDescription!,
                                                  CreatorName:creatorName!, PostLocations: postLocations )
                    
                    
                self.postChatList.append(postChat)
                //self.collectionComments.reloadData()
                self.collectionTexts.reloadData()
                    self.scrollToLastItem()

                }
                
                
                
                
            }
        })
        
        //animation for scrolling down
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) { // change 2 to desired number of seconds
            // Your code with delay
            self.hasRunBottomWithoutAnimationOnce = true
        }
        
        txtChatText.addTarget(nil, action:Selector(("firstResponderAction:")), for:.editingDidEndOnExit)
        txtChatText.returnKeyType = UIReturnKeyType.done
        txtChatText.maxLength = 100
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func backAction(sender: UIBarButtonItem) {
        // if noted post state is changed, reload
        if(isPostObjectNoted != passedIsPostObjectNotedInitialValue){
        delegate?.updateLikedList(passedPostID: (passedObject?.postID)!, passedPostisNotedValue: isPostObjectNoted)
            if(passedIsPostObjectNotedInitialValue){
                UserDefaults.standard.set(true , forKey: "resetOnAppear")
                chatDelegate?.updateNotedListProfileSide()
               // chatDelegate?.updateLikedListProfileSide(passedPostID:(passedObject?.postID)!, passedPostIndex: passedIndexPath)
            }
            navigationController?.popViewController(animated: true)

        }
        else{
        navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func tapOnBottomView(_ gestureRecognizer: UITapGestureRecognizer) {
      /*  let popOverVC = storyboard?.instantiateViewController(withIdentifier: "chatMessagePopoverViewController") as! chatMessagePopoverViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        popOverVC.postDelegate = self
        popOverVC.passedObject = self.passedObject
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
        */
      /*      vc.modalTransitionStyle   = .crossDissolve;
            vc.modalPresentationStyle = .overCurrentContext
            vc.passedO
            self.present(vc, animated: true, completion: nil)
        }
        */
        
       
        
        
        
        if(userAccessLevel == "ADMIN"){
            
            
            let refreshAlert = UIAlertController(title: "", message: "Choose One", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "ADMIN", style: .default, handler: { (action: UIAlertAction!) in
                
                let savingsInformationViewController = self.storyboard?.instantiateViewController(withIdentifier: "adminMakeCommentViewController") as! adminMakeCommentViewController
                
                //   savingsInformationViewController.delegate = self
                savingsInformationViewController.passedObject = self.passedObject
                
                savingsInformationViewController.modalPresentationStyle = .overFullScreen
                
                self.present(savingsInformationViewController, animated: true, completion: nil)
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Norm", style: .default, handler: { (action: UIAlertAction!) in
                
                let savingsInformationViewController = self.storyboard?.instantiateViewController(withIdentifier: "chatMessagePopoverViewController") as! chatMessagePopoverViewController
                
                //   savingsInformationViewController.delegate = self
                savingsInformationViewController.passedObject = self.passedObject
                
                savingsInformationViewController.modalPresentationStyle = .overFullScreen
                
                self.present(savingsInformationViewController, animated: true, completion: nil)
                
                
            }))
            
            
            self.present(refreshAlert, animated: true, completion: nil)
            
            
           
            
        }
        else{
            
            let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "chatMessagePopoverViewController") as! chatMessagePopoverViewController
            
            //   savingsInformationViewController.delegate = self
            savingsInformationViewController.passedObject = passedObject
            
            savingsInformationViewController.modalPresentationStyle = .overFullScreen
            
            present(savingsInformationViewController, animated: true, completion: nil)
            
            
        }
        
        
        
    }
    
/*
    func setupInputComponents() {
        
        
        
        
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sendButton)
        
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        sendButton.addTarget(self, action: #selector(self.sendUp(_:)), for: .touchUpInside)
        
        
        inputTextField.placeholder = "Enter message..."
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(inputTextField)
        
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.addTarget(nil, action:Selector(("firstResponderAction:")), for:.editingDidEndOnExit)
        inputTextField.returnKeyType = UIReturnKeyType.done
        inputTextField.maxLength = 100
        
        
        
        
    }
    */
    
    /*
    @IBAction func sendUp(_ sender: Any){
        let postTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
        
        let post1Ref = ref?.childByAutoId()
        let postID = "P"+(post1Ref?.key)!
        
        
        
        
        
        let post:[String : AnyObject] = [
            //"eventTitle":txtEventName.text! as AnyObject,
            "postCreatorID":Auth.auth().currentUser?.uid as AnyObject,
            "postText":inputTextField.text as AnyObject,
            "postID":postID as AnyObject
            ,"postLat":latt as AnyObject
            ,"postLong":longg as AnyObject,
             "postTime":postTime as AnyObject,
             "postUserName":userName as AnyObject,
             "postType":"CHATCOMMENT" as AnyObject,
             "postDescription":"NONE" as AnyObject,
             "creatorName":Auth.auth().currentUser?.displayName! as AnyObject,
             "ratingBlend":0 as AnyObject,
             "postLocations":passedObject!.postLocations?.toFBObject() as AnyObject,
             "postVisibilityStartTime":0 as AnyObject,
             "postVisibilityEndTime":0 as AnyObject,
             "postSpecs": passedObject?.postSpecs?.toFBObject() as AnyObject
            
        ]
        
        self.view.endEditing(true);
        
        //ref?.child("b").childByAutoId().setValue("yo")
        inputTextField.text = ""
        
        
        
        
       // ref?.child("Users").child((passedObject?.postCreatorID)!).child("POSTS").child((passedObject?.postID)!).child("CHATS").child(postID).setValue(post)
        
        ref?.child("Chats").child((passedObject?.postCreatorID)!).child((passedObject?.postID)!).child(postID).setValue(post)

        
        self.collectionTexts.reloadData()
        
        // self.collectionComments.reloadData()
        
    }
    
    */
    
    /*
    @objc func keyboardWillShow(notify: NSNotification){
       
        let popOverVC = storyboard?.instantiateViewController(withIdentifier: "chatMessagePopoverViewController") as! chatMessagePopoverViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
       
        

        
    }
    
    @objc func keyboardWillHide(notify: NSNotification){

        if let keyboardSize = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
         
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollMessageView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            })
            

            
        }
        
    }
    
    */
    
}

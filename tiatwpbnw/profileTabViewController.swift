//
//  profileTabViewController.swift
//  tiatwpbnw
//
//  Created by David A on 3/7/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
//import FirebaseDatabase
import SDWebImage

protocol profileCustomDelegate{
    
    func updateNotedListProfileSide()
    

}

class profileTabViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, profileCustomDelegate {
  //There are two different arrays here. One for history, one for noted posts. Keep track of which one you are working with at
    //each point
 
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var lblUserFullNamee: UILabel!
    @IBOutlet weak var lblUserNamee: UILabel!
    @IBOutlet weak var lblUserKarmaa: UILabel!
    
    @IBOutlet weak var lblCategoryDescription: UILabel!
    @IBOutlet weak var viewProfileSwitchView: UIView!
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblBackgroundText: UILabel!
    
    @IBOutlet weak var viewSplitter: UIView!
    var notedIsBlank:Bool = false
    var myPostsIsBlank:Bool = false
    


    
    func updateNotedListProfileSide() {
      
         if(segmentCategoryType == "noted")
         {
            
            loadNotedPosts()

            notedNumbers.numOfNotedPosts -= 1

      //  let myIndexPath = IndexPath(row: passedPostIndex, section: 0)
            
            

            
     //   let cell = collectionViewNotedPosts.cellForItem(at: myIndexPath) as! profileNotedPostsCollectionViewCell

            /*
            
        self.postChatListNoted.remove(at: passedPostIndex.row)
        
        self.collectionViewNotedPosts.deleteItems(at: [passedPostIndex])
            */
        
            
           /* self.postChatListNoted.remove(at: (indexPath?.row)!)
            
            
            self.collectionViewNotedPosts.deleteItems(at: [indexPath!])
        */
            
            
            loadNotedPosts()
            
        UserDefaults.standard.set(true , forKey: "resetOnAppear")
        }
        
        
    }
   
    @IBAction func btnGoToSettings(_ sender: Any) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "settingsTableViewController") as! settingsTableViewController
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    func sendModRequest() {
        
        let post:[String : AnyObject] = [
            //"eventTitle":txtEventName.text! as AnyObject,
            "postCreatorID":userID as AnyObject,
            "postLat":userLat as AnyObject
            ,"postLong":userLong as AnyObject,
             "creatorName":userFullName as AnyObject
        ]
        
        
        print("INVITEMOD")
        print("INVITEMOD")
        print("INVITEMOD")
        print("INVITEMOD")

        ref?.child("modRequests").child("freeRange").child(userID).setValue(post);
        
    }
    
    
   
    @IBOutlet weak var collectionViewNotedPosts: UICollectionView!
    
    @IBOutlet weak var segmentObj: UISegmentedControl!
    
    @IBAction func segmentAction(_ sender: Any) {
      
        switch segmentObj.selectedSegmentIndex{
        case 0:
            
            self.currentSegmentIndex = 0
            self.segmentCategoryType = "noted"

            loadNotedPosts()

            UIView.animate(withDuration: 0.5, animations: {
                // let segView =  self.view.viewWithTag(37) as! segmentFoundationUIView
                //self.segmentObj.tintColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
               // self.segmentObj.layer.borderColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                self.lblCategoryDescription.text = "Your Important Posts"
                self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1);                self.viewSplitter.backgroundColor =  #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)


              //  self.view.gradientLayer.colors = [ #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor,  UIColor.black.cgColor,  UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor]
                

               
                
                //self.view.gradientLayer.gradient = GradientPoint.topToBottom.draw()
            })
            
            print("Norm")
        case 1:
            self.currentSegmentIndex = 1
            self.segmentCategoryType = "history"
            self.lblCategoryDescription.text = "Posts you've made"


            loadCreationHistory()
            print("Chat")
            
            UIView.animate(withDuration: 0.5, animations: {
               // self.segmentObj.tintColor  = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1)
             //   self.view.gradientLayer.colors = [ #colorLiteral(red: 0.1535543799, green: 0.7279065251, blue: 0.6325533986, alpha: 1).cgColor, UIColor.black.cgColor,  UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, #colorLiteral(red: 0.1535543799, green: 0.7279065251, blue: 0.6325533986, alpha: 1).cgColor]
               // self.segmentObj.layer.borderColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1)
                self.lblCategoryDescription.text = "Posts you've made"

                self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.1535543799, green: 0.7279065251, blue: 0.6325533986, alpha: 1)
                self.viewSplitter.backgroundColor = #colorLiteral(red: 0.1535543799, green: 0.7279065251, blue: 0.6325533986, alpha: 1)
               // self.view.gradientLayer.gradient = GradientPoint.topToBottom.draw()
            })
            
            
        
            
        default:
            print("hi")
        }

        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if( self.notedIsBlank && segmentCategoryType == "noted" ){
            return CGSize(width:  self.collectionViewNotedPosts.frame.width * 0.98, height:  270)

        }
        else if( self.myPostsIsBlank && segmentCategoryType == "history"){
            
            return CGSize(width:  self.collectionViewNotedPosts.frame.width * 0.98, height:  270)

        }
        
        return CGSize(width:  self.collectionViewNotedPosts.frame.width  * 0.98, height:  135)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if( segmentCategoryType == "noted")
        {
            
            if( self.notedIsBlank ){
                return 1
            }
            else{
                
                print("SIZEE: "+postChatListNoted.count.description)
                print("SIZEE: "+postChatListNoted.count.description)
                print("SIZEE: "+postChatListNoted.count.description)
                print("SIZEE: "+postChatListNoted.count.description)
                print("SIZEE: "+postChatListNoted.count.description)
                print("SIZEE: "+postChatListNoted.count.description)
                print("SIZEE: "+postChatListNoted.count.description)

                
                return postChatListNoted.count
                
             
                
            }

        }
        else{
            
            
            if( self.myPostsIsBlank ){
                return 1
            }
            else{
                
                print("SIZEE: "+postChatListHistory.count.description)
                print("SIZEE: "+postChatListHistory.count.description)
                print("SIZEE: "+postChatListHistory.count.description)
                print("SIZEE: "+postChatListHistory.count.description)
                print("SIZEE: "+postChatListHistory.count.description)

                
                return postChatListHistory.count
             

            }
            

        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        //profileUserHistoryCollectionViewCell
        
        activityIndicator.stopAnimating()

           // cell.backgroundColor = UIColor.black
        
     
    
        
       if( segmentCategoryType == "noted")
       {
        
        if( self.notedIsBlank ){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteInfoCell", for: indexPath)
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 8;
            cell.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)

            cell.layer.borderWidth = 1
            
            return cell;

        }
        else{
            
         
            
            
               let cell:profileNotedPostsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellA", for: indexPath) as! profileNotedPostsCollectionViewCell
        cell.lblPostTitle.text = postChatListNoted[indexPath.row].postText

        cell.btnRemovePost.addTarget(self, action: #selector(tagUnPostFunction(sender:)), for: .touchUpInside)
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8;
         cell.layer.borderColor =  #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        cell.layer.borderWidth = 1
        
     
            cell.btnRemovePost.layer.masksToBounds = true
            cell.btnRemovePost.layer.cornerRadius = 8;
            cell.btnRemovePost.layer.borderColor =  #colorLiteral(red: 1, green: 0.2483450174, blue: 0, alpha: 1)
            cell.btnRemovePost.layer.borderWidth = 1
        
        cell.btnRemovePost.tag = indexPath.row
        cell.btnRemovePost.isHidden = false
        return cell;
        }
        }
       else{
        
        
        
        
        
        
        
        
        
        if( self.myPostsIsBlank ){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myPostsInfoCell", for: indexPath)
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 8;
            cell.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)

            cell.layer.borderWidth = 1
            
            return cell;
            
        }
        else{
        
               let cell:profileUserHistoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileUserHistoryCollectionViewCell", for: indexPath) as! profileUserHistoryCollectionViewCell
        cell.lblPostText.text = postChatListHistory[indexPath.row].postText
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8;
        cell.layer.borderColor =  #colorLiteral(red: 0.1505342424, green: 0.6830240157, blue: 0.5665099621, alpha: 1)
        cell.layer.borderWidth = 1
        
        
        if(postChatListHistory[indexPath.row].postSpecs?.isActive)!{
            cell.lblPostText1.text = "Active"
            cell.btnDeactivate.isHidden = false

        }
        else{
            cell.lblPostText1.text = "Inactive"
            cell.btnDeactivate.isHidden = true

        }

        cell.btnDeactivate.addTarget(self, action: #selector(deletePost(sender:)), for: .touchUpInside)
        
        return cell;
        }

        }

       
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        //let cell = eventsCollection.cellForItem(at: indexPath) as! myEventsCollectionViewCell
        // let currentCell = tableView.cellForRow(at: indexPath)! as! groupTitleCell
        
        
        //  let cell = collectionPosts.cellForItem(at: indexPath) as! HomePostCollectionViewCell
        
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "chatHomeViewController") as! chatHomeViewController
       // myVC.delegate = self
        myVC.chatDelegate = self
        
        var isNoted = false
        
        if( self.notedIsBlank || self.myPostsIsBlank ){
            
         
            
        }
        
        else{

        
        if(segmentCategoryType == "noted")
        {
            if postChatListNoted.contains(where: { postObject in postObject.postID == postChatListNoted[indexPath.row].postID }) {
                isNoted = true
            }
        }
        else{
            
            if postChatListNoted.contains(where: { postObject in postObject.postID == postChatListHistory[indexPath.row].postID }) {
                isNoted = true
            }
        }
        
        
        if(segmentCategoryType == "noted")
        {
            myVC.passedObject = postChatListNoted[indexPath.row]
            myVC.passedColor =  #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)


        }
        else{
            
            myVC.passedObject = postChatListHistory[indexPath.row]
            myVC.passedColor =  #colorLiteral(red: 0.1535543799, green: 0.7279065251, blue: 0.6325533986, alpha: 1)

            

        }

        myVC.passedObjectIndex = indexPath.row
            print(indexPath.row.description)
            print(indexPath.row.description)
            print(indexPath.row.description)
            print(indexPath.row.description)
            print(indexPath.row.description)
            print(indexPath.row.description)
            print(indexPath.row.description)
            print(indexPath.row.description)
            print(indexPath.row.description)
            print(indexPath.row.description)
            print(indexPath.row.description)
            print(indexPath.row.description)

        myVC.passedWasFromProfileTab = true
       // myVC.passedWasFromProfileTabNotedSection = true

        myVC.passedIsPostObjectNotedInitialValue = isNoted



        
        self.navigationController?.pushViewController(myVC, animated: true)
        
        }
        
        
        return true
    }
    
    
    
    
 
    @objc func funcMyPosts(_ sender: Any) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "userCreationHistoryViewController") as! userCreationHistoryViewController
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    @objc func funcMyBoard(_ sender: Any) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "notedPostsViewController") as! notedPostsViewController
        navigationController?.pushViewController(myVC, animated: true)
    }
   
    @IBOutlet weak var lblUserFullName: UILabel!
    

    var currentSegmentIndex:Int = 0

   
    
    var handle: DatabaseHandle?
    
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false

        
        userFullName = (Auth.auth().currentUser?.displayName!)!
        userID = (Auth.auth().currentUser?.uid)!


        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        
        self.lblUserFullNamee.text = userFullName

      
        if let waiveUsername = UserDefaults.standard.object(forKey: "Username") as? String{
            self.lblUserNamee.text = waiveUsername
        }
        if let userRating = UserDefaults.standard.object(forKey: "userRating") as? Int{
         
          //  self.lblUserKarmaa.text = "Karma: " + (userRating.description)
            self.userKarmaLevel = userRating
        }
        
        
        //Swipe gesture for left and right
        let swipeFromRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
        swipeFromRight.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeFromRight)
        
        let swipeFromLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight))
        swipeFromLeft.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeFromLeft)

        if(segmentCategoryType == "noted")
        {
            UIView.animate(withDuration: 0.5, animations: {
                
                self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                self.viewSplitter.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                self.loadNotedPosts()
                
            })
        }
        else{
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.1535543799, green: 0.7279065251, blue: 0.6325533986, alpha: 1);                self.viewSplitter.backgroundColor = #colorLiteral(red: 0.1535543799, green: 0.7279065251, blue: 0.6325533986, alpha: 1)
                self.loadCreationHistory()
                
            })
        }

        
        
    }
    
    
   /* func addNavBarImage() {
        
        let navController = navigationController!
        
        let image = #imageLiteral(resourceName: "tribaLogoTextNoShadowOnText")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        //imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    
    */
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated);
        //  menuButton.isHidden = true
        //menuButton.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        //self.view.viewWithTag(1119)?.isHidden = true
       
        
        //(self.tabBarController as! homeTabBar).centerButtonDisappear();
        
        
        //self.hidesBottomBarWhenPushed = false;
        //   (self.tabBarController as! CustomTabBarController).hideCenterButton();
        
    }
    
    var ref:DatabaseReference?
    
    var userLat: Double?
    var userLong:Double?
    var dateString:String = "a"
    var creDate:String = ""
    var creNum:Int = 0
    var segmentCategoryType:String = "noted"
    var karmaModQualifyingLevel = 10000000
    var userKarmaLevel:Int?
    var lastAccountRefreshDate:CLong?
    
    
    var postChatListHistory:[postObject] = []
    var postChatListNoted:[postObject] = []
    
    var userFullName = ""
    var userID = ""

    
    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var txtUsername: UILabel!
    
    
    func addleftIcon() {
      /*  let customBackButton = UIBarButtonItem(image: UIImage(named: "backArrow") , style: .plain, target: self, action: #selector(backAction(sender:)))
        customBackButton.imageInsets = UIEdgeInsets(top: 2, left: -8, bottom: 0, right: 0)
        customBackButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.rightBarButtonItem = customBackButton

*/
        
        /*let image = #imageLiteral(resourceName: "tribaSmallIcon1")
        let newBtn = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)        imageView.contentMode = .scaleAspectFit
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        */
        
       
        
        //self.navigationItem.leftItemsSupplementBackButton = true
    
        //self.navigationItem.leftBarButtonItems = [newBtn,anotherBtn]
    
        
        let navController = navigationController!
        
       // let image = #imageLiteral(resourceName: "tribaLogoTextNoShadowOnText")
        //let image = #imageLiteral(resourceName: "backgroundTextTriba")
        let image = #imageLiteral(resourceName: "tribaSmallIcon2")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        //imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        imageView.contentMode = .scaleAspectFit
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(imageView)
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: image , style: .plain, target: self, action: nil)
    
        navigationItem.titleView = imageView

}
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
       // addNavBarImage()
        //self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
       // self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addleftIcon()
        // self.showAnimate()
        
       // self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
       // self.showAnimate()
        
        userFullName = (Auth.auth().currentUser?.displayName!)!
        userID = (Auth.auth().currentUser?.uid)!
        
        ref = Database.database().reference()
        
        
        
        
       // view.sendSubview(toBack: viewBackground)

      //  self.view.gradientLayer.colors = [ #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor, UIColor.black.cgColor,  UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor]
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.2901960784, green: 0.2431372549, blue: 0.8039215686, alpha: 1)

        
      //  self.view.gradientLayer.gradient = GradientPoint.topToBottom.draw()


        self.lblCategoryDescription.text = "Your Important Posts"

        
        activityIndicator.center = self.view.center
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3);
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.color = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        self.tabBarController?.hidesBottomBarWhenPushed = true

        var uLat:Double = 200.0
        var uLong:Double = 200.0
        
        if let uLat = UserDefaults.standard.object(forKey: "userLat") as? Double{
            userLat = uLat
        }
        if let uLong = UserDefaults.standard.object(forKey: "userLong") as? Double{
            userLong = uLong
        }
        /*
        view.gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor, UIColor.blue.cgColor]
        
        view.gradientLayer.gradient = GradientPoint.rightLeft.draw()
     */
        
        
        
        if(uLat != 200.0 && uLong != 200.0){
            
          //  txtSecondarytext.text = uLat.description + "_" + uLong.description
            
            
        }
        
        
        // let button1 = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postText)) // action:#selector(Class.MethodName) for swift 3
        //self.navigationItem.rightBarButtonItem  = button1
        // self.navigationItem.rightBarButtonItem = button1
        
        
        ref = Database.database().reference()
        // btnMenu.target = revealViewController()
        //btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        let photoUrl:String = "https://graph.facebook.com/" + (Auth.auth().currentUser?.providerData[0].uid)! + "/picture?height=400";
        //txtUserName.text = String(  Date().timeIntervalSince1970 + 604800000 )
        
        let currentTime = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
        let date = NSDate(timeIntervalSince1970: TimeInterval(currentTime))
        let dayTimePeriodFormatter = DateFormatter()
        //dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
        dayTimePeriodFormatter.dateFormat = "Yd"
        dayTimePeriodFormatter.timeZone = NSTimeZone(name: TimeZone.current.abbreviation()!) as TimeZone!
        dateString = dayTimePeriodFormatter.string(from: date as Date)
        
       /*
        let imageUrl = URL(string: photoUrl)
        
        
        
        
        imgProfileImage.sd_setImage(with: imageUrl)
        // self.imageProfilePic.layer.cornerRadius = 10
        imgProfileImage.layer.cornerRadius = 12
        imgProfileImage.clipsToBounds = true
        imgProfileImage.layer.borderWidth = 2
        imgProfileImage.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)
*/
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "testBg")!)
        
        
        
        /*
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.sd_setImage(with: imageUrl)
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //view.addSubview(blurEffectView)
        self.view.insertSubview(blurEffectView, at: 1)
        
        */
       
        
        self.ref?.child("1A_TribaSystemData").child("karmaModLevel").observeSingleEvent(of: .value, with: { (snapshot) in
           

            if let item = snapshot.value as? Int{
               
                
                if(item != nil){
                    self.karmaModQualifyingLevel = item as! Int
                    
                    print("A")
                    print("A")
                    print("A")
                    print("A")

                    
                    if( self.karmaModQualifyingLevel < self.userKarmaLevel! ){
                        var userAccessL = ""
                        print("B")
                        print("B")
                        print("B")
                        print("B")

                        if let uAllowedAccessLevel = UserDefaults.standard.object(forKey: "userAccessLevel") as? String{
                            userAccessL = uAllowedAccessLevel
                        }
                        if(userAccessL == "NORMAL"){
                            print("C")
                            print("C")
                            print("C")
                            print("C")

                        self.sendModRequest()
                        }
                    }
                    
                }
                
                
            }})
        
        segmentCategoryType = "noted"

        
        
      //  ref?.child("UsersNotedPostsIDList").child(userID)
        ref?.child("UsersNotedPostsIDList").child(userID).observe(DataEventType.value, with: { (snapshot) in
            
            
            if(snapshot.exists()){
              
                    self.activityIndicator.stopAnimating()
                    self.notedIsBlank = false
                    self.collectionViewNotedPosts.reloadData()
                
                
                if let data = snapshot.value as? [String: Any] {
                    let dataArray = Array(data)
                    //the first va
                    let keys = dataArray.map { $0.0 }
                    
                    let values = dataArray.map { $0.1 }
                   
                    
                    notedNumbers.numOfNotedPosts = values.count
                    //  print(self.userBoxLikeHistoryList[0].description)
                    
                    
                }
                

                
                
            }
            else{
                self.activityIndicator.stopAnimating()
                self.notedIsBlank = true
                self.collectionViewNotedPosts.reloadData()


                
            }
            
            
            
        })
        self.ref?.child("Users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let item = snapshot.value as? [String: AnyObject]{
                let uName = item["userName"]
                let uRating = item["userRating"]
                let userFullName = item["userFullName"]


                
                
                //Switched username and full name labels because it looked better
               /* self.userKarmaLevel = uRating as! Int
                self.lblUserFullName.text = uName as? String
                self.txtUsername.text = userFullName as? String
                
                
                */
                if(item["userName"] == nil){

                    if let waiveUsername = UserDefaults.standard.object(forKey: "Username") as? String{
                        self.lblUserNamee.text = waiveUsername
                    }
                    else{
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "usernameCreateViewController")
                        self.present(newViewController, animated: true, completion: nil)                    }
                    
                    
                }
                else{
                    let userName = item["userName"] as? String
                    
                    self.lblUserNamee.text = userName as? String
                    
                }
                
                if(item["userRating"] == nil){
                    if let userRating = UserDefaults.standard.object(forKey: "userRating") as? Int{
                        
                       // self.lblUserKarmaa.text = "Karma: " + (userRating.description)
                        self.userKarmaLevel = userRating
                    }
                    else{
                       // self.lblUserKarmaa.text = "Karma: 0"
                        self.userKarmaLevel = 0
                        
                    }
                }
                else{
                    let uRating = item["userRating"]

                    self.userKarmaLevel = uRating as! Int
                  //  self.lblUserKarmaa.text = "Karma: " + (self.userKarmaLevel?.description)!

                }
                
                
                self.lblUserFullNamee.text = (Auth.auth().currentUser?.displayName!)!

              
                
            }
            else{
                self.txtUsername.text = ""
            }
        })
        
        
      loadNotedPosts()
        
        
        
    }
    

    
    func scrollToLastItemNotedPosts() {
        
        let lastItem =   collectionView(self.collectionViewNotedPosts!, numberOfItemsInSection: 0) - 1
        
        if(lastItem > 0){

        let indexPath: NSIndexPath = NSIndexPath.init(item: lastItem, section: 0)
        
        collectionViewNotedPosts?.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.top, animated: false)
        print("nah")
        }
        
       
        
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

  
    @objc func deletePost(sender : UIButton){
        
        let indexPath = collectionViewNotedPosts.indexPathForView(view: sender)
        
        let cell = collectionViewNotedPosts.cellForItem(at: indexPath as! IndexPath) as! profileUserHistoryCollectionViewCell
        
        
        
        /*
        let myIndexPath = IndexPath(row: sender.tag, section: 0)
        let cell = collectionViewNotedPosts.cellForItem(at: myIndexPath) as! profileUserHistoryCollectionViewCell
        */
        
        
        /*let cell:profileUserHistoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileUserHistoryCollectionViewCell", for: indexPath) as! profileUserHistoryCollectionViewCell
        */
     
        //indexPath.row?
        var pID = postChatListHistory[(indexPath?.row)!].postID
        var postSPecs = postChatListHistory[(indexPath?.row)!].postSpecs
        let currentTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
        
        let postSpecs:[String : AnyObject] = [
            "isActive":false as AnyObject,
            "hasBeenCleared":postSPecs?.hasBeenCleared as AnyObject,
            "postTime":postSPecs?.postTime as AnyObject,
            "postRemovalTime":currentTime as AnyObject,
            "postRemovalReason":0 as AnyObject,
            "postRemover":"selfRemoved" as AnyObject
            
            
        ]
        
        ref?.child("userCreatedPosts").child(userID).child(pID).child("postSpecs").setValue(postSpecs);
        ref?.child("reportedPostIndex").child(pID).child("postStatus").setValue("REMOVED")
        
        cell.lblPostText1.text = "inactive"
        cell.btnDeactivate.isHidden = true
        postChatListHistory[(indexPath?.row)!].postSpecs?.isActive = false
        
        //  ref?.child("reportedPostIndex").child(pID).child("count").setValue(nil);
        
        // ref?.child("reportedPostIndex").child(pID).child("reason").setValue(nil)
        
        
        /*
         if(cell.btnUpvote.backgroundColor == #colorLiteral(red: 0.9514281154, green: 0.9885231853, blue: 0.5498319268, alpha: 1) ){
         cell.btnUpvote.backgroundColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 0)
         cell.btnDownvote.backgroundColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 0)
         
         if userBoxLikeHistoryList.contains(postChatList[sender.tag].postID+":L")
         {
         userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[sender.tag].postID+":L")!)
         }
         //  userBoxLikeHistoryList.append((postChatList[sender.tag].postID+":N"))
         
         
         }
         */
        
        
        
        
        
        
    }
    
    


    
    
    @objc func tagUnPostFunction(sender : UIButton){
        
        /*
        let myIndexPath = IndexPath(row: sender.tag, section: 0)
        
        let cell = collectionViewNotedPosts.cellForItem(at: myIndexPath) as! profileNotedPostsCollectionViewCell
*/
        
        
        
        let indexPath = collectionViewNotedPosts.indexPathForView(view: sender)
    
        let cell = collectionViewNotedPosts.cellForItem(at: indexPath as! IndexPath) as! profileNotedPostsCollectionViewCell

        
        
        
        
      
            
            
            
            let refreshAlert = UIAlertController(title: "Un-note this post?", message: " ", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.ref?.child("notedPosts").child(self.userID).child(self.postChatListNoted[(indexPath?.row)!].postID).setValue(nil);
                self.ref?.child("UsersNotedPostsIDList").child(self.userID).child(self.postChatListNoted[(indexPath?.row)!].postID).setValue(nil)
                
                //used when user is getting noted history for the box they're in
                //self.ref?.child("notedPostsHistory").child((Auth.auth().currentUser?.uid)!).child(self.postChatList[sender.tag].postID).child("postSpecs").child("isActive").setValue(false);
                
                
                //THIS LINE MIGHT BE IMPORTANT, WRITTEN 6/2/18
                // sharedData.ModelData.bubbleLats.append(self.postChatList[sender.tag].postID)
                
                
                //Line from old way where object was used
                //  lstRemovedPosts.append(postChatList[sender.tag])
              
              //  self.lstRemovedPosts.append(self.postChatList[sender.tag].postID)
                
                
              //  self.postChatListNoted.remove(at: sender.tag)
                
                //removes from personal list on device
                self.postChatListNoted.remove(at: (indexPath?.row)!)
                self.collectionViewNotedPosts.deleteItems(at: [indexPath!])

                //sets reset when they go back to the explore tab 
                UserDefaults.standard.set(true , forKey: "resetOnAppear")
                
                notedNumbers.numOfNotedPosts -= 1
                
                
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            
            self.present(refreshAlert, animated: true, completion: nil)
            
            
            
            
        }
    
    
    @objc func didSwipeLeft(gesture: UIGestureRecognizer) {
        print("Left")
        print("Left")
        print("Left")
        print("Left")
        print("Left")
        print("Left")
        print("Left")
        print("Left")
        print("Left")
       // if(self.currentSegmentIndex < 3 )
        if(self.currentSegmentIndex == 0 ){
            self.segmentObj.selectedSegmentIndex = self.currentSegmentIndex + 1
            segmentObj.sendActions(for:  UIControlEvents.valueChanged)
            
          
        }
        
      
        
        
    }
    
    //Swipe gesture selector function
    @objc func didSwipeRight(gesture: UIGestureRecognizer) {
        // Add animation here
        print("Right")
        print("Right")
        print("Right")
        print("Right")
        print("Right")
        print("Right")
        print("Right")
        print("Right")
        
        if(self.currentSegmentIndex == 1 ){

            self.segmentObj.selectedSegmentIndex = self.currentSegmentIndex - 1
            segmentObj.sendActions(for:  UIControlEvents.valueChanged)
        }
        
      
        
        
    }
    


    
    func loadNotedPosts(){
        
        self.myPostsIsBlank = false

        
        
        let verifyClass = verifyPost()



        ref?.child("notedPosts").child(userID).removeAllObservers()
        ref?.child("userCreatedPosts").child(userID).removeAllObservers()

        postChatListNoted.removeAll()
        collectionViewNotedPosts.reloadData()
        
        
        print("RUNNOTESSSS: ")
        print("RUNNOTESSSS: ")
        print("RUNNOTESSSS: ")
        print("RUNNOTESSSS: ")
        print("RUNNOTESSSS: "+postChatListNoted.count.description)
        print("RUNNOTESSSS: ")
        print("RUNNOTESSSS: ")
        print("RUNNOTESSSS: ")
        print("RUNNOTESSSS: ")

        
        activityIndicator.color = #colorLiteral(red: 0.2901960784, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        activityIndicator.startAnimating()

        ref?.child("UsersNotedPostsIDList").child(userID).observe(DataEventType.value, with: { (snapshot) in
            
            
            if(snapshot.exists()){
               
                    self.activityIndicator.stopAnimating()
                    self.notedIsBlank = false
                    self.collectionViewNotedPosts.reloadData()
                
                
                if let data = snapshot.value as? [String: Any] {
                    let dataArray = Array(data)
                    //the first va
                    let keys = dataArray.map { $0.0 }
                    
                    let values = dataArray.map { $0.1 }
                    
                    
                    notedNumbers.numOfNotedPosts = values.count
                    //  print(self.userBoxLikeHistoryList[0].description)
                    
                    
                }

            

                
            }
            else{
                self.activityIndicator.stopAnimating()
                self.notedIsBlank = true
                self.collectionViewNotedPosts.reloadData()

            }
            
            
            
        })
        
        
        
        print("NOTESIZE: "+postChatListNoted.description)
        print("NOTESIZE: "+postChatListNoted.description)
        print("NOTESIZE: "+postChatListNoted.description)
        print("NOTESIZE: "+postChatListNoted.description)
        print("NOTESIZE: "+postChatListNoted.description)
        print("NOTESIZE: "+postChatListNoted.description)
        print("NOTESIZE: "+postChatListNoted.description)
        print("NOTESIZE: "+postChatListNoted.description)

        
        
        ref?.child("notedPosts").child(userID).queryLimited(toLast: 100).observe(.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
                
                
                
                var isValidPost = verifyClass.verifyPost(dict: dict)
                
                
                
                
                
                //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
                // self.myList.append(titleText! as! String)
                // self.postTypeList.append(postType as! String)
                //self.userIDList.append(postCreatorID as! String)
                
                
                if(isValidPost){
                    var postPost = verifyClass.createPost(dict: dict)
                    
                   
                        
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print(postPost.postVersionType.description)
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                       
                            if(!(postPost.postID == "UNAVAILABLE")){
                                
                                self.postChatListNoted.append(postPost)
                                self.collectionViewNotedPosts.reloadData()
                            }
                        
                    
                }
                
                
                
                //self.scrollToLastItem()
                
                /*
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
                 
                 //hihi
                 let postLat = dict["postLat"] as! Double
                 let postLong = dict["postLong"] as! Double
                 let ratingBlend = dict["ratingBlend"] as! CLong
                 let textCount = dict["textCount"] as! Int
                 
                 
                 let POstRemovalReason = specDic["postRemovalReason"] as! String
                 let POstRemover = specDic["postRemover"] as! String
                 
                 
                 let postBranch1 = dict["postBranch1"] as! String
                 let postBranch2 = dict["postBranch2"] as! String
                 
                 let postWasFlagged = dict["postWasFlagged"] as! Bool
                 
                 
                 */
                
                
                
            }
        })
       
    }
    
    func loadCreationHistory(){

    
        self.notedIsBlank = false

        //var userAllowedAccessDateInverse = 0
        
        
        
       // userLastAccountRefreshDateInverse
        
        
      /*  if let uAD = UserDefaults.standard.object(forKey: "userAllowedAccessDate") as? Int{
            userAllowedAccessDateInverse = uAD * -1
        }
        */
        ref?.child("userCreatedPosts").child(userID).removeAllObservers()
        ref?.child("notedPosts").child(userID).removeAllObservers()

        postChatListHistory.removeAll()
        collectionViewNotedPosts.reloadData()
        
        print("SIZEE: "+postChatListNoted.count.description)
        print("SIZEE: "+postChatListNoted.count.description)
        print("SIZEE: "+postChatListNoted.count.description)
        print("SIZEE: "+postChatListNoted.count.description)
        print("SIZEE: "+postChatListNoted.count.description)
        print("SIZEE: "+postChatListNoted.count.description)
        print("SIZEE: "+postChatListNoted.count.description)

        
        //activityIndicator.color = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1)
        activityIndicator.color =  #colorLiteral(red: 0.1505342424, green: 0.6830240157, blue: 0.5665099621, alpha: 1)
        activityIndicator.startAnimating()

        //        ref?.child("a").child(userID).observe(DataEventType.value, with: { (snapshot) in

        
        ref?.child("userCreatedPosts").child(userID).observe(DataEventType.value, with: { (snapshot) in
            
            
            if(snapshot.exists()){
              
                    self.activityIndicator.stopAnimating()
                    self.myPostsIsBlank = false
                    self.collectionViewNotedPosts.reloadData()
                    
                    
                    
                
                
                
            }
            else{
                self.activityIndicator.stopAnimating()
                self.myPostsIsBlank = true
                self.collectionViewNotedPosts.reloadData()
                
            }
            
            
            
        })
        
        let verifyClass = verifyPost()

        
        //  ref?.child("userCreatedPosts").child(userID).queryOrdered(byChild: "postTimeInverse").queryEnding(atValue:userAllowedAccessDateInverse).queryLimited(toLast: 350)
        
        //.queryEnding(atValue:userAllowedAccessDateInverse)
        ref?.child("userCreatedPosts").child(userID).queryOrdered(byChild: "postTimeInverse").queryLimited(toLast: 350).observe(.childAdded, with: { (snapshot) in
                //BETWEEN THERE
                
                /*  if let snapshotThatWillBeTurnedIntoDictNextLine = snapshot.value as? [String: AnyObject]{
                 let dict = snapshotThatWillBeTurnedIntoDictNextLine["postdata"] as! [String: AnyObject]
                 */
            if let dict = snapshot.value as? [String: AnyObject]{
                

                
                var isValidPost = verifyClass.verifyPost(dict: dict)
                
                
                
                
                
                //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
                // self.myList.append(titleText! as! String)
                // self.postTypeList.append(postType as! String)
                //self.userIDList.append(postCreatorID as! String)
                
                
                if(isValidPost){
                    var postPost = verifyClass.createPost(dict: dict)
                    
                    
                        
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print(postPost.postVersionType.description)
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                        print("BOOOOOYAAAA")
                    
                            if(!(postPost.postID == "UNAVAILABLE")){
                                
                                self.postChatListHistory.append(postPost)
                                self.collectionViewNotedPosts.reloadData()
                            }
                    
                    }
                
                
                
                
                //self.scrollToLastItem()
                
                /*
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
                 
                 //hihi
                 let postLat = dict["postLat"] as! Double
                 let postLong = dict["postLong"] as! Double
                 let ratingBlend = dict["ratingBlend"] as! CLong
                 let textCount = dict["textCount"] as! Int
                 
                 
                 let POstRemovalReason = specDic["postRemovalReason"] as! String
                 let POstRemover = specDic["postRemover"] as! String
                 
                 
                 let postBranch1 = dict["postBranch1"] as! String
                 let postBranch2 = dict["postBranch2"] as! String
                 
                 let postWasFlagged = dict["postWasFlagged"] as! Bool
                 
                 
                 */
                
                
                
            }
            })
 
    }
    
    
}

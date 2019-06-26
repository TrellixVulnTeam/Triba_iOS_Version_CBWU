//
//  tabHomeViewController.swift
//  tiatwpbnw
//
//  Created by David A on 3/6/18.
//  Copyright © 2018 David A. All rights reserved.
//
//
//Should like+note history be in functions and not in the viewDidLoad
//

import UIKit
import CoreLocation
import Firebase
//import FirebaseDatabase

protocol aCustomDelegate{
    func DoSomething()
    func goToUserAdvancedInfo()
    func loadNewUserPopover()
    func loadPostsRanking(passedBoxList:String)
    func loadPostsNormal(passedBoxList:String)
    func loadPostByChatCount(passedBoxList:String)
    func removeUNNotedPosts(passedNoteList:[String])
    func updateLikedList(passedPostID:String, passedPostisNotedValue:Bool)
}
// CLLocationManagerDelegate,
class tabHomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UITabBarControllerDelegate, aCustomDelegate, UIPopoverPresentationControllerDelegate, CAAnimationDelegate {
    
    
    @IBOutlet weak var viewBackgroundText: UIView!
    
    @IBOutlet weak var lblBackgroundText: UILabel!
    
    @IBOutlet weak var viewBarrier: UIView!
    
    
    
    func loadNewUserPopover() {
        /*
        let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "newUserTutorialViewController") as! newUserTutorialViewController
        self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        
        
        */
        
        print("cccccccccc")
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print(self.description)
        print("cccccccccc")

        
    }
    

    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    func goToUserAdvancedInfo(){
        let myVC = storyboard?.instantiateViewController(withIdentifier: "advancedUserInfoViewController") as! advancedUserInfoViewController
        navigationController?.pushViewController(myVC, animated: true)
        
        self.view.gradientLayer.colors = [ #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1).cgColor,  UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1).cgColor]
        
        
        // self.view.gradientLayer.colors = [ #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor,  #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1).cgColor, UIColor.black.cgColor,#colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1).cgColor, #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor]
        
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        self.view.gradientLayer.gradient = GradientPoint.topToBottom.draw()
    
    }
    
    
    @IBAction func btnRefresh(_ sender: Any) {
        

        
       // UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
        print("hihi")
      if(listOrderType == "normal"){
        loadBlockedUsers()

            loadPostsNormal(passedBoxList: boxListName)
        
        //collectionPosts.reloadItems(at: collectionPosts.indexPathsForVisibleItems)

        }
            
            
        else if(listOrderType == "rating"){
        loadBlockedUsers()

            loadPostsRanking(passedBoxList: boxListName)
        }
            
        else if(listOrderType == "textCount"){
        loadBlockedUsers()

            loadPostByChatCount(passedBoxList: boxListName)
        }
        else if(listOrderType == "closePosts"){
        loadBlockedUsers()

            loadPostByClose(passedBoxList: boxListName)
        }
        
 
    }
 
 
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pop = segue.destination as? orderChangeViewController {
            pop.delegate = self
            let popOverVC = storyboard?.instantiateViewController(withIdentifier: "orderChangeViewController") as! orderChangeViewController
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            
        }
    }
    
    @IBOutlet weak var imgLocationSet: UIImageView!
    var locationManager = CLLocationManager()
    var isLocEnabled = false
    var myList:[String] = []
    var postChatList:[postObject] = []
    
    var userIDList:[String] = []
    var userBoxLikeHistoryList:[String] = []

    
    @IBOutlet weak var lblOrderCategoryDescription: UILabel!
    
    var postTypeList:[String] = []
    var postHistoryList:[String] = []
    
    var uLat:Double = 200.0
    var uLong:Double = 200.0
    var postLong: Double!
    var postLat: Double!
    var boxListName:String = ""
    var listOrderType:String = "normal"
    var indexPathLastLocation = IndexPath(row: 0, section: 0)
    var appVersionNumber:Double = 0.01
    var isInSuperCloseMode:Bool = false
    
  //  var favoriteBoardNumber:Int = 0
    var currentSegmentIndex:Int = 0
    
    var userFullName = ""
    var userID = ""
    var userAccessLevel = "normal"

    var notedPostsListString:[String] = []
    var blockedUserIDList:[String] = []

    
    //var currentCells:[UICollectionViewCell] = []

    @IBOutlet weak var viewBottom: UIView!
    
    @IBOutlet weak var selectOrderSegmentObj: UISegmentedControl!
    
    @IBAction func selectOrderSegmentAction(_ sender: Any) {
        switch selectOrderSegmentObj.selectedSegmentIndex{
        case 0:
            self.currentSegmentIndex = 0
            self.lblOrderCategoryDescription.text = "Newest Posts"
            loadPostsNormal(passedBoxList: boxListName)
            UIView.animate(withDuration: 1, animations: {
               // let segView =  self.view.viewWithTag(37) as! segmentFoundationUIView
             //   self.selectOrderSegmentObj.tintColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
               // self.selectOrderSegmentObj.layer.borderColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                
                
                
                
                //A
               // self.view.gradientLayer.colors = [ #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor,  UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor]

                
               // self.view.gradientLayer.colors = [ #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor,  #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1).cgColor, UIColor.black.cgColor,#colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1).cgColor, #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor]

               // self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.537292241, green: 0.5, blue: 1, alpha: 1)
                self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                self.viewBarrier.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                self.view.gradientLayer.gradient = GradientPoint.topToBottom.draw()
            })
            
            print("Norm")
        case 1:
            self.currentSegmentIndex = 1
            self.lblOrderCategoryDescription.text = "Post With The Most Replies"
            //            self.lblOrderCategoryDescription.text = "Popular Conversations"

            loadPostByChatCount(passedBoxList: boxListName)
            print("Chat")
            
            UIView.animate(withDuration: 1, animations: {
                
                
              //  self.selectOrderSegmentObj.tintColor  = #colorLiteral(red: 0.1505342424, green: 0.6830240157, blue: 0.5665099621, alpha: 1)
                
                
                //A
                //self.view.gradientLayer.colors = [ #colorLiteral(red: 0.1490196078, green: 0.6823529412, blue: 0.5647058824, alpha: 1).cgColor,    UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, #colorLiteral(red: 0.1505342424, green: 0.6830240157, blue: 0.5665099621, alpha: 1).cgColor]
                
                
                
                
              //  self.selectOrderSegmentObj.layer.borderColor = #colorLiteral(red: 0.1505342424, green: 0.6830240157, blue: 0.5665099621, alpha: 1)
                /*self.selectOrderSegmentObj.tintColor  = #colorLiteral(red: 0.1490196078, green: 0.8784313725, blue: 0.5647058824, alpha: 1)
                self.view.gradientLayer.colors = [ #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1).cgColor,  UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1).cgColor]
                 self.selectOrderSegmentObj.layer.borderColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1)
            */
                //self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1)
                self.viewBarrier.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.6823529412, blue: 0.5647058824, alpha: 1)
                self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.1490196078, green: 0.6823529412, blue: 0.5647058824, alpha: 1)
                self.view.gradientLayer.gradient = GradientPoint.topToBottom.draw()
            })
            
            
        case 2:
            self.currentSegmentIndex = 2
            self.lblOrderCategoryDescription.text = "Highest Rated Posts"

            loadPostsRanking(passedBoxList: self.boxListName)
            print("Rank")
            
            UIView.animate(withDuration: 1, animations: {
                
            //    self.selectOrderSegmentObj.tintColor  = #colorLiteral(red: 0.1370565295, green: 0.6085740924, blue: 1, alpha: 1)
                
               
                
                //A
               // self.view.gradientLayer.colors = [ #colorLiteral(red: 0.137254902, green: 0.6078431373, blue: 1, alpha: 1).cgColor,   UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, #colorLiteral(red: 0.1370565295, green: 0.6085740924, blue: 1, alpha: 1).cgColor]
               
                
                
                // self.selectOrderSegmentObj.layer.borderColor = #colorLiteral(red: 0.1370565295, green: 0.6085740924, blue: 1, alpha: 1)

                /*
                 self.selectOrderSegmentObj.tintColor  = #colorLiteral(red: 0.137254902, green: 0.7725490196, blue: 1, alpha: 1)
                 
                 self.view.gradientLayer.colors = [ #colorLiteral(red: 0.1370565295, green: 0.7736131549, blue: 1, alpha: 1).cgColor, UIColor.black.cgColor, UIColor.black.cgColor,  UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, #colorLiteral(red: 0.1370565295, green: 0.7736131549, blue: 1, alpha: 1).cgColor]
                 self.selectOrderSegmentObj.layer.borderColor = #colorLiteral(red: 0.1370565295, green: 0.7736131549, blue: 1, alpha: 1)

 */
               // self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.1370565295, green: 0.7736131549, blue: 1, alpha: 1)
                self.viewBarrier.backgroundColor = #colorLiteral(red: 0.137254902, green: 0.6078431373, blue: 1, alpha: 1)
                self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.137254902, green: 0.6078431373, blue: 1, alpha: 1)
                self.view.gradientLayer.gradient = GradientPoint.topToBottom.draw()
            })
            
        case 3:
            
            self.currentSegmentIndex = 3
            self.lblOrderCategoryDescription.text = "Only The Posts That Are Close By"
           // self.selectOrderSegmentObj.layer.borderColor = #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1).cgColor
            //self.selectOrderSegmentObj.tintColor = #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
            self.viewBarrier.backgroundColor = #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
            self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
            
            loadPostByClose(passedBoxList: boxListName)
            print("Close")
            
            UIView.animate(withDuration: 1, animations: {
               // self.selectOrderSegmentObj.tintColor  = #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
                
             //A
               //self.view.gradientLayer.colors =  [UIColor.black.cgColor,UIColor.black.cgColor,UIColor.black.cgColor,UIColor.black.cgColor,UIColor.black.cgColor,UIColor.black.cgColor,UIColor.black.cgColor,UIColor.black.cgColor,UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1).cgColor]
             
                
                
                //  self.selectOrderSegmentObj.layer.borderColor = #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
                //self.tabBarController?.tabBar.barStyle = #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)                self.viewBarrier.backgroundColor = #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
                //self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.8666666667, green: 0.5465580959, blue: 0.6777870328, alpha: 1)                self.view.gradientLayer.gradient = GradientPoint.topToBottom.draw()
            })
            
        default:
            print("hi")
        }

        
        
    }
    
    
    
    func DoSomething() {
        //Do whatever you want
self.collectionPosts.backgroundColor =  #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        

        
    }
    
    
 
    
    @IBOutlet weak var btnSearch: UIButton!
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        print(tabBarIndex.description)
        
        if tabBarIndex == 0 {
/*
            sharedData.ModelData.bubbleLats.count
            userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: sharedData.ModelData.bubbleLats[1]+":D")!)
            let cell = collectionPosts.cellForItem(at: myIndexPath) as! HomePostCollectionViewCell
            */

        
        }
    }
    
    
    
  
    
    
    
    
    
    
    @IBAction func btnLaunchPostMaker(_ sender: Any) {
        if isLocEnabled{
            // self.performSegue (withIdentifier: "gtPostHome", sender: self)
            
         /*   let popOverVC = storyboard?.instantiateViewController(withIdentifier: "notedPostsViewController") as! notedPostsViewController
            self.addChildViewController(popOverVC)
            popOverVC.delegate = self

            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            */
            
            
            
            let popOverVC = storyboard?.instantiateViewController(withIdentifier: "orderChangeViewController") as! orderChangeViewController
            self.addChildViewController(popOverVC)
            popOverVC.delegate = self
            popOverVC.passedVal = boxListName
            popOverVC.passedCurrentOrderType = listOrderType
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            
            
          
            
        }
        else{
            showLocationDisabledPopUp()
            
        }
        
 
        
    }
  
    
    

    
    var handle: DatabaseHandle?
    
    var ref:DatabaseReference?
    
    var userLat: Double?
    var userLong:Double?
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return postChatList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(postChatList[indexPath.row].postType == "STANDARDDETAILEDPOSTIOS" || postChatList[indexPath.row].postType == "STANDARDDETAILEDPOSTANDROID" || postChatList[indexPath.row].postType == "STANDARDDETAILEDPOST"){
            return CGSize(width:  self.collectionPosts.frame.width * 0.98, height:  200)

        }
        else{
            return CGSize(width:  self.collectionPosts.frame.width * 0.98, height:  135)
        }
        return CGSize(width:  self.collectionPosts.frame.width * 0.98 , height:  135)

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if(postChatList[indexPath.row].postType == "STANDARDDETAILEDPOSTIOS" || postChatList[indexPath.row].postType == "STANDARDDETAILEDPOSTANDROID" || postChatList[indexPath.row].postType == "STANDARDDETAILEDPOST"){
             let cell:home2DetailedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "home2DetailedCollectionViewCell", for: indexPath) as! home2DetailedCollectionViewCell
            
            cell.tag = indexPath.row
            
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 8;
            // cell.layer.borderColor =  #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
            cell.layer.borderWidth = 1
            
            cell.txtPostText.text = postChatList[indexPath.row].postText
            cell.txtSecondText.text = postChatList[indexPath.row].postTimeDetailsString
            cell.txtThirdText.text = postChatList[indexPath.row].postLocationString
            
            cell.btnNote.addTarget(self, action: #selector(tagPostFunction(sender:)), for: .touchUpInside)
            cell.btnNote.tag = indexPath.row
            
            cell.btnUpVote.addTarget(self, action: #selector(upFunc(sender:)), for: .touchUpInside)
            cell.btnUpVote.tag = indexPath.row
            
            cell.btnReport.addTarget(self, action: #selector(reportFunc(sender:)), for: .touchUpInside)
            cell.btnReport.tag = indexPath.row
            cell.btnDownVote.addTarget(self, action: #selector(downFunc(sender:)), for: .touchUpInside)
            cell.btnDownVote.tag = indexPath.row
            
            
            cell.btnViewPost.addTarget(self, action: #selector(removeBlur(sender:)), for: .touchUpInside)
            
            
            if(postChatList[indexPath.row].postWasFlagged){
                /* let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
                 let blurEffectView = UIVisualEffectView(effect: blurEffect)
                 blurEffectView.frame = cell.blurredView.bounds
                 blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                 cell.blurredView.addSubview(blurEffectView)
                 */
                
                cell.viewPostWasBlocked.isHidden = false
                
            }
            else{
                cell.viewPostWasBlocked.isHidden = true
                
            }

            
            if(listOrderType == "normal"){
                //  cell.backgroundColor =   #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                cell.layer.borderColor =  #colorLiteral(red: 0.2901960784, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                
                cell.btnReport.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.txtPostText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                
                print("NORM")
                print(listOrderType)
                print(listOrderType)
                print(listOrderType)
                print(listOrderType)
                print(listOrderType)
                print(listOrderType)
                
            }
                
                
            else if(listOrderType == "rating"){
                //cell.backgroundColor =   #colorLiteral(red: 0.1370565295, green: 0.6085740924, blue: 1, alpha: 1)
                cell.layer.borderColor =  #colorLiteral(red: 0.1370565295, green: 0.6085740924, blue: 1, alpha: 1)
                
                cell.btnReport.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.txtPostText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                
                print("Rating")
                print(listOrderType)
                print(listOrderType)
                print(listOrderType)
                print(listOrderType)
                print(listOrderType)
                
                
            }
                
            else if(listOrderType == "textCount"){
                cell.layer.borderColor =  #colorLiteral(red: 0.1490196078, green: 0.6823529412, blue: 0.5647058824, alpha: 1)
                
                cell.txtPostText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.btnReport.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                
                print("COUNT")
                print(listOrderType)
                print(listOrderType)
                print(listOrderType)
                print(listOrderType)
                
                
            }
            else if(listOrderType == "closePosts"){
                cell.layer.borderColor =  #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
                
                cell.btnReport.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.txtPostText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                print("CLose")
                print(listOrderType)
                print(listOrderType)
                print(listOrderType)
                print(listOrderType)
                print(listOrderType)
                
                
            }
            
            
            
            var strHasLikedPost = postChatList[indexPath.row].postID+":L"
            var strHasDislikedPost = postChatList[indexPath.row].postID+":D"
            var strHasSuperLikedPost = postChatList[indexPath.row].postID+":LL"
            var strHasSuperDislikedPost = postChatList[indexPath.row].postID+":DD"
            
            
            /*print("LIKEDITLIKEDITLIKEDIT"+strHasLikedPost)
             print("LIKEDITLIKEDITLIKEDIT"+strHasLikedPost)
             
             */
            
            
            
            
            
            
            if notedPostsListString.contains(postChatList[indexPath.row].postID){
                cell.btnNote.tintColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2156862745, alpha: 1)
            }
            else{
                cell.btnNote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            }
            
            
            
            
            if userBoxLikeHistoryList.contains(strHasLikedPost) {
                print("LikedIt")
                cell.btnUpVote.tintColor =   #colorLiteral(red: 0.1102850065, green: 0.6799504757, blue: 0.4359227419, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            }
            else if userBoxLikeHistoryList.contains(strHasDislikedPost) {
                print("Disliked it")
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                
                
            }
            else if userBoxLikeHistoryList.contains(strHasSuperLikedPost) {
                print("Superliked it")
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 0.1098039216, green: 0.6784313725, blue: 0.4352941176, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            }
            else if userBoxLikeHistoryList.contains(strHasSuperDislikedPost) {
                print("SuperDisliked it")
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0, alpha: 1)
                
            }
            else{
                print("Nothin")
                
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                
                
            }
            
            
            cell.btnDownVote.addTarget(self, action: #selector(downFunc(sender:)), for: .touchUpInside)
            cell.btnDownVote.tag = indexPath.row
            

            return cell
            
        }
        else{
        
        
        let cell:home2CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "home2CollectionViewCell", for: indexPath) as! home2CollectionViewCell
        
        //cell.txtPostUsername.text = postChatList[indexPath.row].postUserName
        activityIndicator.stopAnimating()
        
        cell.tag = indexPath.row
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8;
        // cell.layer.borderColor =  #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        cell.layer.borderWidth = 1
        
        // cell.txtHomePostText.centerVertically()
        // centerVertically only ocassionally works. I can find something better.
        /*
         cell.layer.masksToBounds = true
         cell.layer.cornerRadius = 8;
         cell.layer.borderColor =  #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
         cell.layer.borderWidth = 2
         */
        
        
        
        
        
        /*
         cell.viewBottomGradient.layer.configureGradientBackground( UIColor.black.cgColor, UIColor.white.cgColor)
         */
        
        cell.txtPostTextlbl.text = postChatList[indexPath.row].postText
        
        let endDate = NSDate(timeIntervalSince1970: TimeInterval((postChatList[indexPath.row].postTime) - TimeZone.current.secondsFromGMT()  ))
        let template = "dMMM"
        let locale = NSLocale.current
        let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
       // dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
      //  dateFormatter.dateStyle = DateFormatter.Style. //Set date style
        dateFormatter.timeZone = TimeZone.current
        let localDate2 = dateFormatter.string(from: endDate as Date)
        
        cell.lblTime.text = localDate2
        
      
        /*
         if( postChatList[indexPath.row].postType == "STANDARDTEXT"){
         // cell.viewPostType.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
         //cell.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
         
         
         cell.txtPostTextlbl.text = postChatList[indexPath.row].postText
         
         
         // cell.txtPostTextlbl.text = postChatList[indexPath.row].ratingBlendInverse.description
         
         
         }
         else{
         // cell.viewPostType.backgroundColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1)
         // cell.backgroundColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1)
         }
         
         */
        cell.btnNotePost.addTarget(self, action: #selector(tagPostFunction(sender:)), for: .touchUpInside)
        cell.btnNotePost.tag = indexPath.row
        
        cell.btnUpVote.addTarget(self, action: #selector(upFunc(sender:)), for: .touchUpInside)
        cell.btnUpVote.tag = indexPath.row
        
        cell.btnReport.addTarget(self, action: #selector(reportFunc(sender:)), for: .touchUpInside)
        cell.btnReport.tag = indexPath.row
      cell.btnUnblockPost.addTarget(self, action: #selector(removeBlur(sender:)), for: .touchUpInside)
        
        
        if(postChatList[indexPath.row].postWasFlagged){
            /* let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
             let blurEffectView = UIVisualEffectView(effect: blurEffect)
             blurEffectView.frame = cell.blurredView.bounds
             blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
             cell.blurredView.addSubview(blurEffectView)
             */
            
          cell.viewPostFlagged.isHidden = false
            
        }
        else{
          cell.viewPostFlagged.isHidden = true
            
        }

        
        if(listOrderType == "normal"){
            //  cell.backgroundColor =   #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
            cell.layer.borderColor =  #colorLiteral(red: 0.2901960784, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
            
            cell.btnReport.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.txtPostTextlbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            
            print("NORM")
            print(listOrderType)
            print(listOrderType)
            print(listOrderType)
            print(listOrderType)
            print(listOrderType)
            print(listOrderType)
            
        }
            
            
        else if(listOrderType == "rating"){
            //cell.backgroundColor =   #colorLiteral(red: 0.1370565295, green: 0.6085740924, blue: 1, alpha: 1)
            cell.layer.borderColor =  #colorLiteral(red: 0.1370565295, green: 0.6085740924, blue: 1, alpha: 1)
            
            cell.btnReport.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.txtPostTextlbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            
            print("Rating")
            print(listOrderType)
            print(listOrderType)
            print(listOrderType)
            print(listOrderType)
            print(listOrderType)
            
            
        }
            
        else if(listOrderType == "textCount"){
            cell.layer.borderColor =  #colorLiteral(red: 0.1490196078, green: 0.6823529412, blue: 0.5647058824, alpha: 1)
            
            cell.txtPostTextlbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.btnReport.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            
            print("COUNT")
            print(listOrderType)
            print(listOrderType)
            print(listOrderType)
            print(listOrderType)
            
            
        }
        else if(listOrderType == "closePosts"){
            cell.layer.borderColor =  #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
            
            cell.btnReport.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.txtPostTextlbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            print("CLose")
            print(listOrderType)
            print(listOrderType)
            print(listOrderType)
            print(listOrderType)
            print(listOrderType)
            
            
        }
        
        
        
        var strHasLikedPost = postChatList[indexPath.row].postID+":L"
        var strHasDislikedPost = postChatList[indexPath.row].postID+":D"
        var strHasSuperLikedPost = postChatList[indexPath.row].postID+":LL"
        var strHasSuperDislikedPost = postChatList[indexPath.row].postID+":DD"
        
        
        /*print("LIKEDITLIKEDITLIKEDIT"+strHasLikedPost)
         print("LIKEDITLIKEDITLIKEDIT"+strHasLikedPost)
         
         */
        
        
        
        
        
        
        if notedPostsListString.contains(postChatList[indexPath.row].postID){
            cell.btnNotePost.tintColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2156862745, alpha: 1)
        }
        else{
            cell.btnNotePost.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
        }
        
        
        
        
        if userBoxLikeHistoryList.contains(strHasLikedPost) {
            print("LikedIt")
            cell.btnUpVote.tintColor =   #colorLiteral(red: 0.1102850065, green: 0.6799504757, blue: 0.4359227419, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
        }
        else if userBoxLikeHistoryList.contains(strHasDislikedPost) {
            print("Disliked it")
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            
            
        }
        else if userBoxLikeHistoryList.contains(strHasSuperLikedPost) {
            print("Superliked it")
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 0.1098039216, green: 0.6784313725, blue: 0.4352941176, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
        }
        else if userBoxLikeHistoryList.contains(strHasSuperDislikedPost) {
            print("SuperDisliked it")
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0, alpha: 1)
            
        }
        else{
            print("Nothin")
            
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            
            
        }
        
        
        cell.btnDownVote.addTarget(self, action: #selector(downFunc(sender:)), for: .touchUpInside)
        cell.btnDownVote.tag = indexPath.row
        
        return cell
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        //let cell = eventsCollection.cellForItem(at: indexPath) as! myEventsCollectionViewCell
        // let currentCell = tableView.cellForRow(at: indexPath)! as! groupTitleCell
        
        
        /*  let myVC = storyboard?.instantiateViewController(withIdentifier: "eventHomeViewController") as! eventHomeViewController
         myVC.passedEventID = myID[indexPath.row]
         myVC.passedPopView = "FROMMESSAGES"
         
         navigationController?.pushViewController(myVC, animated: true)
         */
    
        
        if(postChatList[indexPath.row].postType == "STANDARDDETAILEDPOSTIOS" || postChatList[indexPath.row].postType == "STANDARDDETAILEDPOSTANDROID" || postChatList[indexPath.row].postType == "STANDARDDETAILEDPOST"){
          /*  let cell:home2DetailedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "home2DetailedCollectionViewCell", for: indexPath) as! home2DetailedCollectionViewCell
            */
            let cell = collectionPosts.cellForItem(at: indexPath) as! home2DetailedCollectionViewCell
            
            var isNoted = false
            if(  cell.btnNote.tintColor == #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2156862745, alpha: 1)){
                isNoted = true
            }
            
            
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "chatHomeViewController") as! chatHomeViewController
            myVC.delegate = self
            
            myVC.passedObject = postChatList[indexPath.row]
            
            
            if(listOrderType == "normal"){
                //  cell.backgroundColor =   #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                myVC.passedColor =  #colorLiteral(red: 0.2901960784, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                
            }
                
                
            else if(listOrderType == "rating"){
                //cell.backgroundColor =   #colorLiteral(red: 0.1370565295, green: 0.6085740924, blue: 1, alpha: 1)
                myVC.passedColor =  #colorLiteral(red: 0.137254902, green: 0.6078431373, blue: 1, alpha: 1)
                
            }
                
            else if(listOrderType == "textCount"){
                myVC.passedColor =  #colorLiteral(red: 0.1490196078, green: 0.6823529412, blue: 0.5647058824, alpha: 1)
                
                
            }
            else if(listOrderType == "closePosts"){
                myVC.passedColor =  #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
                
                
                
            }
            
            
            myVC.passedWasFromProfileTab = true
            
            myVC.passedIsPostObjectNotedInitialValue = isNoted
            
            self.navigationController?.pushViewController(myVC, animated: true)
            
            
            
            
        }
        else{

            
        if(userAccessLevel == "ADMIN"){
            
            let refreshAlert = UIAlertController(title: "Remove Post", message: "reason: " + "political", preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "+R", style: .default, handler: { (action: UIAlertAction!) in
               
                let nuRating = self.postChatList[indexPath.row].ratingBlend + 15;
                
               // ref?.setValue(ra)
                let postCreatorID = self.postChatList[indexPath.row].postCreatorID
                let postIDDD = self.postChatList[indexPath.row].postID

                self.ref?.child("userCreatedPosts").child(postCreatorID).child(postIDDD).child("ratingBlend").setValue(nuRating);

            }))
            refreshAlert.addAction(UIAlertAction(title: "-R", style: .default, handler: { (action: UIAlertAction!) in
                
                
                let nuRating = self.postChatList[indexPath.row].ratingBlend - 15;
                
                // ref?.setValue(ra)
                let postCreatorID = self.postChatList[indexPath.row].postCreatorID
                let postIDDD = self.postChatList[indexPath.row].postID
                
                self.ref?.child("userCreatedPosts").child(postCreatorID).child(postIDDD).child("ratingBlend").setValue(nuRating);

                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "+M", style: .default, handler: { (action: UIAlertAction!) in
                
                let nuRating = self.postChatList[indexPath.row].textCount + 15;
                
                // ref?.setValue(ra)
                let postCreatorID = self.postChatList[indexPath.row].postCreatorID
                let postIDDD = self.postChatList[indexPath.row].postID
                
                self.ref?.child("userCreatedPosts").child(postCreatorID).child(postIDDD).child("textCount").setValue(nuRating);
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "-M", style: .default, handler: { (action: UIAlertAction!) in
                
                
                let nuRating = self.postChatList[indexPath.row].textCount - 15;
                
                // ref?.setValue(ra)
                let postCreatorID = self.postChatList[indexPath.row].postCreatorID
                let postIDDD = self.postChatList[indexPath.row].postID
                
                self.ref?.child("userCreatedPosts").child(postCreatorID).child(postIDDD).child("textCount").setValue(nuRating);
                
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "go", style: .default, handler: { (action: UIAlertAction!) in
                
                
                    
                let cell = self.collectionPosts.cellForItem(at: indexPath) as! home2CollectionViewCell
                    
                    var isNoted = false
                    if(  cell.btnNotePost.tintColor == #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2156862745, alpha: 1)){
                        isNoted = true
                    }
                    
                    
                    
                    let myVC = self.storyboard?.instantiateViewController(withIdentifier: "chatHomeViewController") as! chatHomeViewController
                    myVC.delegate = self
                    
                myVC.passedObject = self.postChatList[indexPath.row]
                    
                    
                if(self.listOrderType == "normal"){
                        //  cell.backgroundColor =   #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                        myVC.passedColor =  #colorLiteral(red: 0.2901960784, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
                        
                    }
                        
                        
                    else if(self.listOrderType == "rating"){
                        //cell.backgroundColor =   #colorLiteral(red: 0.1370565295, green: 0.6085740924, blue: 1, alpha: 1)
                        myVC.passedColor =  #colorLiteral(red: 0.137254902, green: 0.6078431373, blue: 1, alpha: 1)
                        
                    }
                        
                    else if(self.listOrderType == "textCount"){
                        myVC.passedColor =  #colorLiteral(red: 0.1490196078, green: 0.6823529412, blue: 0.5647058824, alpha: 1)
                        
                        
                    }
                    else if(self.listOrderType == "closePosts"){
                        myVC.passedColor =  #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
                        
                        
                        
                    }
                    
                    
                    myVC.passedWasFromProfileTab = true
                    
                    myVC.passedIsPostObjectNotedInitialValue = isNoted
                    
                    self.navigationController?.pushViewController(myVC, animated: true)
                    
                
                
                
                //self.removeAnimate()
                
                
            }))
            
            
            
            
            
            self.present(refreshAlert, animated: true, completion: nil)
            
            
            }
            else{
 
        let cell = collectionPosts.cellForItem(at: indexPath) as! home2CollectionViewCell
       
  var isNoted = false
        if(  cell.btnNotePost.tintColor == #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2156862745, alpha: 1)){
            isNoted = true
        }

       
       
        let myVC = storyboard?.instantiateViewController(withIdentifier: "chatHomeViewController") as! chatHomeViewController
        myVC.delegate = self

        myVC.passedObject = postChatList[indexPath.row]
        
        
        if(listOrderType == "normal"){
            //  cell.backgroundColor =   #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
             myVC.passedColor =  #colorLiteral(red: 0.2901960784, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
           
        }
            
            
        else if(listOrderType == "rating"){
            //cell.backgroundColor =   #colorLiteral(red: 0.1370565295, green: 0.6085740924, blue: 1, alpha: 1)
             myVC.passedColor =  #colorLiteral(red: 0.137254902, green: 0.6078431373, blue: 1, alpha: 1)
          
        }
            
        else if(listOrderType == "textCount"){
             myVC.passedColor =  #colorLiteral(red: 0.1490196078, green: 0.6823529412, blue: 0.5647058824, alpha: 1)
          
            
        }
        else if(listOrderType == "closePosts"){
             myVC.passedColor =  #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
          
            
            
        }
        
        
        myVC.passedWasFromProfileTab = true

        myVC.passedIsPostObjectNotedInitialValue = isNoted
        
    self.navigationController?.pushViewController(myVC, animated: true)

        }
        }
        
        return true
    }
   
  
    
    
    /*
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        //let cell = eventsCollection.cellForItem(at: indexPath) as! myEventsCollectionViewCell
        // let currentCell = tableView.cellForRow(at: indexPath)! as! groupTitleCell
        
        
        /*  let myVC = storyboard?.instantiateViewController(withIdentifier: "eventHomeViewController") as! eventHomeViewController
         myVC.passedEventID = myID[indexPath.row]
         myVC.passedPopView = "FROMMESSAGES"
         
         navigationController?.pushViewController(myVC, animated: true)
         */
        
        let cell = collectionPosts.cellForItem(at: indexPath) as! HomePostCollectionViewCell
        var passedUserRating = "NONE"
        if(cell.btnDownvote.backgroundColor == #colorLiteral(red: 0.9514281154, green: 0.9885231853, blue: 0.5498319268, alpha: 1)){
            
            passedUserRating = "DOWN"
        }
        else if (cell.btnUpvote.backgroundColor == #colorLiteral(red: 0.9514281154, green: 0.9885231853, blue: 0.5498319268, alpha: 1) ){
            passedUserRating = "UP"
            
        }
        
        cell.backgroundColor == #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
       // if( postTypeList[indexPath.row] == "CHAT"){
            
            //  gtChatHome
            
            
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "chatHomeViewController") as! chatHomeViewController
            myVC.passedObject = postChatList[indexPath.row]
            navigationController?.pushViewController(myVC, animated: true)
            
            
       // }
       /* else{
            
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "postHomeViewController") as! postHomeViewController
            myVC.passedObject = postChatList[indexPath.row]
            myVC.passedUserRating = passedUserRating
            navigationController?.pushViewController(myVC, animated: true)
        }
        */
        
        
        
        return true
    }

    
*/
    @IBOutlet weak var collectionPosts: UICollectionView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      // (self.tabBarController as! homeTabBar).tabBarVisible();
        self.tabBarController?.tabBar.isHidden = false
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        
        
        if(currentSegmentIndex == 0)
        {
            UIView.animate(withDuration: 0.5, animations: {
                
                self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.537292241, green: 0.5, blue: 1, alpha: 1)
                
            })
        }
       else if(currentSegmentIndex == 1)
        {
            UIView.animate(withDuration: 0.5, animations: {
                
                self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1)
                
            })
        }
        else if(currentSegmentIndex == 2)
        {
            UIView.animate(withDuration: 0.5, animations: {
                
                self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.1370565295, green: 0.7736131549, blue: 1, alpha: 1)
                
            })
        }
        else{
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.8666666667, green: 0.5465580959, blue: 0.6777870328, alpha: 1)
                
            })
        }

        ref?.child("UsersNotedPostsNumber").removeAllObservers()
        
        userFullName = (Auth.auth().currentUser?.displayName!)!
        userID = (Auth.auth().currentUser?.uid)!
        
        //observes the current number of posts the user has noted
       /* ref?.child("UsersNotedPostsNumber").child(userID).observe(DataEventType.value, with: { (snapshot) in
            
            
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
        
        
        //reloads when user returns
        ref?.child("UsersNotedPostsIDList").child(userID).queryLimited(toLast: 350).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            if(snapshot.exists()){
            if let data = snapshot.value as? [String: Any] {
                let dataArray = Array(data)
                //the first va
                let keys = dataArray.map { $0.0 }
                
                let values = dataArray.map { $0.1 }
                self.notedPostsListString.removeAll()
                self.notedPostsListString = values.flatMap{String(describing: $0)}
                print("SIZE:  " + self.notedPostsListString.count.description)
                print("SIZE: " + self.notedPostsListString.count.description)
                print("SIZE: " + self.notedPostsListString.count.description)
                print("SIZE: " + self.notedPostsListString.count.description)

                notedNumbers.numOfNotedPosts = values.count
                //  print(self.userBoxLikeHistoryList[0].description)
                
                
            }
            
        }
            else{
                self.notedPostsListString.removeAll()

                
            }
        })
        


        
        if let needsToReset = UserDefaults.standard.object(forKey: "resetOnAppear") as? Bool{
            if(needsToReset){
                

                
                
                if(listOrderType == "normal"){
                    loadBlockedUsers()

                    loadPostsNormal(passedBoxList: boxListName)
                }
                    
                    
                else if(listOrderType == "rating"){
                    loadBlockedUsers()

                    loadPostsRanking(passedBoxList: boxListName)
                }
                    
                else if(listOrderType == "textCount"){
                    loadBlockedUsers()

                    loadPostByChatCount(passedBoxList: boxListName)
                }
                else if(listOrderType == "closePosts"){
                    loadBlockedUsers()

                    loadPostByClose(passedBoxList: boxListName)
                }
                UserDefaults.standard.set(false , forKey: "resetOnAppear")

                
               
                
            }
        }
        
        addNavBarImage()

    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated);
        //  menuButton.isHidden = true
        //menuButton.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        //self.view.viewWithTag(1119)?.isHidden = true

        
        //self.hidesBottomBarWhenPushed = false;
        //   (self.tabBarController as! CustomTabBarController).hideCenterButton();
        
    }
    
    func addNavBarImage() {
        
        let navController = navigationController!
        let image = #imageLiteral(resourceName: "tribaSmallIcon1")
       // let image = #imageLiteral(resourceName: "tribaLogoTextNoShadowOnText")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        //imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // lblBackgroundText.setTextColorToGradient(image: #imageLiteral(resourceName: "backgroundTextTriba"))
       // viewBackgroundText.alpha = CGFloat(1.0)

    if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
            
      }
        
     
       // view.sendSubview(toBack: viewBackgroundText)

        
        activityIndicator.center = self.view.center
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3);
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.color = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
        
       
        
        //view.gradientLayer.colors = [ #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor,   UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor]
        
        //A
        //view.gradientLayer.colors = [ #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor,   #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor,  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor, #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1).cgColor]
        
       // self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.537292241, green: 0.5, blue: 1, alpha: 1)
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        //#colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        viewBarrier.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        self.lblOrderCategoryDescription.text = "Newest Posts"

      
      //  view.gradientLayer.gradient = GradientPoint.topToBottom.draw()

        
        //collectionPosts?.isPrefetchingEnabled = false

     /*
  view.gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
        
        view.gradientLayer.gradient = GradientPoint.rightLeft.draw()
       */

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
        
        
        // uLat = 40.109861002678
        // uLong = -88.2303859246549
        
        
        if(uLat != 200.0 && uLong != 200.0){
            //Full, unedited latitude and longitude
            
            var latStep2 = 0.0
            var longStep2 = 0.0
            
            
            //postLat and postLong are used for the location boxes
           /* postLat = Double(floor(100*uLat)/100)
            postLong = Double(floor(100*uLong)/100)
            */
            
            if(uLat > 0){
                 latStep2 = Double(floor(10*uLat)/10)

                
            }
            else{
              var positiveLat =   abs(uLat)
                 latStep2 = -1 * Double(floor(10*positiveLat)/10)

                
            }
            
            if(uLong > 0){
                 longStep2 = Double(floor(10*uLong)/10)
                
                
            }
            else{
                var positiveLong =   abs(uLong)
                 longStep2 = -1 * Double(floor(10*positiveLong)/10)
                
                
            }
           

        /*   let latStep2 = Double(floor(10*uLat)/10)
           let longStep2 = Double(floor(10*uLong)/10)
            
            */
            //This ensures that it's only one decimal. It sometimes does the .99999999999 thing
            postLat =   Double(String(format: "%.1f", latStep2))
            postLong =  Double(String(format: "%.1f", longStep2))
            
          
            
        }
        
 
        
        let userLocationBoxWithPeriods = String(postLat)+"_"+String(postLong)
         //let userLocationBoxWithPeriods = String(40.06)+"_"+String(88.28)
        let userLocationBox = userLocationBoxWithPeriods.replacingOccurrences(of: ".", with: "|", options: .literal, range: nil)
        boxListName = userLocationBox

        
        ref = Database.database().reference()
        
        
        //Swipe gesture for left and right
        let swipeFromRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
        swipeFromRight.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeFromRight)
        
        let swipeFromLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight))
        swipeFromLeft.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeFromLeft)

        
       
        if let uAllowedAccessLevel = UserDefaults.standard.object(forKey: "userAccessLevel") as? String{
            userAccessLevel = uAllowedAccessLevel
        }
        
        
        ref?.child("USERLIKELOC").child(userLocationBox).child(userID).queryLimited(toLast: 350).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                let dataArray = Array(data)
                //the first va
                let keys = dataArray.map { $0.0 }
                
                let values = dataArray.map { $0.1 }
                self.userBoxLikeHistoryList = values.flatMap{String(describing: $0)}
                
                //  print(self.userBoxLikeHistoryList[0].description)
                
                
            }
        })
        
    
        ref?.child("UsersNotedPostsIDList").child(userID).queryLimited(toLast: 350).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                let dataArray = Array(data)
                //the first va
                let keys = dataArray.map { $0.0 }
                
                let values = dataArray.map { $0.1 }
                self.notedPostsListString = values.flatMap{String(describing: $0)}
                
                notedNumbers.numOfNotedPosts = values.count
                
                print("SIZE:  " + notedNumbers.numOfNotedPosts.description)
                print("SIZE: " + notedNumbers.numOfNotedPosts.description)
                print("SIZE: " + notedNumbers.numOfNotedPosts.description)
                print("SIZE: " + notedNumbers.numOfNotedPosts.description)
                print("SIZE: " + notedNumbers.numOfNotedPosts.description)
                print("SIZE: " + notedNumbers.numOfNotedPosts.description)

                //  print(self.userBoxLikeHistoryList[0].description)
                
                
            }
        })
        
        
        ref?.child("blockedUIDs").child(userID).queryLimited(toLast: 350).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                let dataArray = Array(data)
                //the first va
                let keys = dataArray.map { $0.0 }
                
                let values = dataArray.map { $0.1 }
                self.blockedUserIDList = values.flatMap{String(describing: $0)}
                
         
                
                //  print(self.userBoxLikeHistoryList[0].description)
                
                
            }
        })
   
        loadBlockedUsers()
 
        loadPostsNormal(passedBoxList: userLocationBox)
        
        

        
        
    }
    
    
    
    func loadBlockedUsers(){
        self.blockedUserIDList.removeAll()

        ref?.child("blockedUIDs").child(userID).queryLimited(toLast: 350).observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                let dataArray = Array(data)
                //the first va
                let keys = dataArray.map { $0.0 }
               
                self.blockedUserIDList.removeAll()
                let values = dataArray.map { $0.1 }
                self.blockedUserIDList = values.flatMap{String(describing: $0)}
                
                
                
                //  print(self.userBoxLikeHistoryList[0].description)
                
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
      /*
        UserDefaults.standard.set(latt, forKey: "userLat")
        UserDefaults.standard.set(longg, forKey: "userLong")
        
        */
        
        
        print("userlat TAB part: " + locationVariables.userLat.description)
        print("userlong TAB part: " + locationVariables.userLong.description)
        
        
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
    
    
    
    
    @objc func reportFunc(sender : UIButton){
        
        let myIndexPath = collectionPosts.indexPathForView(view: sender)
        
        if(postChatList[(myIndexPath?.row)!].postType == "STANDARDDETAILEDPOSTIOS" || postChatList[(myIndexPath?.row)!].postType == "STANDARDDETAILEDPOSTANDROID" || postChatList[(myIndexPath?.row)!].postType == "STANDARDDETAILEDPOST"){
            let cell:home2DetailedCollectionViewCell = collectionPosts.dequeueReusableCell(withReuseIdentifier: "home2DetailedCollectionViewCell", for:  myIndexPath as! IndexPath) as! home2DetailedCollectionViewCell
            
            
            let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "reportPostPOPOVERViewController") as! reportPostPOPOVERViewController
            
            //   savingsInformationViewController.delegate = self
            savingsInformationViewController.passedObject = postChatList[(myIndexPath?.row)!]
            
            savingsInformationViewController.modalPresentationStyle = .overFullScreen
            if let popoverController = savingsInformationViewController.popoverPresentationController {
                popoverController.sourceView = sender
                popoverController.sourceRect = sender.bounds
                //popoverController.permittedArrowDirections = .anyany
                popoverController.delegate = self
            }
            present(savingsInformationViewController, animated: true, completion: nil)
            
        }
        else{

        let cell = collectionPosts.cellForItem(at: myIndexPath as! IndexPath) as! home2CollectionViewCell
   
   /*     let popOverVC = storyboard?.instantiateViewController(withIdentifier: "reportPostPOPOVERViewController") as! reportPostPOPOVERViewController
        self.addChildViewController(popOverVC)
        popOverVC.passedObject = postChatList[(myIndexPath?.row)!]
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
 */
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "reportPostPOPOVERViewController") as! reportPostPOPOVERViewController
        
     //   savingsInformationViewController.delegate = self
        savingsInformationViewController.passedObject = postChatList[(myIndexPath?.row)!]
        
        savingsInformationViewController.modalPresentationStyle = .overFullScreen
        if let popoverController = savingsInformationViewController.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
            //popoverController.permittedArrowDirections = .anyany
            popoverController.delegate = self
        }
        present(savingsInformationViewController, animated: true, completion: nil)
        
        }
        
    }
    
    
    @objc func upFunc(sender : UIButton){
        
       /* let myIndexPath = IndexPath(row: sender.tag, section: 0)
        let cell = collectionPosts.cellForItem(at: myIndexPath) as! HomePostCollectionViewCell
      */
        let myIndexPath = collectionPosts.indexPathForView(view: sender)
        
        
        if(postChatList[(myIndexPath?.row)!].postType == "STANDARDDETAILEDPOSTIOS" || postChatList[(myIndexPath?.row)!].postType == "STANDARDDETAILEDPOSTANDROID" || postChatList[(myIndexPath?.row)!].postType == "STANDARDDETAILEDPOST"){
            
            
            
     
            
               let cell = collectionPosts.cellForItem(at: myIndexPath as! IndexPath) as! home2DetailedCollectionViewCell
            
            print("UP")
            
            print("UP")
            print("UP")
            print("UP")
            print("UP")
            print("UP")
            print("UP")
            print("UP")
            print("UP")
            print("UP")

            
            
            
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
                
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
                }
                
                
                
                userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":-N"))
                
                let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
                let pID = postChatList[(myIndexPath?.row)!].postID
                
                let post:[String : AnyObject] = [
                    //"eventTitle":txtEventName.text! as AnyObject,
                    "rating":"-N" as AnyObject,
                    "postLink": uLink   as AnyObject,
                    "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                    "likedUserID": userID   as AnyObject,
                    "postID":pID as AnyObject
                    
                    
                    
                ]
                ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
                
                
            }
            else if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
                
                
                
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
                }
                
                
                
                
                
                userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":-N"))
                
                let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
                let pID = postChatList[(myIndexPath?.row)!].postID
                
                let post:[String : AnyObject] = [
                    //"eventTitle":txtEventName.text! as AnyObject,
                    "rating":"-N" as AnyObject,
                    "postLink": uLink   as AnyObject,
                    "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                    "likedUserID": userID  as AnyObject,
                    "postID":pID as AnyObject
                    
                    
                ]
                ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
                
                
                
                
            }
            else if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
                
                
                
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 0.1102850065, green: 0.6799504757, blue: 0.4359227419, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
                }
                
                
                
                
                userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":LL"))
                
                let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
                let pID = postChatList[(myIndexPath?.row)!].postID
                
                let post:[String : AnyObject] = [
                    //"eventTitle":txtEventName.text! as AnyObject,
                    "rating":"LL" as AnyObject,
                    "postLink": uLink   as AnyObject,
                    "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                    "likedUserID": userID   as AnyObject,
                    "postID":pID as AnyObject
                    
                    
                    
                ]
                ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
                
                
                
            }
            else if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
                
                
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 0.1102850065, green: 0.6799504757, blue: 0.4359227419, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                
                
                
                
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
                }
                
                
                
                
                userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":LL"))
                
                let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
                let pID = postChatList[(myIndexPath?.row)!].postID
                
                let post:[String : AnyObject] = [
                    //"eventTitle":txtEventName.text! as AnyObject,
                    "rating":"LL" as AnyObject,
                    "postLink": uLink   as AnyObject,
                    "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                    "likedUserID": userID  as AnyObject,
                    "postID":pID as AnyObject
                    
                    
                ]
                ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
                
            }
            else {
                
                
                
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 0.1102850065, green: 0.6799504757, blue: 0.4359227419, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
                }
                
                
                
                
                userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":L"))
                
                //ref?.child("userCreatedPosts").child((Auth.auth().currentUser?.uid)!).child(postID).child("postdata").setValue(post);
                
                
                let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
                let pID = postChatList[(myIndexPath?.row)!].postID
                
                let post:[String : AnyObject] = [
                    //"eventTitle":txtEventName.text! as AnyObject,
                    "rating":"L" as AnyObject,
                    "postLink": uLink   as AnyObject,
                    "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                    "likedUserID": userID   as AnyObject,
                    "postID":pID as AnyObject
                    
                    
                ]
                ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
                
                
            }
            
            
            
            
            
            
        }
        else{
        
        
        
        let cell = collectionPosts.cellForItem(at: myIndexPath as! IndexPath) as! home2CollectionViewCell
        
        
        
        
        
        
        
        if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
        {
            userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
           
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
            }
            
            
            
            userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":-N"))

            let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
            let pID = postChatList[(myIndexPath?.row)!].postID
            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "rating":"-N" as AnyObject,
                "postLink": uLink   as AnyObject,
                "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                "likedUserID": userID   as AnyObject,
                "postID":pID as AnyObject

                
                
            ]
            ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
            
            
        }
        else if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
        {
            userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
            
    
            
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
            }
            
            
            
            
            
            userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":-N"))
            
            let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
            let pID = postChatList[(myIndexPath?.row)!].postID
            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "rating":"-N" as AnyObject,
                "postLink": uLink   as AnyObject,
                "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                "likedUserID": userID  as AnyObject,
                "postID":pID as AnyObject
                
                
            ]
            ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
            
            
            
            
        }
        else if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
        {
            userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
            
         
            
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 0.1102850065, green: 0.6799504757, blue: 0.4359227419, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
            }
            
            
            
            
            userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":LL"))
            
            let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
            let pID = postChatList[(myIndexPath?.row)!].postID
            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "rating":"LL" as AnyObject,
                "postLink": uLink   as AnyObject,
                "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                "likedUserID": userID   as AnyObject,
                "postID":pID as AnyObject

                
                
            ]
            ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
            
            
            
        }
        else if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
        {
            userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
            
      
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 0.1102850065, green: 0.6799504757, blue: 0.4359227419, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            
            
            
            
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
            }
            
            
            
            
            userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":LL"))
            
            let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
            let pID = postChatList[(myIndexPath?.row)!].postID
            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "rating":"LL" as AnyObject,
                "postLink": uLink   as AnyObject,
                "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                "likedUserID": userID  as AnyObject,
                "postID":pID as AnyObject
                
                
            ]
            ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
            
        }
        else {
            
      
            
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 0.1102850065, green: 0.6799504757, blue: 0.4359227419, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
            }
            
            
            
            
            userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":L"))
            
            //ref?.child("userCreatedPosts").child((Auth.auth().currentUser?.uid)!).child(postID).child("postdata").setValue(post);

            
            let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
            let pID = postChatList[(myIndexPath?.row)!].postID
            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "rating":"L" as AnyObject,
                "postLink": uLink   as AnyObject,
                "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                "likedUserID": userID   as AnyObject,
                "postID":pID as AnyObject
                
                
            ]
            ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
            
            
        }
        
        
        
        
        
        
        }
        
        
        
    
    
        
        
        
        
        /*  if(userLikedHistoryList.contains(model.getPostID()+":L")){
         userLikedHistoryList.remove(model.getPostID()+":L");
         }
         userLikedHistoryList.add(model.getPostID()+":Y");
         */
        
      
        
    }
    
    
    
    @objc func downFunc(sender : UIButton){
        
        
        
      /*  let myIndexPath = IndexPath(row: sender.tag, section: 0)
        let cell = collectionPosts.cellForItem(at: myIndexPath) as! HomePostCollectionViewCell
        */
        let myIndexPath = collectionPosts.indexPathForView(view: sender)
        
        
        if(postChatList[(myIndexPath?.row)!].postType == "STANDARDDETAILEDPOSTIOS" || postChatList[(myIndexPath?.row)!].postType == "STANDARDDETAILEDPOSTANDROID" || postChatList[(myIndexPath?.row)!].postType == "STANDARDDETAILEDPOST"){
            
              let cell = collectionPosts.cellForItem(at: myIndexPath as! IndexPath) as! home2DetailedCollectionViewCell
            
            
            
            
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
                
                
                
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                
                //Removes any exising strings
                //If there are duplicates, it will pick the first one that shows up and prevent that from happening again
                
                
                
                
                
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
                }
                
                
                
                
                
                
                
                
                
                
                
                userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":DD"))
                
                let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
                let pID = postChatList[(myIndexPath?.row)!].postID
                
                let post:[String : AnyObject] = [
                    //"eventTitle":txtEventName.text! as AnyObject,
                    "rating":"DD" as AnyObject,
                    "postLink": uLink   as AnyObject,
                    "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                    "likedUserID": userID  as AnyObject,
                    "postID":pID as AnyObject
                    
                    
                ]
                ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
                
                
            }
            else if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
                
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                
                
                
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
                }
                
                
                
                
                
                userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":DD"))
                
                let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
                let pID = postChatList[(myIndexPath?.row)!].postID
                
                let post:[String : AnyObject] = [
                    //"eventTitle":txtEventName.text! as AnyObject,
                    "rating":"DD" as AnyObject,
                    "postLink": uLink   as AnyObject,
                    "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                    "likedUserID": userID   as AnyObject,
                    "postID":pID as AnyObject
                    
                    
                ]
                ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
                
                
                
                
            }
            else if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
                
                
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
                }
                
                
                
                
                
                userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":+N"))
                
                let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
                let pID = postChatList[(myIndexPath?.row)!].postID
                
                let post:[String : AnyObject] = [
                    //"eventTitle":txtEventName.text! as AnyObject,
                    "rating":"+N" as AnyObject,
                    "postLink": uLink   as AnyObject,
                    "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                    "likedUserID": userID  as AnyObject,
                    "postID":pID as AnyObject
                    
                    
                ]
                ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
                
                
                
            }
            else if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
                
                
                
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
                }
                
                
                
                
                
                userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":+N"))
                
                let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
                let pID = postChatList[(myIndexPath?.row)!].postID
                
                let post:[String : AnyObject] = [
                    //"eventTitle":txtEventName.text! as AnyObject,
                    "rating":"+N" as AnyObject,
                    "postLink": uLink   as AnyObject,
                    "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                    "likedUserID": userID  as AnyObject,
                    "postID":pID as AnyObject
                    
                    
                ]
                ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
                
            }
            else {
                
                
                
                
                cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                
                
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
                }
                if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
                {
                    userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
                }
                
                
                
                
                
                userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":D"))
                
                let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
                let pID = postChatList[(myIndexPath?.row)!].postID
                
                let post:[String : AnyObject] = [
                    //"eventTitle":txtEventName.text! as AnyObject,
                    "rating":"D" as AnyObject,
                    "postLink": uLink   as AnyObject,
                    "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                    "likedUserID": userID  as AnyObject,
                    "postID":pID as AnyObject
                    
                    
                    
                ]
                ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
                
                
            }
            
            
        }
        else{
        
        
        let cell = collectionPosts.cellForItem(at: myIndexPath as! IndexPath) as! home2CollectionViewCell
        
        
        
        
        
        
        if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
        {
            userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
           

            
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            
            //Removes any exising strings
            //If there are duplicates, it will pick the first one that shows up and prevent that from happening again
            
            
            
            
            
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
            }
             if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
            }
             if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
            }
             if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
            }
             if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
            }
             if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
            }
            
            
            
            
            
            
            
            
            
            
            
            userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":DD"))
            
            let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
            let pID = postChatList[(myIndexPath?.row)!].postID
            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "rating":"DD" as AnyObject,
                "postLink": uLink   as AnyObject,
                "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                "likedUserID": userID  as AnyObject,
                "postID":pID as AnyObject
                
                
            ]
            ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
            
            
        }
        else if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
        {
            userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
            
    
            cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            
    
            
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
            }
            
            
            
            
            
            userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":DD"))
            
            let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
            let pID = postChatList[(myIndexPath?.row)!].postID
            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "rating":"DD" as AnyObject,
                "postLink": uLink   as AnyObject,
                "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                "likedUserID": userID   as AnyObject,
                "postID":pID as AnyObject
                
                
            ]
            ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
            
            
            
            
        }
        else if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
        {
            userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
            
         
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
            }
            
            
            
            
            
            userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":+N"))
            
            let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
            let pID = postChatList[(myIndexPath?.row)!].postID
            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "rating":"+N" as AnyObject,
                "postLink": uLink   as AnyObject,
                "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                "likedUserID": userID  as AnyObject,
                "postID":pID as AnyObject
                
                
            ]
            ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
            
            
            
        }
        else if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
        {
            userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
            
       
            
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
            }
            
            
            
            
            
            userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":+N"))
            
            let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
            let pID = postChatList[(myIndexPath?.row)!].postID
            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "rating":"+N" as AnyObject,
                "postLink": uLink   as AnyObject,
                "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                "likedUserID": userID  as AnyObject,
                "postID":pID as AnyObject
                
                
            ]
            ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
            
        }
        else {
            
   
            
            
            cell.btnUpVote.tintColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.btnDownVote.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            
            
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":L")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":L")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":LL")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":LL")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":D")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":D")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":DD")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":DD")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":+N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":+N")!)
            }
            if userBoxLikeHistoryList.contains(postChatList[(myIndexPath?.row)!].postID+":-N")
            {
                userBoxLikeHistoryList.remove(at: userBoxLikeHistoryList.index(of: postChatList[(myIndexPath?.row)!].postID+":-N")!)
            }
            
            
            
            
            
            userBoxLikeHistoryList.append((postChatList[(myIndexPath?.row)!].postID+":D"))
            
            let uLink = "userCreatedPosts/"+postChatList[(myIndexPath?.row)!].postCreatorID+"/"+postChatList[(myIndexPath?.row)!].postID+"/ratingBlend"
            let pID = postChatList[(myIndexPath?.row)!].postID
            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "rating":"D" as AnyObject,
                "postLink": uLink   as AnyObject,
                "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                "likedUserID": userID  as AnyObject,
                "postID":pID as AnyObject

                
                
            ]
            ref?.child("LIKESDISLIKES").child(postChatList[(myIndexPath?.row)!].postID).child("LDNOTES").child(userID).setValue(post);
            
            
        }
        
        
        }
        
        
       
        
        
    }
    
    
    
    
    @objc func tagPostFunction(sender : UIButton){
      
       // if(self.favoriteBoardNumber < 20){
        
        
        
      /*  let myIndexPath = IndexPath(row: sender.tag, section: 0)
        let cell = collectionPosts.cellForItem(at: myIndexPath) as! HomePostCollectionViewCell
        */
        
        //Gets the cell that the user presses
        let myIndexPath = collectionPosts.indexPathForView(view: sender)

        
        
        
        if(postChatList[(myIndexPath?.row)!].postType == "STANDARDDETAILEDPOSTIOS" || postChatList[(myIndexPath?.row)!].postType == "STANDARDDETAILEDPOSTANDROID" || postChatList[(myIndexPath?.row)!].postType == "STANDARDDETAILEDPOST"){
            
            let cell = collectionPosts.cellForItem(at: myIndexPath as! IndexPath) as! home2DetailedCollectionViewCell
            //If user noted post, un-note it
            if(notedPostsListString.contains(postChatList[(myIndexPath?.row)!].postID)){
                
                ref?.child("notedPosts").child(userID).child(        postChatList[(myIndexPath?.row)!].postID
                    ).setValue(nil);
                //used when user is getting noted history for the box they're in
                
                ref?.child("UsersNotedPostsIDList").child(userID).child(postChatList[(myIndexPath?.row)!].postID).setValue(nil)
                cell.btnNote.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                notedPostsListString.remove(at: notedPostsListString.index(of: postChatList[(myIndexPath?.row)!].postID)!)
                notedNumbers.numOfNotedPosts -= 1
                
                
            }
            else{
                
                
                if(notedNumbers.numOfNotedPosts > 19){
                    
                    
                    let popOverVC = storyboard?.instantiateViewController(withIdentifier: "noteLimitPopoverViewController") as! noteLimitPopoverViewController
                    self.addChildViewController(popOverVC)
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                    
                }
                    
                else{
                    
                    
                    
                    var postObject = postChatList[(myIndexPath?.row)!].toFBObject()
                    let postSpecs = postSpecDetails(IsActive:true, HasBeenCleared:false,PostTime:0,
                                                    PostRemovalTime:0, PostRemovalReason: 0, PostRemover: "")
                    
                    
                    let post:[String : AnyObject] = [
                        //"eventTitle":txtEventName.text! as AnyObject,
                        "postNoterID":userID as AnyObject,
                        "postID":postChatList[(myIndexPath?.row)!].postID as AnyObject,
                        "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                        "postSpecs": postSpecs.toFBObject() as AnyObject
                        
                        
                    ]
                    
                    ref?.child("notedPosts").child(userID).child((postChatList[(myIndexPath?.row)!].postID)).setValue(postObject);
                    ref?.child("UsersNotedPostsIDList").child(userID).child(postChatList[(myIndexPath?.row)!].postID).setValue(postChatList[(myIndexPath?.row)!].postID)
                    
                    cell.btnNote.tintColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2156862745, alpha: 1)
                    
                    notedPostsListString.append(postChatList[(myIndexPath?.row)!].postID)
                    
                    /*ref?.child("notedPostsHistory").child((Auth.auth().currentUser?.uid)!).child((passedObject?.postID)!).setValue(post);
                     */
                    
                    notedNumbers.numOfNotedPosts += 1
                }
                
            }
            
            
            
        }
        else{
        
        let cell = collectionPosts.cellForItem(at: myIndexPath as! IndexPath) as! home2CollectionViewCell
        
        
        //If user noted post, un-note it
            if(notedPostsListString.contains(postChatList[(myIndexPath?.row)!].postID)){
                
                ref?.child("notedPosts").child(userID).child(        postChatList[(myIndexPath?.row)!].postID
).setValue(nil);
                //used when user is getting noted history for the box they're in
                
                ref?.child("UsersNotedPostsIDList").child(userID).child(postChatList[(myIndexPath?.row)!].postID).setValue(nil)
                cell.btnNotePost.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                notedPostsListString.remove(at: notedPostsListString.index(of: postChatList[(myIndexPath?.row)!].postID)!)
                notedNumbers.numOfNotedPosts -= 1

      
            }
            else{
                
                
                if(notedNumbers.numOfNotedPosts > 19){
                    
                    
                    let popOverVC = storyboard?.instantiateViewController(withIdentifier: "noteLimitPopoverViewController") as! noteLimitPopoverViewController
                    self.addChildViewController(popOverVC)
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                    
                }
             
                else{
                
                

                var postObject = postChatList[(myIndexPath?.row)!].toFBObject()
                let postSpecs = postSpecDetails(IsActive:true, HasBeenCleared:false,PostTime:0,
                                                PostRemovalTime:0, PostRemovalReason: 0, PostRemover: "")
                
                
                let post:[String : AnyObject] = [
                    //"eventTitle":txtEventName.text! as AnyObject,
                    "postNoterID":userID as AnyObject,
                    "postID":postChatList[(myIndexPath?.row)!].postID as AnyObject,
                    "postLocations":postChatList[(myIndexPath?.row)!].postLocations?.toFBObject() as AnyObject,
                    "postSpecs": postSpecs.toFBObject() as AnyObject
                    
                    
                ]
                
                ref?.child("notedPosts").child(userID).child((postChatList[(myIndexPath?.row)!].postID)).setValue(postObject);
            ref?.child("UsersNotedPostsIDList").child(userID).child(postChatList[(myIndexPath?.row)!].postID).setValue(postChatList[(myIndexPath?.row)!].postID)
                    
                    cell.btnNotePost.tintColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2156862745, alpha: 1)
                    
                    notedPostsListString.append(postChatList[(myIndexPath?.row)!].postID)

                /*ref?.child("notedPostsHistory").child((Auth.auth().currentUser?.uid)!).child((passedObject?.postID)!).setValue(post);
                 */
               
                notedNumbers.numOfNotedPosts += 1
            }
                
        }
            
        
       
        }
        
        
        /*
        let myIndexPath = IndexPath(row: sender.tag, section: 0)
        let cell = collectionPosts.cellForItem(at: myIndexPath) as! HomePostCollectionViewCell
        
        
        
        if(cell.btnNotePost.backgroundColor == #colorLiteral(red: 0.9514281154, green: 0.9885231853, blue: 0.5498319268, alpha: 1) ){
            
            ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).child(postChatList[sender.tag].postID).setValue(nil);
           //used when user is getting noted history for the box they're in
            ref?.child("notedPostsHistory").child((Auth.auth().currentUser?.uid)!).child(postChatList[sender.tag].postID).child("postSpecs").child("isActive").setValue(false);
            cell.btnNotePost.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            
            var indexOfNoteToBeRemoved = notedPostsList.index(where: {$0.postID == postChatList[sender.tag].postID})
            
            if(indexOfNoteToBeRemoved != nil){

            notedPostsList.remove(at: indexOfNoteToBeRemoved!)
            }
            
            if((userBoxNotedHistoryList.index(where: {$0 == postChatList[sender.tag].postID})) != nil){
                
                userBoxNotedHistoryList.remove(at: userBoxNotedHistoryList.index(where: {$0 == postChatList[sender.tag].postID})!)
        }
          

            
        }
        else{
            cell.btnNotePost.backgroundColor = #colorLiteral(red: 0.9514281154, green: 0.9885231853, blue: 0.5498319268, alpha: 1)
            userBoxNotedHistoryList.append((postChatList[sender.tag].postID))
            
            var uLink = "Users/"+postChatList[sender.tag].postCreatorID+"/POSTS/"+postChatList[sender.tag].postID+"/POSTDATA/ratingBlend"
            var postObject = postChatList[sender.tag].toFBObject()
            let postSpecs = postSpecDetails(IsActive:true, HasBeenCleared:false,PostTime:0,
                                            PostRemovalTime:0)

            
            var notedPost = notedPostWithBtnTagObject( PostID:postChatList[sender.tag].postID ,BtnTag: sender.tag)
            notedPostsList.append(notedPost)

            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "postNoterID":Auth.auth().currentUser?.uid as AnyObject,
                "postID":postChatList[sender.tag].postID as AnyObject,
                 "postLocations":postChatList[sender.tag].postLocations?.toFBObject() as AnyObject,
                 "postSpecs": postSpecs.toFBObject() as AnyObject
                
                
            ]
            
            ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).child(postChatList[sender.tag].postID).setValue(postObject);
            ref?.child("notedPostsHistory").child((Auth.auth().currentUser?.uid)!).child(postChatList[sender.tag].postID).setValue(post);
            
          
         
            
        }
        
        
      */
       
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func loadPostsNormal(passedBoxList:String){
        
        ref?.child("POSTS").child(passedBoxList).removeAllObservers()
        postChatList.removeAll()
        collectionPosts.reloadData()
        activityIndicator.color = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        activityIndicator.startAnimating()
        listOrderType = "normal"
        
        //        handle = ref?.child("POSTS").child(passedBoxList).queryLimited(toLast: 350).observe(.childAdded, with: { (snapshot) in
        
        let verifyClass = verifyPost()


        ref?.child("POSTS").child(passedBoxList).queryOrdered(byChild: "postTimeInverse").queryLimited(toLast: 350).observe(.childAdded, with: { (snapshot) in
            //if let dict = snapshot.value as? [String: AnyObject]{
            if let dictt = snapshot.value as? [String: AnyObject]{


                
               var isValidPost = verifyClass.verifyPost(dict: dictt)
             
    
                
               
                
                //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
                // self.myList.append(titleText! as! String)
               // self.postTypeList.append(postType as! String)
                //self.userIDList.append(postCreatorID as! String)
               

               if(isValidPost){
                    
                    var postPost = verifyClass.createPost(dict: dictt)
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
                    if(!self.blockedUserIDList.contains(postPost.postCreatorID))
        
                    {
                        if(!(postPost.postID == "UNAVAILABLE")){
                        
                    self.postChatList.append(postPost)
                    self.collectionPosts.reloadData()
                        }
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
    
    
    func loadPostsRanking(passedBoxList:String){
        ref?.child("POSTS").child(passedBoxList).removeAllObservers()
       // ref?.removeObserver(withHandle: self.handle!)
        //ref?.removeValue()
        let verifyClass = verifyPost()

        
        print("woopwoop")
        print("woopwoop")
        print("woopwoop")
        print("woopwoop")
        print("woopwoop")
        print("woopwoop")
        print("woopwoop")
        print("woopwoop")
        print("woopwoop")
        print("woopwoop")
        print("woopwoop")
        print("woopwoop")
        print("woopwoop")

        postChatList.removeAll()
        collectionPosts.reloadData()
        activityIndicator.color = #colorLiteral(red: 0.1370565295, green: 0.7736131549, blue: 1, alpha: 1)
        activityIndicator.startAnimating()
        listOrderType = "rating"

      
     
       ref?.child("POSTS").child(passedBoxList).queryOrdered(byChild: "ratingRanking").queryLimited(toLast: 350).observe(.childAdded, with: { (snapshot) in
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
                if(!self.blockedUserIDList.contains(postPost.postCreatorID))
                    
                {
                    if(!(postPost.postID == "UNAVAILABLE")){
                        
                        self.postChatList.append(postPost)
                        self.collectionPosts.reloadData()
                    }
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
    
    
    
    func loadPostByChatCount(passedBoxList:String){
      ref?.child("POSTS").child(passedBoxList).removeAllObservers()
        postChatList.removeAll()
        collectionPosts.reloadData()
        activityIndicator.color =  #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1)
        activityIndicator.startAnimating()
        listOrderType = "textCount"

        let verifyClass = verifyPost()

        
       // textCountInverse
         ref?.child("POSTS").child(passedBoxList).queryOrdered(byChild: "messageRanking").queryLimited(toLast: 350).observe(.childAdded, with: { (snapshot) in
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
                    if(!self.blockedUserIDList.contains(postPost.postCreatorID))
                        
                    {
                        if(!(postPost.postID == "UNAVAILABLE")){
                            
                            self.postChatList.append(postPost)
                            self.collectionPosts.reloadData()
                        }
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
    
    

   
    func updateLikedList(passedPostID:String, passedPostisNotedValue:Bool){
        
      
        if(passedPostisNotedValue){
            //If post is now noted, add it to list
            if(!notedPostsListString.contains(passedPostID)){
                     //If post isn't in list, add it
                
                notedPostsListString.append(passedPostID)
               collectionPosts.reloadItems(at: collectionPosts.indexPathsForVisibleItems)
                
                
                
            }
            
        }
        else{
            //If post is now not noted, remove it from the list
            
            if(notedPostsListString.contains(passedPostID)){
                        //If post is in list, remove it
                
                notedPostsListString.remove(at: notedPostsListString.index(of: passedPostID)!)
               collectionPosts.reloadItems(at: collectionPosts.indexPathsForVisibleItems)
                
                
                
                
            }
            else{
                
                
                
                
            }
            
            
        }
       
        
        
        
        
    }
    
    func removeUNNotedPosts(passedNoteList:[String]){
        
        print("rangadangdang")
        print("rangadangdang")

        print("rangadangdang")
        print("rangadangdang")
        print("rangadangdang")
        print("rangadangdang")
        print("rangadangdang")
        print("rangadangdang")
        
        //Efficient way list
       var notesToBeRemovedFromNotedList:[String] = passedNoteList
    
         
        // more efficient way???
         
  
        /*
        let visiblePaths = self.collectionPosts.indexPathsForVisibleItems.sorted()
        for indexPath in visiblePaths {
            
          //  if(userBoxNotedHistoryList.contains(passedNoteList[indexPath.row])){
         if(notesToBeRemovedFromNotedList.contains(postChatList[indexPath.row].postID)){

         let cell = collectionPosts.cellForItem(at: indexPath) as! HomePostCollectionViewCell
         //self.setCellImageOffset(cell: cell, indexPath: indexPath as NSIndexPath)
         cell.btnNotePost.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    
           // passedNoteList.remove(at: passedNoteList.index(of: userBoxNotedHistoryList[indexPath.row]))
            userBoxNotedHistoryList.remove(at: userBoxNotedHistoryList.index(where: {$0 == postChatList[indexPath.row].postID})!)
            notesToBeRemovedFromNotedList.remove(at: notesToBeRemovedFromNotedList.index(of: postChatList[indexPath.row].postID)!)

         
            }
            
            
         }
        
        */
   
  
       
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
        
      
        
        if(self.currentSegmentIndex < 3 ){
            
            self.selectOrderSegmentObj.selectedSegmentIndex = self.currentSegmentIndex + 1
            selectOrderSegmentObj.sendActions(for:  UIControlEvents.valueChanged)
        }
        
        
       // selectOrderSegmentObj.selectedSegmentIndex

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
       
        
      
        

        
        if(self.currentSegmentIndex > 0){
           // buttons[newIndex].sendActions(for: .touchUpInside)
            
            self.selectOrderSegmentObj.selectedSegmentIndex = self.currentSegmentIndex - 1
            selectOrderSegmentObj.sendActions(for:  UIControlEvents.valueChanged)
        }
        

    }
    
    
    
    func loadPostByClose(passedBoxList:String){
        
        ref?.child("POSTS").child(passedBoxList).removeAllObservers()

        
        postChatList.removeAll()
        collectionPosts.reloadData()
        
        activityIndicator.color = #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.4509803922, alpha: 1)
        activityIndicator.startAnimating()
        
        listOrderType = "closePosts"
    
        let verifyClass = verifyPost()


           // self.indexPathLastLocation = self.collectionPosts.indexPathsForVisibleItems[0]
        
            
    ref?.child("POSTS").child(boxListName).queryOrdered(byChild: "postTimeInverse").queryLimited(toLast: 350).observe(.childAdded, with: { (snapshot) in
        if let dict = snapshot.value as? [String: AnyObject]{
            
            
            
            var isValidPost = verifyClass.verifyPost(dict: dict)
            
            
            
            
            
            //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
            // self.myList.append(titleText! as! String)
            // self.postTypeList.append(postType as! String)
            //self.userIDList.append(postCreatorID as! String)
            
            
            if(isValidPost){
                var postPost = verifyClass.createPost(dict: dict)

                if(( (fabs(postPost.postLat - self.uLat)) < 0.008) && ((fabs(postPost.postLong - self.uLong)) < 0.008)){

                
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
                if(!self.blockedUserIDList.contains(postPost.postCreatorID))
                    
                {
                    if(!(postPost.postID == "UNAVAILABLE")){
                        
                        self.postChatList.append(postPost)
                        self.collectionPosts.reloadData()
                    }
                }
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
    @objc func removeBlur(sender : UIButton){
        
        /* let myIndexPath = IndexPath(row: sender.tag, section: 0)
         let cell = collectionPosts.cellForItem(at: myIndexPath) as! HomePostCollectionViewCell
         */
        let myIndexPath = collectionPosts.indexPathForView(view: sender)
     
        if(postChatList[myIndexPath!.row].postType == "STANDARDDETAILEDPOSTIOS" || postChatList[myIndexPath!.row].postType == "STANDARDDETAILEDPOSTANDROID" || postChatList[myIndexPath!.row].postType == "STANDARDDETAILEDPOST"){
           
            
               let cell = collectionPosts.cellForItem(at: myIndexPath as! IndexPath) as! home2DetailedCollectionViewCell
            cell.viewPostWasBlocked.isHidden = true

        }
        else{
        
        
        let cell = collectionPosts.cellForItem(at: myIndexPath as! IndexPath) as! home2CollectionViewCell
        
        cell.viewPostFlagged.isHidden = true
        }
    }
    
 
    
}



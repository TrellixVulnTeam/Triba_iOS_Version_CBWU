//
//  notedPostsViewController.swift
//  tiatwpbnw
//
//  Created by David A on 3/7/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase

class notedPostsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
  
    /*
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        print(tabBarIndex.description)
        
        if tabBarIndex == 1 {
            postChatList.removeAll()
            collectionNotedPosts.reloadData()
            fillNotedHistory()
            
        }
    }
    
    */
    
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tableView.reloadData()

        //collectionNotedPosts.reloadData()
        (self.tabBarController as! homeTabBar).tabBarVisible();
        
     self.hidesBottomBarWhenPushed = true;
        self.tabBarController?.tabBar.isHidden = true

        
        postChatList.removeAll()
        collectionNotedPosts.reloadData()
        loadPosts()


    }
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
    
  
    var isLocEnabled = false
    var myList:[String] = []
    var postChatList:[postObject] = []
    var lstRemovedPosts:[String] = []

    
    var userIDList:[String] = []
    var userBoxLikeHistoryList:[String] = []
    
    
    var postTypeList:[String] = []
    var postHistoryList:[String] = []
    
    var postStatusList:[String] = []

    
    var uLat:Double = 200.0
    var uLong:Double = 200.0
    var postLong: Double!
    var postLat: Double!
    
    var delegate:aCustomDelegate?

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postChatList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomePostCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homePageCell", for: indexPath) as! HomePostCollectionViewCell
        
        cell.txtPostTextlbl.text = postChatList[indexPath.row].postText
        
        
        if(lstRemovedPosts.contains(postChatList[indexPath.row].postID)){
            
            cell.btnNotePost.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            
        }
        
 
        
        
        if( postTypeList[indexPath.row] == "CHAT"){
            //cell.backgroundColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        }
        else{
           // cell.backgroundColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 1)
        }
        cell.btnNotePost.addTarget(self, action: #selector(tagUnPostFunction(sender:)), for: .touchUpInside)
        cell.btnNotePost.tag = indexPath.row
        
       // cell.btnUpvote.addTarget(self, action: #selector(upFunc(sender:)), for: .touchUpInside)
        cell.btnUpvote.tag = indexPath.row
        
        var strHasLikedPost = postChatList[indexPath.row].postID+":L"
        var strHasDislikedPost = postChatList[indexPath.row].postID+":D"
        var strHasSuperLikedPost = postChatList[indexPath.row].postID+":LL"
        var strHasSuperDislikedPost = postChatList[indexPath.row].postID+":DD"
        
       // cell.btnNotePost.backgroundColor = #colorLiteral(red: 0.9514281154, green: 0.9885231853, blue: 0.5498319268, alpha: 1)

        
     
        
        if userBoxLikeHistoryList.contains(strHasLikedPost) {
            print("LikedIt")
            cell.btnUpvote.backgroundColor = #colorLiteral(red: 0.9514281154, green: 0.9885231853, blue: 0.5498319268, alpha: 1)
            cell.btnDownvote.backgroundColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 0)        }
        else if userBoxLikeHistoryList.contains(strHasDislikedPost) {
            print("Disliked it")
            cell.btnDownvote.backgroundColor = #colorLiteral(red: 0.9514281154, green: 0.9885231853, blue: 0.5498319268, alpha: 1)
            cell.btnUpvote.backgroundColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 0)        }
        else if userBoxLikeHistoryList.contains(strHasSuperLikedPost) {
            print("Superliked it")
            cell.btnUpvote.backgroundColor = #colorLiteral(red: 0.9514281154, green: 0.9885231853, blue: 0.5498319268, alpha: 1)
            cell.btnDownvote.backgroundColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 0)         }
        else if userBoxLikeHistoryList.contains(strHasSuperDislikedPost) {
            print("SuperDisliked it")
            cell.btnDownvote.backgroundColor = #colorLiteral(red: 0.9514281154, green: 0.9885231853, blue: 0.5498319268, alpha: 1)
            cell.btnUpvote.backgroundColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 0)        }
        else{
            print("Nothin")
            cell.btnDownvote.backgroundColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 0)
            cell.btnUpvote.backgroundColor = #colorLiteral(red: 0.1505342424, green: 0.8770073056, blue: 0.5665099621, alpha: 0)
            
        }
        
        cell.btnNotePost.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)

       /*
        if(postStatusList[indexPath.row] == "lit"){
            
            cell.lblNotedPostStatus.text = "lit"
        }
        else if (postStatusList[indexPath.row] == "up"){
            cell.lblNotedPostStatus.text = "lit"

        }
        else{
            cell.lblNotedPostStatus.text = "nothing"
        }
        
*/
        
        
        
       // cell.btnDownvote.addTarget(self, action: #selector(downFunc(sender:)), for: .touchUpInside)
      //  cell.btnDownvote.tag = indexPath.row
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        //let cell = eventsCollection.cellForItem(at: indexPath) as! myEventsCollectionViewCell
        // let currentCell = tableView.cellForRow(at: indexPath)! as! groupTitleCell
        

      //  let cell = collectionPosts.cellForItem(at: indexPath) as! HomePostCollectionViewCell
       
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "chatHomeViewController") as! chatHomeViewController
    
        myVC.passedObject = postChatList[indexPath.row]
        
        self.navigationController?.pushViewController(myVC, animated: true)
        
        
        
        
        return true
    }
    

    @IBOutlet weak var collectionNotedPosts: UICollectionView!
    
    @IBAction func btnMyProfile(_ sender: Any) {
        
        postChatList.removeAll()
        collectionNotedPosts.reloadData()
        fillNotedHistory()
        
    }
    @IBAction func btnMakePost(_ sender: Any) {
    }
    
    
    
    var handle: DatabaseHandle?
    
    var ref:DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        ref = Database.database().reference()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.showAnimate()
        
        
        
       
        
        
        
        
      /*
        
       ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
        if let dict = snapshot.value as? [String: AnyObject]{
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
            
            
            let postSpecs = postSpecDetails(IsActive:ISActive, HasBeenCleared:HAsBeenCleared,PostTime:POstTime,
                                            PostRemovalTime:POstRemovalTime)
            
            //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
            // self.myList.append(titleText! as! String)
            self.postTypeList.append(postType as! String)
            self.userIDList.append(postCreatorID as! String)
            
            var postChat = userPostChatClass(PostCreator:postCreatorID,
                                             PostText:postText,
                                             PostID:postID ,
                                             PostLat:postLat ,
                                             PostLong:postLong ,
                                             PostTime:postTime ,
                                             PostUserName:postUserName ,
                                             PostType:postType ,
                                             PostDESCRIPTION:postDescription,
                                             CreatorName:creatorName, PostLocations: postLocations, RatingBlend:ratingBlend, PostSpecs:postSpecs, PostVisStart:POstVisStartTime, PostVisEnd:POstVisEndTime, TextCount:textCount)
            
            self.postChatList.append(postChat)
            self.collectionNotedPosts.reloadData()
            
            
            
            
            
            
            
            
            
            //self.scrollToLastItem()
            
            
            
            
        }
        })
*/

       
 
       // loadPosts()
        
    }
    
    
    
    func fillNotedHistory(){

        postChatList.removeAll()
        collectionNotedPosts.reloadData()
        
        handle = ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).queryLimited(toLast: 350).observe(.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
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

               
            
                let POstRemovalReason = specDic["postRemovalReason"] as! String
                let POstRemover = specDic["postRemover"] as! String
                
                
                let postBranch1 = dict["postBranch1"] as! String
                let postBranch2 = dict["postBranch2"] as! String
                
                
                
                let postSpecs = postSpecDetails(IsActive:ISActive, HasBeenCleared:HAsBeenCleared,PostTime:POstTime,
                                                PostRemovalTime:POstRemovalTime, PostRemovalReason: 0, PostRemover: POstRemover)
                
                //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
                // self.myList.append(titleText! as! String)
                self.postTypeList.append(postType as! String)
                self.userIDList.append(postCreatorID as! String)
                
                var postChat = postObject(PostCreatorID:postCreatorID,
                                          PostText:postText,
                                          PostID:postID ,
                                          PostLat:postLat ,
                                          PostLong:postLong ,
                                          PostTime:postTime ,
                                          PostUserName:postUserName ,
                                          PostType:postType ,
                                          PostDESCRIPTION:postDescription,
                                          CreatorName:creatorName, PostLocations: postLocations,RatingBlend:ratingBlend, PostSpecs:postSpecs, PostVisStart:POstVisStartTime, PostVisEnd:POstVisEndTime, TextCount:textCount,Branch1:postBranch1, Branch2:postBranch2)
                
                self.postChatList.append(postChat)
                self.collectionNotedPosts.reloadData()
                
                
                
                
                
                
                
                
                
                //self.scrollToLastItem()
                
                
                
                
            }
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    @objc func tagUnPostFunction(sender : UIButton){
        
     
        
        let indexPath = collectionNotedPosts.indexPathForView(view: sender)
        
        print(" ")
        print(" ")
        print(" ")
        print(" ")
        print(" ")
        print(" ")
        print("tag: " + (indexPath?.row.description)!)
        print(" ")
        print(" ")
        print(" ")
        print(" ")
        print(" ")
        print(" ")
        

        //let myIndexPath = IndexPath(row: sender.tag, section: 0)
        let cell = collectionNotedPosts.cellForItem(at: indexPath as! IndexPath) as! HomePostCollectionViewCell
        
        
       
        
        
        if(cell.btnNotePost.backgroundColor == #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1) ){
          /*  cell.btnNotePost.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            //  userBoxLikeHistoryList.append((postChatList[sender.tag].postID+":N"))
            
            //Line from old way where object was used
            //   var indexOfNoteToBeRemoved = lstRemovedPosts.index(where: {$0.postID == postChatList[sender.tag].postID})
            var indexOfNoteToBeRemoved = lstRemovedPosts.index(where: {$0 == postChatList[sender.tag].postID})
            
            
            if(indexOfNoteToBeRemoved != nil){
                lstRemovedPosts.remove(at: indexOfNoteToBeRemoved!)
            }
            
            
            
            
            var uLink = "Users/"+postChatList[sender.tag].postCreatorID+"/POSTS/"+postChatList[sender.tag].postID+"/POSTDATA/ratingBlend"
            var postObject = postChatList[sender.tag].toFBObject()
            let postSpecs = postSpecDetails(IsActive:true, HasBeenCleared:false,PostTime:0,
                                            PostRemovalTime:0, PostRemovalReason: "", PostRemover: "")
            
            let post:[String : AnyObject] = [
                //"eventTitle":txtEventName.text! as AnyObject,
                "postNoterID":Auth.auth().currentUser?.uid as AnyObject,
                "postID":postChatList[sender.tag].postID as AnyObject,
                "postLocations":postChatList[sender.tag].postLocations?.toFBObject() as AnyObject,
                "postSpecs": postSpecs.toFBObject() as AnyObject
                
                
            ]
            
            ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).child(postChatList[sender.tag].postID).setValue(postObject);
            ref?.child("notedPostsHistory").child((Auth.auth().currentUser?.uid)!).child(postChatList[sender.tag].postID).setValue(post);
            */
            
            
        }
        else{
            
            
            
            let refreshAlert = UIAlertController(title: "Un-note this post?", message: " ", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                /*self.ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).child(self.postChatList[sender.tag].postID).setValue(nil);
                self.ref?.child("UsersNotedPostsIDList").child((Auth.auth().currentUser?.uid)!).child(self.postChatList[sender.tag].postID).setValue(nil)
                
                */
                self.ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).child(self.postChatList[(indexPath?.row)!].postID).setValue(nil);
                self.ref?.child("UsersNotedPostsIDList").child((Auth.auth().currentUser?.uid)!).child(self.postChatList[(indexPath?.row)!].postID).setValue(nil)
                
                
                
                

                //used when user is getting noted history for the box they're in
                //self.ref?.child("notedPostsHistory").child((Auth.auth().currentUser?.uid)!).child(self.postChatList[sender.tag].postID).child("postSpecs").child("isActive").setValue(false);
                
                
                //THIS LINE MIGHT BE IMPORTANT, WRITTEN 6/2/18
               // sharedData.ModelData.bubbleLats.append(self.postChatList[sender.tag].postID)
                
                
                //Line from old way where object was used
                //  lstRemovedPosts.append(postChatList[sender.tag])
              
                
                //self.lstRemovedPosts.append(self.postChatList[sender.tag].postID)
                //BLOW
                self.lstRemovedPosts.append(self.postChatList[(indexPath?.row)!].postID)

                
                
                print(" ")
                print(" ")
                print(" ")
                print(" ")
                print(" ")
                print(" ")
                print("CELLTEXT: " + cell.txtPostTextlbl.text!)
                print("POSTTEXT: " + self.postChatList[(indexPath?.row)!].postText)

                print(" ")
                print(" ")
                print(" ")
                print(" ")
                print(" ")
                print(" ")
                
                
                
               // self.postChatList.remove(at: sender.tag)
               //BLOW
                self.postChatList.remove(at: (indexPath?.row)!)

                
                
                
                self.collectionNotedPosts.deleteItems(at: [indexPath as! IndexPath])
             //   self.collectionNotedPosts.reloadItems(at: myIndexPath..<numberOfItems(inSection: collectionNotedPosts))
               // self.collectionNotedPosts.reloadItems(at: myIndexPath.row..<collectionNotedPosts.numberOfItems(inSection: 0))

                
                
                UserDefaults.standard.set(true , forKey: "resetOnAppear")

                
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            
            self.present(refreshAlert, animated: true, completion: nil)
            
            

            
        }
        
/*
        if(cell.btnNotePost.backgroundColor == #colorLiteral(red: 0.9514281154, green: 0.9885231853, blue: 0.5498319268, alpha: 1) ){
            
            ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).child(postChatList[sender.tag].postID).setValue(nil);
            //used when user is getting noted history for the box they're in
            ref?.child("notedPostsHistory").child((Auth.auth().currentUser?.uid)!).child(postChatList[sender.tag].postID).child("postSpecs").child("isActive").setValue(false);
            sharedData.ModelData.bubbleLats.append(postChatList[sender.tag].postID)
            
            
            //Line from old way where object was used
          //  lstRemovedPosts.append(postChatList[sender.tag])
            lstRemovedPosts.append(postChatList[sender.tag].postID)

            cell.btnNotePost.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            
        }
        else{
           
            cell.btnNotePost.backgroundColor = #colorLiteral(red: 0.9514281154, green: 0.9885231853, blue: 0.5498319268, alpha: 1)
            //  userBoxLikeHistoryList.append((postChatList[sender.tag].postID+":N"))
            
            //Line from old way where object was used
        //   var indexOfNoteToBeRemoved = lstRemovedPosts.index(where: {$0.postID == postChatList[sender.tag].postID})
            var indexOfNoteToBeRemoved = lstRemovedPosts.index(where: {$0 == postChatList[sender.tag].postID})

            
            if(indexOfNoteToBeRemoved != nil){
            lstRemovedPosts.remove(at: indexOfNoteToBeRemoved!)
            }
            

            
            
            var uLink = "Users/"+postChatList[sender.tag].postCreatorID+"/POSTS/"+postChatList[sender.tag].postID+"/POSTDATA/ratingBlend"
            var postObject = postChatList[sender.tag].toFBObject()
            let postSpecs = postSpecDetails(IsActive:true, HasBeenCleared:false,PostTime:0,
                                            PostRemovalTime:0)
            
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
    
    
    func loadPosts(){
        postChatList.removeAll()
        collectionNotedPosts.reloadData()
        
        self.postChatList.removeAll()
        collectionNotedPosts.reloadData()
        
        handle = ref?.child("notedPosts").child((Auth.auth().currentUser?.uid)!).queryLimited(toLast: 350).observe(.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
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
                let POstRemovalReason = specDic["postRemovalReason"] as! String
                let POstRemover = specDic["postRemover"] as! String
                
                let POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
                let POstVisEndTime = dict["postVisibilityEndTime"] as! CLong
                
                let postLat = dict["postLat"] as! Double
                let postLong = dict["postLong"] as! Double
                let ratingBlend = dict["ratingBlend"] as! CLong
                let textCount = dict["textCount"] as! Int
                
                
                
                let postBranch1 = dict["postBranch1"] as! String
                let postBranch2 = dict["postBranch2"] as! String
                
                
                
                
                
                let postSpecs = postSpecDetails(IsActive:ISActive, HasBeenCleared:HAsBeenCleared,PostTime:POstTime,
                                                PostRemovalTime:POstRemovalTime, PostRemovalReason: 0, PostRemover: POstRemover)
                
                //if((fabs(postLat - self.userLat!) < 0.1) && (fabs(postLat - self.userLat!) < 0.1) ){
                // self.myList.append(titleText! as! String)
                self.postTypeList.append(postType as! String)
                self.userIDList.append(postCreatorID as! String)
                
                var postChat = postObject(PostCreatorID:postCreatorID,
                                          PostText:postText,
                                          PostID:postID ,
                                          PostLat:postLat ,
                                          PostLong:postLong ,
                                          PostTime:postTime ,
                                          PostUserName:postUserName ,
                                          PostType:postType ,
                                          PostDESCRIPTION:postDescription,
                                          CreatorName:creatorName, PostLocations: postLocations,RatingBlend:ratingBlend, PostSpecs:postSpecs, PostVisStart:POstVisStartTime, PostVisEnd:POstVisEndTime, TextCount:textCount,Branch1:postBranch1, Branch2:postBranch2)
                
                self.postChatList.append(postChat)
                self.collectionNotedPosts.reloadData()
                
                
                
                
                
                
                
                
                
                //self.scrollToLastItem()
                
                
                
                
            }
        })
        
        for name in postChatList {

            var post:postObject = name
            var postTimes:[CLong] = []
            var sumOfPostTime:CLong = 0
            var numOfChats:Int = 0
            let postTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))


            ref?.child("Chats").child(post.postCreatorID).child((post.postID)).queryLimited(toLast: 5).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject]{
                    let postTime = dict["postTime"] as! CLong
                    //postTimes.append(postTime)
                    sumOfPostTime += postTime
                    numOfChats += 1
                    
                }
               
            })
            
            
       

            
            if( abs((sumOfPostTime / numOfChats) - postTime) < 3600){
                postStatusList.append("lit")
                
            }
            else if(abs((sumOfPostTime / numOfChats) - postTime) < 21600){
                
                postStatusList.append("up")
            }
            
            
            self.collectionNotedPosts.reloadData()

            
        }
        
      
    }
    
    
    @IBAction func btnResetPosts(_ sender: Any) {
        
        postChatList.removeAll()
        collectionNotedPosts.reloadData()
        fillNotedHistory()
        
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
    
   

}



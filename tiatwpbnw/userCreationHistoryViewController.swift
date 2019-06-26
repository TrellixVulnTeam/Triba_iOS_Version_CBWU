//
//  userCreationHistoryViewController.swift
//  tiatwpbnw
//
//  Created by David A on 3/9/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase

class userCreationHistoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
   

    
    var handle: DatabaseHandle?
    var ref:DatabaseReference?
    var userLat: Double?
    var userLong:Double?
    var myList:[String] = []
    var postChatList:[postObject] = []
    
    var userIDList:[String] = []
    var userBoxLikeHistoryList:[String] = []
    var postTypeList:[String] = []
    var postHistoryList:[String] = []
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postChatList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:userCreationHistoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCreationHistoryCollectionViewCell", for: indexPath) as! userCreationHistoryCollectionViewCell
       /* cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8;
        cell.layer.borderColor =  #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        */
        cell.txtHistoryText.text = postChatList[indexPath.row].postText
        cell.txtPostActiveStatus.text = postChatList[indexPath.row].postSpecs?.isActive.description
        cell.lblPostRating.text = "rating: " + postChatList[indexPath.row].ratingBlend.description
         cell.lblMessageCount.text = "Messages: " + postChatList[indexPath.row].textCount.description
        
        if(postChatList[indexPath.row].postSpecs?.isActive == true){
            cell.txtPostActiveStatus.text = "active"
            cell.btnDelete.isHidden = false
        }
        else{
            cell.txtPostActiveStatus.text = "inactive"
            cell.btnDelete.isHidden = true

            
        }
        if(postChatList[indexPath.row].postSpecs?.postRemover != ""){
           // cell.lblRemover.text = "removed by " + (postChatList[indexPath.row].postSpecs?.postRemover)!
        }
        
         cell.btnDelete.addTarget(self, action: #selector(deletePost(sender:)), for: .touchUpInside)
         cell.btnDelete.tag = indexPath.row
  
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        //let cell = eventsCollection.cellForItem(at: indexPath) as! myEventsCollectionViewCell
        // let currentCell = tableView.cellForRow(at: indexPath)! as! groupTitleCell
        
        
        //  let cell = collectionPosts.cellForItem(at: indexPath) as! HomePostCollectionViewCell
        
        if(postChatList[indexPath.row].postSpecs?.isActive == true){

        let myVC = storyboard?.instantiateViewController(withIdentifier: "chatHomeViewController") as! chatHomeViewController
        
        myVC.passedObject = postChatList[indexPath.row]
        
        self.navigationController?.pushViewController(myVC, animated: true)
        }
        else{
            
            
            let refreshAlert = UIAlertController(title: "Sorry, you can't go there", message: "Post was deactivated", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
 
                
                
            }))
          
            self.present(refreshAlert, animated: true, completion: nil)
            
            
        }
        
        
        
        return true
    }
    
    
    
    @objc func deletePost(sender : UIButton){
        print(sender.tag)
        
        let myIndexPath = IndexPath(row: sender.tag, section: 0)
        let cell = collectionHistory.cellForItem(at: myIndexPath) as! userCreationHistoryCollectionViewCell
        
        var pID = postChatList[sender.tag].postID
        var postSPecs = postChatList[sender.tag].postSpecs
        postSPecs?.hasBeenCleared
            let currentTime:CLong = (TimeZone.current.secondsFromGMT() + CLong(Date().timeIntervalSince1970))
        
        let postSpecs:[String : AnyObject] = [
            "isActive":false as AnyObject,
            "hasBeenCleared":postSPecs?.hasBeenCleared as AnyObject,
            "postTime":postSPecs?.postTime as AnyObject,
            "postRemovalTime":currentTime as AnyObject,
            "postRemovalReason":"selfRemoved" as AnyObject,
            "postRemover":"selfRemoved" as AnyObject
          
           
            ]
        
        ref?.child("userCreatedPosts").child((Auth.auth().currentUser?.uid)!).child(pID).child("postSpecs").setValue(postSpecs);
        ref?.child("reportedPostIndex").child(pID).child("postStatus").setValue("REMOVED")
        
        cell.txtPostActiveStatus.text = "inactive"
        cell.btnDelete.isHidden = true

        
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
    
    
    
    
    
    
    
    
    @IBOutlet weak var collectionHistory: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        self.tabBarController?.tabBar.isHidden = true
        
        var userAllowedAccessDate = 0

        if let uAD = UserDefaults.standard.object(forKey: "userAllowedAccessDate") as? Int{
            userAllowedAccessDate = uAD
        }
        
        handle = ref?.child("userCreatedPosts").child((Auth.auth().currentUser?.uid)!).queryOrdered(byChild: "postTime").queryStarting(atValue:
            userAllowedAccessDate).queryLimited(toLast: 350).observe(.childAdded, with: { (snapshot) in
           //BETWEEN THERE
                
              if let snapshotThatWillBeTurnedIntoDictNextLine = snapshot.value as? [String: AnyObject]{
                let dict = snapshotThatWillBeTurnedIntoDictNextLine["postdata"] as! [String: AnyObject]

               // if let dict = snapshot.value as? [String: AnyObject]{
//AND HERE
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
                
                let POstVisStartTime = dict["postVisibilityStartTime"] as! CLong
                let POstVisEndTime = dict["postVisibilityEndTime"] as! CLong
                
              let specDic = dict["postSpecs"]  as! [String: Any]
                let ISActive = specDic["isActive"] as! Bool
                let HAsBeenCleared = specDic["hasBeenCleared"] as! Bool
                let POstTime = specDic["postTime"] as! CLong
                let POstRemovalTime = specDic["postRemovalTime"] as! CLong
                print(postID)
                let POstRemovalReason = specDic["postRemovalReason"] as! String
                let POstRemover = specDic["postRemover"] as! String


                
                let ratingBlend = dict["ratingBlend"] as! CLong

                let postBranch1 = dict["postBranch1"] as! String
                let postBranch2 = dict["postBranch2"] as! String


            
                let postSpecs = postSpecDetails(IsActive:ISActive, HasBeenCleared:HAsBeenCleared,PostTime:POstTime,
                                                PostRemovalTime:POstRemovalTime, PostRemovalReason: 0, PostRemover: POstRemover)

 
                
                
                //  let authorID = dict["userID"]
                //  let timee = dict["messageTime"]
                
                let postLat = dict["postLat"] as! Double
                let postLong = dict["postLong"] as! Double
                let textCount = dict["textCount"] as! Int

                
              
                
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
                    self.collectionHistory.reloadData()
                    
                    
               // }
 
                
                self.scrollToLastItem()

                
                
                
                //self.scrollToLastItem()
                
                
                
                
            }
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollToLastItem() {
        
        let lastItem =   collectionView(self.collectionHistory!, numberOfItemsInSection: 0) - 1
        let indexPath: NSIndexPath = NSIndexPath.init(item: lastItem, section: 0)
        
        collectionHistory?.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.top, animated: false)
        print("nah")
        
        
        //This text is used in chatHomeController to scroll down
        
        /*
        if(hasRunBottomWithoutAnimationOnce == false){
            collectionHistory?.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.top, animated: false)
            print("nah")
            
        }
        else{
            collectionHistory?.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.top, animated: true)
            print("yah")
        }
        */
        
    }
    

}

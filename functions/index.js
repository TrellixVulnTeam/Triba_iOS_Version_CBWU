
'use strict'
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });



exports.addLikeDislikeToUserBranchCHATC = functions.database.ref('/CHATLIKESDISLIKES/{chatID}/{postID}/LDNOTES/{userID}').onCreate(event => {
    // const post = event.data.val()
     //post.postCreator = post.postCreator + "erre"
     const userPost = event.data.val()
     console.log(userPost.rating);
     console.log("ADLU");
  
     console.log(userPost.postLink);
  
    const userLink = userPost.postLink
    const userRating = userPost.rating
   
    const userID = userPost.likedUserID
    const pID = userPost.postID
    const commentID = userPost.commentID
    const userIDandRating = commentID+":"+userRating
  
  
  
    var db = admin.database()
    var ref = db.ref("LIKEDPOSTCHAT/")
  
  
   var likeHistoryBranch = ref.child(pID+"/"+userID+"/"+commentID)
  
  
   likeHistoryBranch.set(userIDandRating)
  
  
  
    var collectionRef = event.data.ref.parent.parent.parent.parent.parent.child(userLink);
  
   return collectionRef.transaction(function(current) {
     if (userRating == "Y") {
       return (current || 0) + 1;
     }
     else {
       return (current || 0) - 1;
     }
   });
  
   
  
  
     return userPost
  
     
  
  }
  
  ) 
  
  exports.addLikeDislikeToUserBranchCHATU = functions.database.ref('/CHATLIKESDISLIKES/{chatID}/{postID}/LDNOTES/{userID}').onUpdate(event => {
    // const post = event.data.val()
     //post.postCreator = post.postCreator + "erre"
     const userPost = event.data.val()
     console.log(userPost.rating);
     console.log("ADLU");
  
     console.log(userPost.postLink);
  
    const userLink = userPost.postLink
    const userRating = userPost.rating
    const userID = userPost.likedUserID
    const pID = userPost.postID
    const commentID = userPost.commentID
    const userIDandRating = commentID+":"+userRating
   
    
    var db = admin.database()
    var ref = db.ref("LIKEDPOSTCHAT/")
  
  
   var likeHistoryBranch = ref.child(pID+"/"+userID+"/"+commentID)
  
  
   likeHistoryBranch.set(userIDandRating)
  
  
    var collectionRef = event.data.ref.parent.parent.parent.parent.parent.child(userLink);
  
   return collectionRef.transaction(function(current) {
     if (userRating == "Y") {
       return (current || 0) + 1;
     }
     else {
       return (current || 0) - 1;
     }
   });
  
   
  
  
     return userPost
  
     
  
  }
  
  ) 
  
  
  
  exports.addLikeDislikeToUserBranchCOMMENTU = functions.database.ref('/COMMENTLIKESDISLIKES/{postID}/LDNOTES/{userID}').onUpdate(event => {
    // const post = event.data.val()
     //post.postCreator = post.postCreator + "erre"
     const userPost = event.data.val()
     console.log(userPost.rating);
     console.log("ADLU");
  
     console.log(userPost.postLink);
  
    const userLink = userPost.postLink
    const userRating = userPost.rating
    const userID = userPost.likedUserID
    const pID = userPost.postID
    const commentID = userPost.commentID
    const userIDandRating = commentID+":"+userRating
  
  
    // const nPostID = userPost.postID
     //event.data.adminRef.parent.child('postLocations').val()
     
     //const post = event.data.child('postLocations').val()
    // const bubble1 = event.data.child('postBubbles/bubble1').val()
  
  
  
    
  
  
  
    var db = admin.database()
    var ref = db.ref("LIKEDPOSTCOMMENTS/")
  
  
   var likeHistoryBranch = ref.child(pID+"/"+userID+"/"+commentID)
  
  
   likeHistoryBranch.set(userIDandRating)
  
  
    var collectionRef = event.data.ref.parent.parent.parent.parent.child(userLink);
    
  
  
   return collectionRef.transaction(function(current) {
     if (userRating == "Y") {
       return (current || 0) + 1;
     }
     else {
       return (current || 0) - 1;
     }
   });
  
   
  
  
     return userPost
  
     
  
  }
  
  ) 
  
  exports.addLikeDislikeToUserBranchCOMMENTC = functions.database.ref('/COMMENTLIKESDISLIKES/{postID}/LDNOTES/{userID}').onCreate(event => {
    // const post = event.data.val()
     //post.postCreator = post.postCreator + "erre"
     const userPost = event.data.val()
     console.log(userPost.rating);
  
  
     console.log(userPost.postLink);
  
    const userLink = userPost.postLink
    const userRating = userPost.rating
    const userID = userPost.likedUserID
    const CommentID = userPost.commentID
  
    const pID = userPost.postID
    const userIDandRating = CommentID+":"+userRating
  
  
    // const nPostID = userPost.postID
     //event.data.adminRef.parent.child('postLocations').val()
     
     //const post = event.data.child('postLocations').val()
    // const bubble1 = event.data.child('postBubbles/bubble1').val()
  
  
  
  
  
  
    var db = admin.database()
    var ref = db.ref("LIKEDPOSTCOMMENTS/")
  
  
   var likeHistoryBranch = ref.child(pID+"/"+userID+"/"+commentID)
  
  
   likeHistoryBranch.set(userIDandRating)
  
  
  
  
  
    
    var collectionRef = event.data.ref.parent.parent.parent.parent.child(userLink);
    
  
  
   return collectionRef.transaction(function(current) {
     if (userRating == "Y") {
       return (current || 0) + 1;
     }
     else {
       return (current || 0) - 1;
     }
   });
  
   
  
  
     return userPost
  
     
  
  }
  
  ) 
  
  
  
  
  exports.addLikeDislikeToUserBranchU = functions.database.ref('/LIKESDISLIKES/{postID}/LDNOTES/{userID}').onUpdate(event => {
    // const post = event.data.val()
     //post.postCreator = post.postCreator + "erre"
     const userPost = event.data.val()
     console.log(userPost.rating);
     console.log("ADLU");
     console.log(userPost.postID);
     console.log("ADLU");
  
  
  
     console.log(userPost.postLink);
  
    const userLink = userPost.postLink
    const userRating = userPost.rating
    const userID = userPost.likedUserID
    const pID = userPost.postID
    const userIDandRating = pID+":"+userRating
    // const nPostID = userPost.postID
     //event.data.adminRef.parent.child('postLocations').val()
     
     //const post = event.data.child('postLocations').val()
    // const bubble1 = event.data.child('postBubbles/bubble1').val()
  
    const box00 = event.data.child("postLocations").val().box00
    const box01 = event.data.child("postLocations").val().box01
    const box02 = event.data.child("postLocations").val().box02
    const box10 = event.data.child("postLocations").val().box10
    const box11 = event.data.child("postLocations").val().box11
    const box12 = event.data.child("postLocations").val().box12
    const box20 = event.data.child("postLocations").val().box20
    const box21 = event.data.child("postLocations").val().box21
    const box22 = event.data.child("postLocations").val().box22
  
  
    var db = admin.database()
    var ref = db.ref("USERLIKELOC")
  
    /*var newPostRef = ref.push();
    var postId = newPostRef.key;
    */
    
    var box00branch = ref.child(box00+"/"+userID+"/"+pID)
    var box01branch = ref.child(box01+"/"+userID+"/"+pID)
    var box02branch = ref.child(box02+"/"+userID+"/"+pID)
    var box10branch = ref.child(box10+"/"+userID+"/"+pID)
    var box11branch = ref.child(box11+"/"+userID+"/"+pID)
    var box12branch = ref.child(box12+"/"+userID+"/"+pID)
    var box20branch = ref.child(box20+"/"+userID+"/"+pID)
    var box21branch = ref.child(box21+"/"+userID+"/"+pID)
    var box22branch = ref.child(box22+"/"+userID+"/"+pID)
    
      box00branch.set(userIDandRating)
      box01branch.set(userIDandRating)
      box02branch.set(userIDandRating)  
      box10branch.set(userIDandRating)
      box11branch.set(userIDandRating)
      box12branch.set(userIDandRating)
      box20branch.set(userIDandRating)
      box21branch.set(userIDandRating)
      box22branch.set(userIDandRating)
  
    var collectionRef = event.data.ref.parent.parent.parent.parent.child(userLink);
    
  
  
   return collectionRef.transaction(function(current) {
     if (userRating == "L") {
       return (current || 0) + 1;
     }
     else if (userRating == "D") {
      return (current || 0) - 1;
    }
    else if (userRating == "LL") {
      return (current || 0) + 2;
    }
    else if (userRating == "DD") {
      return (current || 0) - 2;
    }
    else if (userRating == "N") {
      return (current ) = 0;
    }
    
   });
  
   
  
  
     return userPost
  
     
  
  }
  
  ) 
  
  exports.addLikeDislikeToUserBranchC = functions.database.ref('/LIKESDISLIKES/{postID}/LDNOTES/{userID}').onCreate(event => {
    // const post = event.data.val()
     //post.postCreator = post.postCreator + "erre"
     const userPost = event.data.val()
     console.log(userPost.rating);
     console.log("ADLC");
  
     console.log(userPost.postLink);
  
    const userLink = userPost.postLink
    const userRating = userPost.rating
    const userID = userPost.likedUserID
    const pID = userPost.postID
    const userIDandRating = pID+":"+userRating
    // const nPostID = userPost.postID
     //event.data.adminRef.parent.child('postLocations').val()
     
     //const post = event.data.child('postLocations').val()
    // const bubble1 = event.data.child('postBubbles/bubble1').val()
  
  
  
  
    const box00 = event.data.child("postLocations").val().box00
    const box01 = event.data.child("postLocations").val().box01
    const box02 = event.data.child("postLocations").val().box02
    const box10 = event.data.child("postLocations").val().box10
    const box11 = event.data.child("postLocations").val().box11
    const box12 = event.data.child("postLocations").val().box12
    const box20 = event.data.child("postLocations").val().box20
    const box21 = event.data.child("postLocations").val().box21
    const box22 = event.data.child("postLocations").val().box22
  
  
    var db = admin.database()
    var ref = db.ref("USERLIKELOC")
  
   /*var newPostRef = ref.push();
    var postId = newPostRef.key;
    */
    
    var box00branch = ref.child(box00+"/"+userID+"/"+pID)
    var box01branch = ref.child(box01+"/"+userID+"/"+pID)
    var box02branch = ref.child(box02+"/"+userID+"/"+pID)
    var box10branch = ref.child(box10+"/"+userID+"/"+pID)
    var box11branch = ref.child(box11+"/"+userID+"/"+pID)
    var box12branch = ref.child(box12+"/"+userID+"/"+pID)
    var box20branch = ref.child(box20+"/"+userID+"/"+pID)
    var box21branch = ref.child(box21+"/"+userID+"/"+pID)
    var box22branch = ref.child(box22+"/"+userID+"/"+pID)
    
      box00branch.set(userIDandRating)
      box01branch.set(userIDandRating)
      box02branch.set(userIDandRating)  
      box10branch.set(userIDandRating)
      box11branch.set(userIDandRating)
      box12branch.set(userIDandRating)
      box20branch.set(userIDandRating)
      box21branch.set(userIDandRating)
      box22branch.set(userIDandRating)
  
  
  
  
    
    var collectionRef = event.data.ref.parent.parent.parent.parent.child(userLink);
    
  
  
   return collectionRef.transaction(function(current) {
    if (userRating == "L") {
      return (current || 0) + 1;
    }
    else if (userRating == "D") {
     return (current || 0) - 1;
   }
   else if (userRating == "LL") {
     return (current || 0) + 2;
   }
   else if (userRating == "DD") {
     return (current || 0) - 2;
   }
   else if (userRating == "N") {
     return (current) = 0;
   }
   });
  
   
  
  
     return userPost
  
     
  
  }
  
  ) 
  
  
  
  
  
  exports.mainMakePostFunction = functions.database.ref('/Users/{pushId}/POSTS/{postID}/postdata').onCreate(event => {
    // const post = event.data.val()
     //post.postCreator = post.postCreator + "erre"
     const userPost = event.data.val()
     const nPostID = userPost.postID
     
     const userID = userPost.postCreator
  
  
     //event.data.adminRef.parent.child('postLocations').val()
     const post = event.data.child('postLocations').val()
     //const bubble1 = event.data.child('postBubbles/bubble1').val()
  
  
     console.log("hh1");
  
  
     //const hihi = postA.creatorName
     const box00n = post.box00
     const box01n = post.box01
     const box02n = post.box02
     const box10n = post.box10
     const box11n = post.box11
     const box12n = post.box12
     const box20n = post.box20
     const box21n = post.box21
     const box22n = post.box22
  
  
     var db = admin.database()
     var ref = db.ref("POSTS")
    // var refBubble = db.ref("Bubbles")
     var refLikeSection = db.ref("LIKESDISLIKES")
  /*
     var bubble1Branch;
  
     if(bubble1.bubbleType == 3){
       bubble1Branch = refBubble.child("SS/"+bubble1.bubbleState+"/"+bubble1.bubbleCity+"/"+bubble1.bubbleBorough+"/"+nPostID)
       bubble1Branch.set(userPost)
  
      }
     else if(bubble1.bubbleType == 2){
      bubble1Branch = refBubble.child("Town/"+bubble1.bubbleState+"/"+bubble1.bubbleCity+"/"+nPostID)
      bubble1Branch.set(userPost)
  
     }
     else if(bubble1.bubbleType == 1){
      bubble1Branch = refBubble.child("General/"+bubble1.bubbleID+"/"+nPostID)
      bubble1Branch.set(userPost)
     }
     
  */
  
  refLikeSection.child(nPostID).set(userPost)
  
  
     var box00branch = ref.child(box00n+"/"+nPostID)
     var box01branch = ref.child(box01n+"/"+nPostID)
     var box02branch = ref.child(box02n+"/"+nPostID)
     var box10branch = ref.child(box10n+"/"+nPostID)
     var box11branch = ref.child(box11n+"/"+nPostID)
     var box12branch = ref.child(box12n+"/"+nPostID)
     var box20branch = ref.child(box20n+"/"+nPostID)
     var box21branch = ref.child(box21n+"/"+nPostID)
     var box22branch = ref.child(box22n+"/"+nPostID)
  
     box00branch.set(userPost)
     box01branch.set(userPost)
     box02branch.set(userPost)  
     box10branch.set(userPost)
     box11branch.set(userPost)
     box12branch.set(userPost)
     box20branch.set(userPost)
     box21branch.set(userPost)
     box22branch.set(userPost)
  
  
  
    // var usersRef = ref.child("users")
    /* ref.set({
       alanisawesome: {
         date_of_birth: "June 23, 1912",
         full_name: hihi
       },
       gracehop: {
         date_of_birth: "December 9, 1906",
         full_name: hihi
       }
     })
     
  */
     //return event.data.ref.set(post)
     //return userPost
     //event.data.ref.update(userPost)
  
     return userPost
  
  }
  
  ) 
  
  
  
  
  
  exports.mainUpdatePostFunction = functions.database.ref('/Users/{pushId}/POSTS/{postID}/postdata').onUpdate(event => {
    // const post = event.data.val()
     //post.postCreator = post.postCreator + "erre"
     const userPost = event.data.val()
     const nPostID = userPost.postID
     
     const userID = userPost.postCreator

     

  
  
     //event.data.adminRef.parent.child('postLocations').val()
     const post = event.data.child('postLocations').val()
     //const bubble1 = event.data.child('postBubbles/bubble1').val()
     const postSpecs = event.data.child('postSpecs').val()

     const pIsActive = postSpecs.isActive
     const pHasBeenCleared = postSpecs.hasBeenCleared
  
  
     console.log("hh2");
     console.log("status: "+pIsActive);

  
  
     //const hihi = postA.creatorName
     const box00n = post.box00
     const box01n = post.box01
     const box02n = post.box02
     const box10n = post.box10
     const box11n = post.box11
     const box12n = post.box12
     const box20n = post.box20
     const box21n = post.box21
     const box22n = post.box22
  
  
     var db = admin.database()
     var ref = db.ref("POSTS")
     //var refBubble = db.ref("Bubbles")
     var refLikeSection = db.ref("LIKESDISLIKES")
  
     //var bubble1Branch;
  
     /*if(bubble1.bubbleType == 3){
       bubble1Branch = refBubble.child("SS/"+bubble1.bubbleState+"/"+bubble1.bubbleCity+"/"+bubble1.bubbleBorough+"/"+nPostID)
       bubble1Branch.set(userPost)
  
      }
     else if(bubble1.bubbleType == 2){
      bubble1Branch = refBubble.child("Town/"+bubble1.bubbleState+"/"+bubble1.bubbleCity+"/"+nPostID)
      bubble1Branch.set(userPost)
  
     }
     else if(bubble1.bubbleType == 1){
      bubble1Branch = refBubble.child("General/"+bubble1.bubbleID+"/"+nPostID)
      bubble1Branch.set(userPost)
     }
     */
     var box00branch = ref.child(box00n+"/"+nPostID)
     var box01branch = ref.child(box01n+"/"+nPostID)
     var box02branch = ref.child(box02n+"/"+nPostID)
     var box10branch = ref.child(box10n+"/"+nPostID)
     var box11branch = ref.child(box11n+"/"+nPostID)
     var box12branch = ref.child(box12n+"/"+nPostID)
     var box20branch = ref.child(box20n+"/"+nPostID)
     var box21branch = ref.child(box21n+"/"+nPostID)
     var box22branch = ref.child(box22n+"/"+nPostID)


     if(pIsActive == false){
        if(pHasBeenCleared == false){

          console.log("deleting: "+pIsActive);

          box00branch.set(null)
          box01branch.set(null)
          box02branch.set(null)
          box10branch.set(null)
          box11branch.set(null)
          box12branch.set(null)
          box20branch.set(null)
          box21branch.set(null)
          box22branch.set(null)

          var refHBC = db.ref("Users").child(userID+"/POSTS/"+nPostID+"/postdata/postSpecs/hasBeenCleared")
          refHBC.set(true)


        }
        else{
          //DOES NOTHING since the post is inactive and has already been removed.
          //This will be for users who already had the post loaded before it was deleted
        }


     }
     else{
      console.log("deployingtoBoxes: "+pIsActive);

      box00branch.set(userPost)
      box01branch.set(userPost)
      box02branch.set(userPost)  
      box10branch.set(userPost)
      box11branch.set(userPost)
      box12branch.set(userPost)
      box20branch.set(userPost)
      box21branch.set(userPost)
      box22branch.set(userPost)
   


     }
     
  


  
  
    // var usersRef = ref.child("users")
    /* ref.set({
       alanisawesome: {
         date_of_birth: "June 23, 1912",
         full_name: hihi
       },
       gracehop: {
         date_of_birth: "December 9, 1906",
         full_name: hihi
       }
     })
     
  */
     //return event.data.ref.set(post)
     return true
     //event.data.ref.update(userPost)
  
     
  
  }
  
  ) 
  
  
  
  
  
  
  
  
  
  
  
  
  
  /*
  exports.dFunk = functions.database.ref('/server/saving-data/{locationdata}/{pushId}').onWrite(event => {
    //const post = event.data.child('/{pushId}').val()
    //post.title = "hihi"
  
    const post = event.data.val()
      post.a = "hihi"
    
    const ref = event.data.ref.parent;
    //const oldItemsQuery = ref.orderByChild('timestamp').endAt(cutoff);
    const oldItemsQuery = ref.orderByChild('a').endAt(7);
  
  
    var db = admin.database()
  //var ref = db.ref("server/saving-data/{pushId}/users/{pushId}")
  
   // post.child(users).a = 3
  //if(post.a < 5){
  
    return oldItemsQuery.once('value').then(snapshot => {
      // create a map with all children that need to be removed
      const updates = {};
  
      snapshot.forEach(child => {
        updates[child.key] = null;
        console.log("yoyo")
  
      });
  
      // execute all updates in one go and return the result to end the function
      return ref.update(updates);
    });
  
  //return event.data.ref.set(post)
  }
  
  )
  */




  exports.notedPost = functions.database.ref('/notedPostsHistory/{userID}/{postID}').onWrite(event => {
    // const post = event.data.val()
     //post.postCreator = post.postCreator + "erre"
     const userPost = event.data.val()
     const nPostID = userPost.postID
     
     const userID = userPost.postNoterID

     

  
  
     //event.data.adminRef.parent.child('postLocations').val()
     const post = event.data.child('postLocations').val()
     //const bubble1 = event.data.child('postBubbles/bubble1').val()
     const postSpecs = event.data.child('postSpecs').val()

     const pIsActive = postSpecs.isActive
     const pHasBeenCleared = postSpecs.hasBeenCleared
  
  
     console.log("status: "+pIsActive);

  
  
     //const hihi = postA.creatorName
     const box00n = post.box00
     const box01n = post.box01
     const box02n = post.box02
     const box10n = post.box10
     const box11n = post.box11
     const box12n = post.box12
     const box20n = post.box20
     const box21n = post.box21
     const box22n = post.box22
     console.log("A");

  
     var db = admin.database()
     var ref = db.ref("notedPostLocationBoxes")
     console.log("B");
     console.log("box: "+box00n);
     console.log("uid: "+userID);
     console.log("npostid: "+nPostID);
     console.log("B.5");


  
     var box00branch = ref.child(box00n+"/"+userID+"/"+nPostID)
     var box01branch = ref.child(box01n+"/"+userID+"/"+nPostID)
     var box02branch = ref.child(box02n+"/"+userID+"/"+nPostID)
     var box10branch = ref.child(box10n+"/"+userID+"/"+nPostID)
     var box11branch = ref.child(box11n+"/"+userID+"/"+nPostID)
     var box12branch = ref.child(box12n+"/"+userID+"/"+nPostID)
     var box20branch = ref.child(box20n+"/"+userID+"/"+nPostID)
     var box21branch = ref.child(box21n+"/"+userID+"/"+nPostID)
     var box22branch = ref.child(box22n+"/"+userID+"/"+nPostID)

     console.log("C");

     if(pIsActive == false){
        if(pHasBeenCleared == false){

          console.log("deleting: "+pIsActive);

          box00branch.set(null)
          box01branch.set(null)
          box02branch.set(null)
          box10branch.set(null)
          box11branch.set(null)
          box12branch.set(null)
          box20branch.set(null)
          box21branch.set(null)
          box22branch.set(null)

          var refHBC = db.ref("notedPostsHistory").child(userID+"/"+nPostID)
          refHBC.set(null)


        }
        else{
          //DOES NOTHING since the post is inactive and has already been removed.
          //This will be for users who already had the post loaded before it was deleted
        }


     }
     else{
      console.log("deployingtoBoxes: "+pIsActive);

      box00branch.set(nPostID)
      box01branch.set(nPostID)
      box02branch.set(nPostID)  
      box10branch.set(nPostID)
      box11branch.set(nPostID)
      box12branch.set(nPostID)
      box20branch.set(nPostID)
      box21branch.set(nPostID)
      box22branch.set(nPostID)
   


     }

     return true

  }
  
  ) 


  exports.notedPostUpdate = functions.database.ref('/notedPostsHistory/{userID}/{postID}').onUpdate(event => {
    // const post = event.data.val()
     //post.postCreator = post.postCreator + "erre"
     const userPost = event.data.val()
     const nPostID = userPost.postID
     
     const userID = userPost.postNoterID

     

  
  
     //event.data.adminRef.parent.child('postLocations').val()
     const post = event.data.child('postLocations').val()
     //const bubble1 = event.data.child('postBubbles/bubble1').val()
     const postSpecs = event.data.child('postSpecs').val()

     const pIsActive = postSpecs.isActive
     const pHasBeenCleared = postSpecs.hasBeenCleared
  
  
     console.log("hh2");
     console.log("status: "+pIsActive);

  
  
     //const hihi = postA.creatorName
     const box00n = post.box00
     const box01n = post.box01
     const box02n = post.box02
     const box10n = post.box10
     const box11n = post.box11
     const box12n = post.box12
     const box20n = post.box20
     const box21n = post.box21
     const box22n = post.box22
  
  
     var db = admin.database()
     var refLikeSection = db.ref("notedPostLocationBoxes")
  
  
     var box00branch = ref.child(box00n+"/"+userID+"/"+nPostID)
     var box01branch = ref.child(box01n+"/"+userID+"/"+nPostID)
     var box02branch = ref.child(box02n+"/"+userID+"/"+nPostID)
     var box10branch = ref.child(box10n+"/"+userID+"/"+nPostID)
     var box11branch = ref.child(box11n+"/"+userID+"/"+nPostID)
     var box12branch = ref.child(box12n+"/"+userID+"/"+nPostID)
     var box20branch = ref.child(box20n+"/"+userID+"/"+nPostID)
     var box21branch = ref.child(box21n+"/"+userID+"/"+nPostID)
     var box22branch = ref.child(box22n+"/"+userID+"/"+nPostID)


     if(pIsActive == false){
        if(pHasBeenCleared == false){

          console.log("deleting: "+pIsActive);

          box00branch.set(null)
          box01branch.set(null)
          box02branch.set(null)
          box10branch.set(null)
          box11branch.set(null)
          box12branch.set(null)
          box20branch.set(null)
          box21branch.set(null)
          box22branch.set(null)

          var refHBC = db.ref("notedPostsHistory").child(userID+"/"+nPostID)
          refHBC.set(null)


        }
        else{
          //DOES NOTHING since the post is inactive and has already been removed.
          //This will be for users who already had the post loaded before it was deleted
        }


     }
     else{
      console.log("deployingtoBoxes: "+pIsActive);

      box00branch.set(nPostID)
      box01branch.set(nPostID)
      box02branch.set(nPostID)  
      box10branch.set(nPostID)
      box11branch.set(nPostID)
      box12branch.set(nPostID)
      box20branch.set(nPostID)
      box21branch.set(nPostID)
      box22branch.set(nPostID)
   


     }

     return true

  }
  
  ) 


  //        ref?.child("Users").child((passedObject?.postCreatorID)!).child("POSTS").child((passedObject?.postID)!).child("CHATS").child(postID).setValue(post)

  exports.chatTextCountAddedText = functions.database.ref('/Users/{creatorID}/POSTS/{postID}/CHATS/{chatTextID}').onWrite(event => {
  
     const userPost = event.data.val()
     console.log("chatTextCountAddedText");
  
    
    var collectionRef = event.data.ref.parent.parent.child("postdata/textCount");

   return collectionRef.transaction(function(current) {
      return (current || 0) + 1;
 
   });

     return userPost
  
     
  
  }
  
  ) 
/*
  exports.chatTextCountSubtractedtext = functions.database.ref('/Users/{creatorID}/POSTS/{postID}/CHATS/{chatTextID}').onDelete(event => {
  
    const userPost = event.data.val()
    console.log("chatTextCountAddedText");
 
   
   var collectionRef = event.data.ref.parent.parent.parent.parent.child("postdata/textCount");

  return collectionRef.transaction(function(current) {
     return (current || 0) - 1;

  });

    return userPost
 
    
 
 }
 
 ) 
 */
  
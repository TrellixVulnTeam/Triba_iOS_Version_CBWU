//
//  orderChangeViewController.swift
//  tiatwpbnw
//
//  Created by David A on 3/23/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class orderChangeViewController: UIViewController {
    
    var passedVal:String?
    var passedCurrentOrderType:String?

    var delegate:aCustomDelegate?

    @IBOutlet weak var btnNormalRanking: UIButton!
    
    @IBOutlet weak var btnRatingRanking: UIButton!
    @IBOutlet weak var btnPopularChats: UIButton!
    
    @IBAction func btnExit(_ sender: Any) {
        
       // if let delegate = self.delegate {
       // delegate?.DoSomething()
        
       /* func loadPostsRanking(passedBoxList:String)
        func loadPostsNormal(passedBoxList:String)
       */
        //let parentVC = self.presentingViewController as! tabHomeViewController
        //parentVC.DoSomething()
        
        
        
            self.removeAnimate()
        //}
        
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)

       self.showAnimate()
        
        btnNormalRanking.addTarget(self, action: #selector(runNormalRanking(sender:)), for: .touchUpInside)
        btnRatingRanking.addTarget(self, action: #selector(runRatingRanking(sender:)), for: .touchUpInside)
        btnPopularChats.addTarget(self, action: #selector(runChatSizeRanking(sender:)), for: .touchUpInside)
        
        
       // btnPopularChats.titleLabel?.text = passedCurrentOrderType
        
        
        //Do this now
        //set up defaut that's passed to this
        //set up way to change default on return
        if(passedCurrentOrderType == "normal"){
            
            btnNormalRanking.backgroundColor =  #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            btnRatingRanking.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            btnPopularChats.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)

            
        }
        else if(passedCurrentOrderType == "rating"){
            btnNormalRanking.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            btnRatingRanking.backgroundColor =  #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            btnPopularChats.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            
        }
        else if(passedCurrentOrderType == "chatSize"){
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   @objc func runNormalRanking(sender: Any)
    {
        
        if(passedCurrentOrderType != "normal"){
        
        delegate?.loadPostsNormal(passedBoxList: passedVal!)
        }
      
        self.removeAnimate()
    }
  @objc  func runRatingRanking(sender: Any)
    {
        if(passedCurrentOrderType != "rating"){
        delegate?.loadPostsRanking(passedBoxList: passedVal!)
        }
        self.removeAnimate()
    }
   @objc func runChatSizeRanking(sender: Any)
    {
        if(passedCurrentOrderType != "textCount"){
        delegate?.loadPostByChatCount(passedBoxList: passedVal!)
        }
        self.removeAnimate()
     
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



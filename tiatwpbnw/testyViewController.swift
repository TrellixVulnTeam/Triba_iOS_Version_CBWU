//
//  testyViewController.swift
//  tiatwpbnw
//
//  Created by David A on 6/5/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class testyViewController: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.tabBarController as! homeTabBar).centerButtonAppear();
        
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
    
    @IBAction func selectorY(_ sender: segmentFoundationUIView) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("0")
        case 1:
            print("1")
        default:
            print("hi")
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  updateForcedViewController.swift
//  tiatwpbnw
//
//  Created by David A on 5/31/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class updateForcedViewController: UIViewController {

    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var lblBackText: UILabel!
    
    var passedURL:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblBackText.setTextColorToGradient(image: #imageLiteral(resourceName: "backgroundTextTriba"))
        backgroundView.alpha = CGFloat(0.25)
  
    
    }

    @IBOutlet weak var lblNeededVersion: UILabel!
    @IBOutlet weak var lblCurrentVersion: UILabel!
    @IBAction func btnGoToUpdate(_ sender: Any) {
        guard let url = URL(string: passedURL) else {
            return //be safe
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)

        
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

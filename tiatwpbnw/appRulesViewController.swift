//
//  appRulesViewController.swift
//  tiatwpbnw
//
//  Created by David A on 7/5/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class appRulesViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if(isFirstTimeUserVar.isFirstTimeUser){
            
            lblTitle.text = "Welcome to Triba! Here are the rules:"
        }
        isFirstTimeUserVar.isFirstTimeUser = false

       

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.showAnimate()
        
        viewPopup.layer.cornerRadius = 12
        viewPopup.clipsToBounds = true
        viewPopup.layer.borderWidth = 2
        viewPopup.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)

    }
   
    
    @IBAction func btnExit(_ sender: Any) {
        self.removeAnimate()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var viewPopup: UIView!
  
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

}

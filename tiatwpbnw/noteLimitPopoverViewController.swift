//
//  noteLimitPopoverViewController.swift
//  tiatwpbnw
//
//  Created by David A on 8/16/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class noteLimitPopoverViewController: UIViewController {
    @IBOutlet weak var viewPopover: UIView!
    
    @IBAction func btnClosePopover(_ sender: Any) {
        
        removeAnimate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)

        
        showAnimate()
        
        viewPopover.layer.masksToBounds = true
        viewPopover.layer.cornerRadius = 8;
        viewPopover.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)
        viewPopover.layer.borderWidth = 1    }

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

}

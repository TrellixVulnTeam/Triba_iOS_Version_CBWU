//
//  fadeInSegue.swift
//  tiatwpbnw
//
//  Created by David A on 3/28/18.
//  Copyright © 2018 David A. All rights reserved.
//

import Foundation
import UIKit

class fadeinSegue: UIStoryboardSegue {
    
    var placeholderView: UIViewController?
    
    override func perform() {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        if let placeholder = placeholderView {
            placeholder.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            
            placeholder.view.alpha = 0
            source.view.addSubview(placeholder.view)
            
            UIView.animate(withDuration: 0.4, animations: {
                placeholder.view.alpha = 1
            }, completion: { (finished) in
                self.source.present(self.destination, animated: false, completion: {
                    placeholder.view.removeFromSuperview()
                })
            })
        } else {
            self.destination.view.alpha = 0.0
            
            self.source.present(self.destination, animated: false, completion: {
                UIView.animate(withDuration: 0.4, animations: {
                    self.destination.view.alpha = 1.0
                })
            })
        }
    }
}

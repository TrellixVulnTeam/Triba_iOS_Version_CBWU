//
//  cusSeg.swift
//  tiatwpbnw
//
//  Created by David A on 6/28/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class cusSeg: UISegmentedControl {

    //let selectedBackgroundColor = UIColor(red: 19/255, green: 59/255, blue: 85/255, alpha: 0.5)
    var sortedViews: [UIView]!
    var currentIndex: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        sortedViews = self.subviews.sorted(by:{$0.frame.origin.x < $1.frame.origin.x})
        changeSelectedIndex(to: currentIndex)
        self.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
      /*  self.tintColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        */
       // self.layer.cornerRadius = 4
        //self.clipsToBounds = true
        let unselectedAttributes = [kCTForegroundColorAttributeName: UIColor.red,
                                    kCTFontAttributeName:  UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)]
        
        //self.setTitleTextAttributes(unselectedAttributes, for: .normal)
       // self.setTitleTextAttributes(unselectedAttributes, for: .selected)
        
        self.layer.cornerRadius = 5.0;
       // self.layer.cornerRadius = 12.0;

        //self.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1);

        self.layer.borderWidth = 1.0;

        self.layer.masksToBounds = true;
    }
    
    func changeSelectedIndex(to newIndex: Int) {
      /*  sortedViews[currentIndex].backgroundColor = UIColor.clear
        currentIndex = newIndex
        self.selectedSegmentIndex = UISegmentedControlNoSegment
        sortedViews[currentIndex].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        */
    }
    
    func changeBorderColor( newColor: CGColor) {
    
        self.layer.borderColor = newColor;

    }
    
}

//
//  backgroundGradientView.swift
//  tiatwpbnw
//
//  Created by David A on 6/26/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

@IBDesignable public class backgroundGradientView: UIView {

    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.black.cgColor, UIColor.blue.cgColor]
    }

   // self.view.layer.configureGradientBackground(UIColor.purple.cgColor, UIColor.blue.cgColor, UIColor.white.cgColor)

    
}



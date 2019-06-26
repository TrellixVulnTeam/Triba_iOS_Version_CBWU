//
//  frostyTabBar.swift
//  tiatwpbnw
//
//  Created by David A on 7/17/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class frostyTabBar: UITabBar {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
      
        frost.frame = bounds
        frost.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(frost, at: 0)
    }

}

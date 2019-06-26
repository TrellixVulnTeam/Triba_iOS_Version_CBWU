//
//  reverseFlow.swift
//  tiatwpbnw
//
//  Created by David A on 6/7/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class reverseFlow: UICollectionViewFlowLayout {
    
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            let attributes = super.layoutAttributesForElements(in: rect)
            
            var leftMargin = sectionInset.left
            var maxY: CGFloat = -1.0
            attributes?.forEach { layoutAttribute in
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                
                layoutAttribute.frame.origin.x = leftMargin
                
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY , maxY)
            }
            
            return attributes
        }
    

}

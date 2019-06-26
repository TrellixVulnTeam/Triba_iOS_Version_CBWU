//
//  HomePostCollectionViewCell.swift
//  tiatwpbnw
//
//  Created by David A on 3/7/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class HomePostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btnRemoveBlurryView: UIButton!
    @IBOutlet weak var blurredView: UIView!
    @IBOutlet weak var btnUpvote: UIButton!
    @IBOutlet weak var btnDownvote: UIButton!
    
    @IBOutlet weak var btnNotePost: UIButton!
    
    @IBOutlet weak var btnReport: UIButton!
    
    
    @IBOutlet weak var txtPostTextlbl: UILabel!
    
    
    
    

    @IBOutlet weak var viewPostType: UIView!

    @IBOutlet weak var lblNotedPostStatus: UILabel!
}

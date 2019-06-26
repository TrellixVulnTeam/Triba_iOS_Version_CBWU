//
//  newUserTutorialViewController.swift
//  tiatwpbnw
//
//  Created by David A on 8/13/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class newUserTutorialViewController: UIViewController {
    @IBOutlet weak var viewMainViewHolder: UIView!
    @IBOutlet weak var viewSlide1: UIView!
    @IBOutlet weak var viewSlide2: UIView!
    
    @IBOutlet weak var viewBackText: UIView!
    @IBOutlet weak var lblBackText: UILabel!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    var currentLocation = 0
     var slideArray: [UIView] = []

       @objc   func goToNextPage(sender : UIButton) {
        if(currentLocation < 1){
            currentLocation += 1
            pageControl.currentPage = currentLocation
            slideArray[currentLocation - 1].isHidden = true

            slideArray[currentLocation ].isHidden = false
            
            if(currentLocation == 1){
                btnNext.setTitle("OK", for: .normal)

            }
            
            if(currentLocation != 0){
                btnBack.setTitle("Back", for: .normal)
                
            }
            

            
        }
        else{

            removeAnimate()
        }
        
    }
    @IBOutlet weak var lblNoBullying: UILabel!
    @objc   func goToBackPage(sender : UIButton) {
        
        
        if(currentLocation > 0){
            currentLocation -= 1
            pageControl.currentPage = currentLocation
            slideArray[currentLocation + 1].isHidden = true
            
            slideArray[currentLocation ].isHidden = false
            
            if(currentLocation != 1){
                btnNext.setTitle("Next", for: .normal)
                
            }
            
            if(currentLocation != 0){
                btnBack.setTitle("Back", for: .normal)
                
            }
            else{
                btnBack.setTitle(" ", for: .normal)

            }
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)

        showAnimate()
        
        lblNoBullying.sizeToFit()
        
         slideArray = [viewSlide1, viewSlide2]

        btnNext.addTarget(self, action: #selector(goToNextPage(sender:)), for: .touchUpInside)
        btnBack.addTarget(self, action:  #selector(goToBackPage(sender:)), for: .touchUpInside)

        
        viewMainViewHolder.layer.masksToBounds = true
        viewMainViewHolder.layer.cornerRadius = 8;
        viewMainViewHolder.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)

        viewMainViewHolder.layer.borderWidth = 1
        
        lblBackText.setTextColorToGradient(image: #imageLiteral(resourceName: "backgroundTextTriba"))
        viewBackText.alpha = CGFloat(0.25)
        
        viewSlide1.isHidden = false
        viewSlide2.isHidden = true
        
        isFirstTimeUserVar.isFirstTimeUser = false

        
        pageControl.currentPage = currentLocation

        btnBack.setTitle(" ", for: .normal)

        // Do any additional setup after loading the view.
    }

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
        self.dismiss(animated: true, completion: nil)

        
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

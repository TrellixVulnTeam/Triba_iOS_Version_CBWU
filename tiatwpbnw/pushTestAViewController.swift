//
//  pushTestAViewController.swift
//  tiatwpbnw
//
//  Created by David A on 3/22/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class pushTestAViewController: UIViewController , UIViewControllerTransitioningDelegate, UINavigationControllerDelegate{

    @IBAction func btnGoToB(_ sender: Any) {
      let myVC = storyboard?.instantiateViewController(withIdentifier: "pushTestBViewController") as! pushTestBViewController
        //self.navigationController?.pushViewController(myVC, animated: true)
        
        let vc = pushTestBViewController() //change this to your class name
        //self.present(myVC, animated: true, completion: nil)

        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "pushTestBViewController") as! pushTestBViewController
       // self.present(vc2, animated: true, completion: nil)
       // self.navigationController?.pushViewController(vc, animated: true)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "pushTestBViewController") as! pushTestBViewController
       
       
       // self.navigationController?.pushViewController(newViewController, animated: true)
        

       // self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    let simpleOver = transitionsForViewsClass()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self as! UINavigationControllerDelegate

        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(showSecondViewController))
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeGestureRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    
   
    @objc func showSecondViewController() {
        self.performSegue (withIdentifier: "segBoom", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationControllerOperation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        simpleOver.popStyle = (operation == .pop)
        return simpleOver
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

//
//  searchPostsViewController.swift
//  tiatwpbnw
//
//  Created by David A on 3/7/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class searchPostsViewController: UIViewController {
    @IBOutlet weak var txtSearchTerm: UITextField!
    @IBAction func btnSearch(_ sender: Any) {
 
   
   
        
        //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let newViewController = storyBoard.instantiateViewController(withIdentifier: "chatHomeViewController")
         
        
       let myVC = storyboard?.instantiateViewController(withIdentifier: "pushTestAViewController") as! pushTestAViewController
        self.navigationController?.pushViewController(myVC, animated: true)
 
        /*
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HiViewController")
        self.present(newViewController, animated: true, completion: nil)
      */
        
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

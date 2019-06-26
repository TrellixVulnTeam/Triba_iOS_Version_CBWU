//
//  createDetailedPostTextPopoverViewController.swift
//  tiatwpbnw
//
//  Created by David A on 9/22/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class createDetailedPostTextPopoverViewController: UIViewController {

    weak var mDelegate: filleTextViewDelegate?
    
    var textBoxNum:Int?
    var txtTextboxText:String?
    
    @IBOutlet weak var txtEnteredText: UITextView!
    @IBAction func btnEnterText(_ sender: Any) {
        //mDelegate?.fillTextview(filledData: "victory")
        mDelegate?.fillTextview(filledData: txtEnteredText.text, boxNum: textBoxNum ?? 1)

        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnClosePopover(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEnteredText.becomeFirstResponder()

        if(textBoxNum?.description.isEmpty ?? true){
            textBoxNum = 1
        }
        
        if(!(txtTextboxText?.isEmpty)!){
            txtEnteredText.text = txtTextboxText
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

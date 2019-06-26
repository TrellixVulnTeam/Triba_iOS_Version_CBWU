//
//  segmentFoundationUIView.swift
//  tiatwpbnw
//
//  Created by David A on 6/6/18.
//  Copyright © 2018 David A. All rights reserved.
//

import UIKit

class segmentFoundationUIView: UIControl {
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    
    
 @IBInspectable
    var borderWIdth: CGFloat = 0{
    didSet{
        layer.borderWidth = borderWIdth
        
    }
    
    }
    @IBInspectable
    var borderCOlor: UIColor = UIColor.clear{
        didSet{
            layer.borderColor = borderCOlor.cgColor
            
        }
      
    }
    @IBInspectable
    var commaSeparatedButtonTitles: String = ""{
        didSet{
            updateView()
            
        }
        
    }
    
    @IBInspectable
    var textColor: UIColor = .lightGray{
        didSet{
            updateView()
            
        }
        
    }
    @IBInspectable
    var selectorTextColor: UIColor = .white{
        didSet{
            updateView()
            
        }
        
    }
    @IBInspectable
    var selectorColor: UIColor = .darkGray{
        didSet{
            updateView()
            
        }
        
    }
    
 func swipeLeft(){
    
    
    if(selectedSegmentIndex < 3 ){
        
        let newIndex = selectedSegmentIndex + 1
        buttons[newIndex].sendActions(for: .touchUpInside)
    }
    }
    
   func swipeRight(){
    if(selectedSegmentIndex > 0){
        let newIndex = selectedSegmentIndex - 1
        buttons[newIndex].sendActions(for: .touchUpInside)
    }
    
    }
    
    func updateView(){
        
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview()
        }
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles{
            let button = UIButton(type: .system)
            //let button = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width/4, height: frame.height))

           button.setTitle(buttonTitle, for: .normal)
           button.setTitleColor(textColor, for: .normal)
         
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
            
        }
        
        
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = frame.height/2
        selector.backgroundColor = selectorColor
       // selector.layer.borderColor = #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
       // selector.layer.borderWidth = 2
        addSubview(selector)
        
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true



        
    }
    
    @objc func buttonTapped(button: UIButton){
        for (buttonIndex, btn) in buttons.enumerated(){
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == button{
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = frame.width/CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {self.selector.frame.origin.x = selectorStartPosition
                })
                
            }
            btn.setTitleColor(selectorTextColor, for: .normal)

        
        }
        sendActions(for: .valueChanged)
        
    }
    
    
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
    }
    

}

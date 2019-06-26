//
//  firstLocationVerificationViewController.swift
//  tiatwpbnw
//
//  Created by David A on 3/24/18.
//  Copyright © 2018 David A. All rights reserved.
//
//
//
//Used to enable and verify location before anything else happens
//
//

import UIKit
import CoreLocation

struct locationVariables {
    static var userLat = 0.0
    static var userLong = 0.0
    static var hasSavedLocationOnce = false


}

class firstLocationVerificationViewController: UIViewController,  UICollectionViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var lblShowIt: UILabel!
    @IBOutlet weak var btnGoToSettings: UIButton!
    @IBOutlet weak var imgHihi: UIImageView!
    var locationManager = CLLocationManager()
    var isLocEnabled = false
    var hasRunSeg = false
    
    @IBOutlet weak var lblBackText: UILabel!
    
    @IBOutlet weak var viewBackText: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
            
        }
        
       lblBackText.isHidden = true
        viewBackText.isHidden = true
        
        lblBackText.setTextColorToGradient(image: #imageLiteral(resourceName: "backgroundTextTriba"))
        viewBackText.alpha = CGFloat(0.25)
     
        
        
        btnGoToSettings.addTarget(self, action: #selector(funcGoToSettings(sender:)), for: .touchUpInside)
/*
        btnGoToSettings.layer.masksToBounds = true
        btnGoToSettings.layer.cornerRadius = 8;
        //btnGoToSettings.layer.borderColor =  #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        btnGoToSettings.layer.backgroundColor =  #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        btnGoToSettings.layer.borderWidth = 2
        
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate)
            //txtEventDesc.text = location.coordinate.latitude.description
            
        }
        imgHihi.isHidden = true
        btnGoToSettings.isHidden = true
        lblShowIt.isHidden = true
       
        

        
        
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        print("a" + coord.latitude.description)
        print("b" + coord.longitude.description)
        
        let latt = coord.latitude
        // postLat = Double(round(1000*latt)/1000)
        
        let longg = coord.longitude
        // postLong = Double(round(1000*longg)/1000)
        
        //Sets lat and long for the global variables used throughout the app
        locationVariables.userLat = latt
        locationVariables.userLong = longg

        if(locationVariables.hasSavedLocationOnce == false){
            //userDefault lat and long are not updated while the user is using the app.
            //The are only used as a failsafe if anything happens to the global lat and long variables that are regularly updated
        UserDefaults.standard.set(latt, forKey: "userLat")
        UserDefaults.standard.set(longg, forKey: "userLong")
        locationVariables.hasSavedLocationOnce = true
          

        }
        
        isLocEnabled = true
        
        //This is important, do not remove
        if(hasRunSeg == false){
        
       performSegue(withIdentifier:"segGTSignIn", sender: self)
            hasRunSeg = true
        }

        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            //If location denied and default location access prompt has already been denied, our pop-up will be shown
            showLocationDisabledPopUp()
            isLocEnabled = false
            
        }
    }
    
    func checkLocation()  -> Bool{
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            }
        } else {
            return false
        }
    }
    
    func showLocationDisabledPopUp() {
        //txtBooya.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        imgHihi.isHidden = false
        btnGoToSettings.isHidden = false
        lblShowIt.isHidden = false
        
        lblBackText.isHidden = false
        viewBackText.isHidden = false
        
        let alertController = UIAlertController(title: " Location Access Disabled",
                                                message: "In order to find nearby posts, we need your location",
                                                preferredStyle: .alert)
        
        // let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //  alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
     @objc func funcGoToSettings(sender : UIButton){
        
        if let url = URL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
 

}

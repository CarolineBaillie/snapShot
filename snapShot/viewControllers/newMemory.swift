//
//  memoryInfo.swift
//  snapShot
//
//  Created by Caroline Baillie on 12/27/20.
//

import Foundation
import UIKit
import MapKit
import Parse
import CoreLocation

class newMemory : UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    var image : UIImage!
    private var locationManager:CLLocationManager?
    //date picker stuff
//    private var datePicker: UIDatePicker?
    
    @IBOutlet weak var memTitle: UITextField!
    @IBOutlet weak var memCategory: UITextField!
    @IBOutlet weak var memImage: UIImageView!
    @IBOutlet weak var memDesc: UITextView!
    @IBOutlet weak var memLocation: UITextField!
    @IBOutlet weak var memTags: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For Computer
//        image = UIImage(named: "test")
        // For both
        self.memImage.image = image
    }
    
    //dismiss keyboard when tapped
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func saveToggled(_ sender: Any) {
        self.showSpinner()
        // For Computer
        let coord = CLLocationCoordinate2D(latitude: Double.random(in: 26..<29), longitude: Double.random(in: -81 ..< -78))
        // find current location
//        getUserLocation()
//        let coord = sessionManager.shared.currentCoord
        // get current date
        let date = Date()
        let calendar = Calendar.current
        let y = calendar.component(.year, from: date)
        let m = calendar.component(.month, from: date)
        let d = calendar.component(.day, from: date)
        let dateNow = "\(m)/\(d)/\(y)"
        // create new memory
        let newMem = Memory(title: memTitle.text!, Image: image, coordinate: coord, desc: memDesc.text!, category: memCategory.text!, tags: memTags.text!, location: memLocation.text!, date: dateNow, objID: "none")
        // save memory
        sessionManager.shared.saveMemory(memory: newMem) { (success) in
            // move to next view controller
            NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
    // get user location stuff
    func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            sessionManager.shared.currentCoord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
}

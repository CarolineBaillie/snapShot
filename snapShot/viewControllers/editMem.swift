//
//  editMem.swift
//  snapShot
//
//  Created by Caroline Baillie on 2/26/21.
//

import Foundation
import UIKit
import MapKit
import Parse
import CoreLocation

class editMem: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    var page : Memory!
    var map : Bool?
    
    @IBOutlet weak var memTitle: UITextField!
    @IBOutlet weak var memCategory: UITextField!
    @IBOutlet weak var memImage: UIImageView!
    @IBOutlet weak var memDesc: UITextView!
    @IBOutlet weak var memTags: UITextView!
    @IBOutlet weak var memLocation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set all input fields to the previous values
        memTitle.text = page.title
        memCategory.text = page.category
        memDesc.text = page.desc
        memTags.text = page.tags
        memLocation.text = page.location
        memImage.image = page.Image
    }
    
    //dismiss keyboard when tapped
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func memUpdate(_ sender: Any) {
        self.showSpinner()
        // can't edit coord or image
        let coord = page.coordinate
        let image = page.Image
        // create new memory with inputted info
        let newMem = Memory(title: memTitle.text!, Image: image, coordinate: coord, desc: memDesc.text!, category: memCategory.text!, tags: memTags.text!, location: memLocation.text!, date: page.date, objID: page.objID)
        // call update function
        sessionManager.shared.updateMemory(memory: newMem) { (success) in
            self.removeSpinner()
            // if called from map rather than tables
            if self.map == true {
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "memInfoPage") as! memInfoPage
                VC.page = newMem
                self.dismiss(animated: true, completion: nil)
                // call reload functions so update appears
                NotificationCenter.default.post(name: Notification.Name("reloadContent"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
            } else {
                // push to diff viewController that will go back to settings
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "infoToSettings") as! infoToSettings
                VC.page = newMem
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
}

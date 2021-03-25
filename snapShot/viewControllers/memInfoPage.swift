//
//  memInfoPage.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/25/21.
//

import Foundation
import UIKit
import Parse

class memInfoPage : UIViewController {
    // var from prev page
    var page : Memory!
    var map : Bool?
    // connections
    @IBOutlet weak var memTitle: UILabel!
    @IBOutlet weak var memImage: UIImageView!
    @IBOutlet weak var memDesc: UITextView!
    @IBOutlet weak var memCategory: UILabel!
    @IBOutlet weak var memLocation: UILabel!
    @IBOutlet weak var memTags: UITextView!
    @IBOutlet weak var memDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memTitle.text = page.title
        memTitle.adjustsFontSizeToFitWidth = true
        self.memImage.image = page.Image
        self.memDesc.text = page.desc
        self.memCategory.text = page.category
        self.memLocation.text = page.location
        self.memTags.text = page.tags
        self.memDate.text = page.date
        NotificationCenter.default.addObserver(self, selector: #selector(reloadContent), name: Notification.Name("reloadContent"), object: nil)
    }
    
    @objc func reloadContent (notification: NSNotification){
        self.memTitle.text = page.title
        memTitle.adjustsFontSizeToFitWidth = true
        self.memImage.image = page.Image
        self.memDesc.text = page.desc
        self.memCategory.text = page.category
        self.memLocation.text = page.location
        self.memTags.text = page.tags
        self.memDate.text = page.date
    }
    
    @IBAction func editToggle(_ sender: Any) {
        // put all inputs into the text stuff to be resaved
        // if not navigationController -> push
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "editMem") as! editMem
        VC.page = page
        self.navigationController?.pushViewController(VC, animated: true)
        if self.map == true {
            VC.map = true
            self.present(VC, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteToggle(_ sender: Any) {
        // alert are you sure you want to delete this
        let confirmAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this memory?", preferredStyle: UIAlertController.Style.alert)
        // alert confirmed
        confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            // run delete function
            sessionManager.shared.deleteMemory(memory: self.page) { (success) in
                // go back to settings
                self.navigationController?.popToViewController(ofClass: settings.self)
                // alternate if on map
                if self.map == true {
                    NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }))
        // alert canceled
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            // do nothing
        }))
        // show the alert
        present(confirmAlert, animated: true, completion: nil)
    }
}
// function to go back to settings contoller
extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}

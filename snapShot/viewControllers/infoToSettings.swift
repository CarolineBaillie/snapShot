
//
//  memInfoPage.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/25/21.
//

import Foundation
import UIKit
import Parse

class infoToSettings : UIViewController {
    // var from prev page
    var page : Memory!    // connections
    
    @IBOutlet weak var memTitle: UILabel!
    @IBOutlet weak var memImage: UIImageView!
    @IBOutlet weak var memDesc: UITextView!
    @IBOutlet weak var memCategory: UILabel!
    @IBOutlet weak var memLocation: UILabel!
    @IBOutlet weak var memDate: UILabel!
    @IBOutlet weak var memTags: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.memTitle.text = page.title
        memTitle.adjustsFontSizeToFitWidth = memTitle.minimumScaleFactor == 0.2
        self.memImage.image = page.Image
        self.memDesc.text = page.desc
        self.memCategory.text = page.category
        self.memLocation.text = page.location
        self.memTags.text = page.tags
        self.memDate.text = page.date
    
        let newBackButton = UIBarButtonItem(title: "settings", style: UIBarButtonItem.Style.plain, target: self, action: #selector(settings.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popToViewController(ofClass: settings.self)
    }
    
    @objc func reloadContent (notification: NSNotification){
        self.memTitle.text = page.title
        memTitle.adjustsFontSizeToFitWidth = memTitle.minimumScaleFactor == 0.2
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
    }
    
    @IBAction func deleteToggle(_ sender: Any) {
        // alert are you sure you want to delete this
        // if yes -> delete from database and localstorage array
        let confirmAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this memory?", preferredStyle: UIAlertController.Style.alert)

        confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            // delete code here
            sessionManager.shared.deleteMemory(memory: self.page) { (success) in
                // go back to settings
                self.navigationController?.popToViewController(ofClass: settings.self)
            }
        }))

        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            // delete has been canceled
        }))

        present(confirmAlert, animated: true, completion: nil)
    }
}

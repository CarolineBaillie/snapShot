//
//  settings.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/23/21.
//

import Foundation
import UIKit
import Parse

class settings: UIViewController, UINavigationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get all memories from database
        sessionManager.shared.GetAllMem { (success) in
            if success {
                self.removeSpinner()
            }
        }
        //keep with navigation controller
        var objVC: UIViewController? = storyboard!.instantiateViewController(withIdentifier: "settings")
        var aObjNavi = UINavigationController(rootViewController: objVC!)
        //change back button name for navigation controller
        let newBackButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(settings.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {
        // logout
        PFUser.logOut()
        // go back to first viewController
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

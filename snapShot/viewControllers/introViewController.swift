//
//  introViewController.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/23/21.
//

import Foundation
import UIKit
import Parse

class introViewController: UIViewController {
    
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signup.layer.cornerRadius = 7
        login.layer.cornerRadius = 7
    }
}

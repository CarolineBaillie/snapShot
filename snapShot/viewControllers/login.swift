//
//  login.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/4/21.
//

import Foundation
import UIKit
import Parse

class login: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginToggled(_ sender: Any) {
        // loading icon
        self.showSpinner()
        // login user
        PFUser.logInWithUsername(inBackground:usernameTextField.text!, password:passwordTextField.text!) {
          (user, error) -> Void in
          if user != nil {
            // successful
            // store current User
            var cUser = currentUser(username: user?["username"] as! String, id: user?.objectId as! String)
            sessionManager.shared.user = cUser
            // next controller
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "settings") as! settings
            self.navigationController?.pushViewController(secondViewController, animated: true)
          } else {
            // The login failed.
            print("incorrect username or password")
          }
        }
    }
}

//
//  signup.swift
//  snapShot
//
//  Created by Caroline Baillie on 1/4/21.
//

import Foundation
import UIKit
import Parse

class signup: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //get rid of keyboard when touch screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }

    @IBAction func signupToggled(_ sender: Any) {
        // loading icon
        self.showSpinner()
        // create new user
        let user = PFUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        user.email = emailTextField.text!
        // save user
        user.signUpInBackground { (result, error) in
            if error == nil && result == true {
                //successfully signed up
                // store current User
                let cUser = currentUser(username: user["username"] as! String, id: user.objectId!)
                sessionManager.shared.user = cUser
                //next screen
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "settings") as! settings
                self.navigationController?.pushViewController(secondViewController, animated: true)
                
            }
        }
    }
    

}

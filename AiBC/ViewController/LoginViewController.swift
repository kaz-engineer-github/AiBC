//
//  LoginViewController.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/12/07.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
  
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func loginPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                  self.performSegue(withIdentifier: Constants.Segue.tabBarSegue, sender: self)
                }
            }
        }
    }
}

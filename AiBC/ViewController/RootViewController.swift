//
//  ViewController.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/08.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit
import FirebaseAuth

class RootViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
  @IBAction func anonymousLogin(_ sender: Any) {
      Auth.auth().signInAnonymously() { (authResult, error) in
          if error != nil{
              print("Auth Error :\(error)")
          } else {
              print("success login:\(authResult)")
              self.performSegue(withIdentifier: "tabBarController", sender: nil)
          }
          
      }
  }
  
}


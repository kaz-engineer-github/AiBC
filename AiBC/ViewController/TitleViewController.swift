//
//  TitleViewController.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/12/05.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {
  
    @IBOutlet weak var titleLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ""
        var charaIndex = 0.0
        let titleText = Constants.appName
      
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.2 * charaIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charaIndex += 1
        }
    }
}

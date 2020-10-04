//
//  RootViewController.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/10/03.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit
import Lottie

class RootViewController: UIViewController {
  
    private let lottieAnimation = "1"
    private let animationView = AnimationView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let animation = Animation.named(lottieAnimation)
        animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1.0
        view.addSubview(animationView)
        animationView.play { finished in
            self.performSegue(withIdentifier: "tabBarController", sender: nil)
        }
    }
}

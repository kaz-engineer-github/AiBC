//
//  WebViewController.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/11.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

  @IBOutlet weak var webView: WKWebView!
  var url: URL?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    

}

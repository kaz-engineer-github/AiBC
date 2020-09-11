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
        view.addSubview(webView)
      
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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
    let bookmark = BookmarkModel()
    var articleData = ArticleData(title: "", profileImageURL: "", body: "", tags: "", likesCount: 0, commentsCount: 0, url: "")
  
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: articleData.url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @IBAction func bookmarkPress(_ sender: Any) {
        let bookmarkTitle = articleData.title
        guard let bookmarkProfileImageURL = articleData.profileImageURL else { return }
        let bookmarkBody = articleData.body
        let bookmarkTags = articleData.tags
        let bookmarkURL = articleData.url
        bookmark.bookmarkAction(title: bookmarkTitle, profileImageURL: bookmarkProfileImageURL, body: bookmarkBody, tags: bookmarkTags, url: bookmarkURL)
    }
}

//
//  WebViewController.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/11.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit
import WebKit
import FaveButton

func color(_ rgbColor: Int) -> UIColor{
    return UIColor(
        red:   CGFloat((rgbColor & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbColor & 0x00FF00) >> 8 ) / 255.0,
        blue:  CGFloat((rgbColor & 0x0000FF) >> 0 ) / 255.0,
        alpha: CGFloat(1.0)
    )
}

class WebViewController: UIViewController, FaveButtonDelegate {

    @IBOutlet weak var webView: WKWebView!
    private var bookmarkButton: FaveButton!
    private let bookmark = BookmarkModel()
    var articleData = ArticleData(title: "", profileImageURL: "", body: "", tags: "", likesCount: 0, commentsCount: 0, url: "")
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // MARK: - bookmarkButton
        bookmarkButton = FaveButton(
          frame: CGRect(x:view.frame.size.width - view.frame.size.width/6, y:view.frame.size.height - view.frame.size.height/6, width: 50, height: 50),
            faveIconNormal: UIImage(named: "star.png" )
        )
        bookmarkButton.delegate = self
        view.addSubview(bookmarkButton)
      
        guard let url = URL(string: articleData.url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
  
    // MARK: - Tap bookmarkButton
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        if articleData.isLiked == false {
            let bookmarkTitle = articleData.title
            guard let bookmarkProfileImageURL = articleData.profileImageURL else { return }
            let bookmarkBody = articleData.body
            let bookmarkTags = articleData.tags
            let bookmarkURL = articleData.url
            bookmark.bookmarkAction(title: bookmarkTitle, profileImageURL: bookmarkProfileImageURL, body: bookmarkBody, tags: bookmarkTags, url: bookmarkURL)
            //ブクマのimage変更
            //ブクマされた状態を維持する
            articleData.isLiked = true
            print("ブクマされた")
        } else {
            bookmark.trashBookmarkArticles(title: articleData.title, profileImageURL: articleData.profileImageURL!, body: articleData.body, tags: articleData.tags, url: articleData.url)
            articleData.isLiked = false
            //ブクマのimage変更
            print("ブクマ解除された")
        }
    }
    
    // MARK: - Initial bookmarkButton color
    func faveButtonDotColors(_ faveButton: FaveButton) -> [DotColors]?{
        if( faveButton === bookmarkButton){
            return colors
        }
        return nil
    }
  
    let colors = [
        DotColors(first: color(0x7DC2F4), second: color(0xE2264D)),
        DotColors(first: color(0xF8CC61), second: color(0x9BDFBA)),
        DotColors(first: color(0xAF90F4), second: color(0x90D1F9)),
        DotColors(first: color(0xE9A966), second: color(0xF8C852)),
        DotColors(first: color(0xF68FA7), second: color(0xF6A2B8))
    ]
    
    @IBAction func goPage(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func backPage(_ sender: Any) {
        webView.goBack()
    }
}

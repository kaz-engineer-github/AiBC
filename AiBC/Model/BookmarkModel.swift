//
//  BookmarkModel.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/21.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation
import FirebaseFirestore

class BookmarkModel {
    
    var articleData = ArticleData(title: "", profileImageURL: "", body: "", tags: "", bookmarkCount: 0, commentsCount: 0, url: "")
    let db = Firestore.firestore()
    
    func bookmarkAction(title: String, profileImageURL: String, body: String, tags: String, bookmarkCount: Int, commentsCount: Int,url: String) {
        self.articleData.titleArray.append(title)
        self.articleData.profileImageURLArray.append(profileImageURL)
        self.articleData.urlArray.append(url)
        let bookmarkRef = db.collection("users").document("bookmark_articles")
        bookmarkRef.updateData([
            "title": FieldValue.arrayUnion(articleData.titleArray),
            "profile_image": FieldValue.arrayUnion(articleData.profileImageURLArray),
            "url": FieldValue.arrayUnion(articleData.urlArray)
        ]) { (error) in
               if error != nil {
                   bookmarkRef.setData([
                    "title": self.articleData.titleArray,
                    "profile_image": self.articleData.profileImageURLArray,
                    "url": self.articleData.urlArray
                   ], merge: true)
               }
           }
    }
}

//
//  BookmarkModel.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/21.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol BookmarkModelDelegate: AnyObject {
    func fetchBookmarkArticles(title: [String], profileImageURL: [String], body: [String], tags: [String], url: [String])
}

final class BookmarkModel {
    
    weak var delegate: BookmarkModelDelegate?
    
    var articleData = ArticleData(title: "", profileImageURL: "", body: "", tags: "", likesCount: 0, commentsCount: 0, url: "")
    let db = Firestore.firestore()
    
    func bookmarkAction(title: String, profileImageURL: String, body: String, tags: String, url: String) {
        self.articleData.titleArray.append(title)
        self.articleData.profileImageURLArray.append(profileImageURL)
        self.articleData.bodyArray.append(body)
        self.articleData.tagsArray.append(tags)
        self.articleData.urlArray.append(url)
        let bookmarkRef = db.collection("users").document("bookmark_articles")
        bookmarkRef.updateData([
            "title": FieldValue.arrayUnion(articleData.titleArray),
            "profileImage": FieldValue.arrayUnion(articleData.profileImageURLArray),
            "body": FieldValue.arrayUnion(articleData.bodyArray),
            "tags": FieldValue.arrayUnion(articleData.tagsArray),
            "url": FieldValue.arrayUnion(articleData.urlArray)
        ]) { (error) in
               if error != nil {
                   bookmarkRef.setData([
                       "title": self.articleData.titleArray,
                       "profileImage": self.articleData.profileImageURLArray,
                       "body": self.articleData.bodyArray,
                       "tags": self.articleData.tagsArray,
                       "url": self.articleData.urlArray
                   ], merge: true)
               }
           }
    }
    
    func fetchBookmarkArticles() {
        let docRef = db.collection("users").document("bookmark_articles")
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                guard let titleData = document.data(), let title = Titles(data: titleData) else { return }
                self.articleData.titleArray.append(contentsOf: title.articleTitles)
                guard let bodyData = document.data(), let body = Bodys(data: bodyData) else { return }
                self.articleData.bodyArray.append(contentsOf: body.articleBodys)
                guard let profileImageUrlData = document.data(), let profileImageUrl = ProfileImageUrls(data: profileImageUrlData) else { return }
                self.articleData.profileImageURLArray.append(contentsOf: profileImageUrl.profileImageUrl)
                guard let tagsData = document.data(), let tags = Tags(data: tagsData) else { return }
                self.articleData.tagsArray.append(contentsOf: tags.articleTags)
                guard let urlData = document.data(), let url = Urls(data: urlData) else { return }
                self.articleData.urlArray.append(contentsOf: url.articleUrl)
                self.delegate?.fetchBookmarkArticles(title: articleData.titleArray,profileImageURL: articleData.profileImageURLArray, body: articleData.bodyArray, tags: articleData.tagsArray, url: articleData.urlArray)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func trashBookmarkArticles(title: String, profileImageURL: String, body: String, tags: String, url: String) {
        self.articleData.titleArray.append(title)
        self.articleData.profileImageURLArray.append(profileImageURL)
        self.articleData.bodyArray.append(body)
        self.articleData.tagsArray.append(tags)
        self.articleData.urlArray.append(url)
        db.collection("users").document("bookmark_articles").updateData([
            "title": FieldValue.arrayRemove(articleData.titleArray),
            "profileImage": FieldValue.arrayRemove(articleData.profileImageURLArray),
            "body": FieldValue.arrayRemove(articleData.bodyArray),
            "tags": FieldValue.arrayRemove(articleData.tagsArray),
            "url": FieldValue.arrayRemove(articleData.urlArray)
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}

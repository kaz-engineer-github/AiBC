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
    func fetchBookmarkArticles(document: String)
}

final class BookmarkModel {
    
    weak var delegate: BookmarkModelDelegate?
    
    var articleData = ArticleData(title: "", profileImageURL: "", body: "", tags: "", likesCount: 0, commentsCount: 0, url: "")
    let db = Firestore.firestore()
    var likesCountArray: [String] = []
    var commentsCountArray: [String] = []
    
    func bookmarkAction(title: String, profileImageURL: String, body: String, tags: String, likesCount: Int, commentsCount: Int,url: String) {
        self.articleData.titleArray.append(title)
        self.articleData.profileImageURLArray.append(profileImageURL)
        self.articleData.bodyArray.append(body)
        self.articleData.tagsArray.append(tags)
        self.articleData.likesCountArray.append(likesCount)
        self.articleData.commentsCountArray.append(commentsCount)
        self.articleData.urlArray.append(url)
        let bookmarkRef = db.collection("users").document("bookmark_articles")
        bookmarkRef.updateData([
            "title": FieldValue.arrayUnion(articleData.titleArray),
            "profileImage": FieldValue.arrayUnion(articleData.profileImageURLArray),
            "body": FieldValue.arrayUnion(articleData.bodyArray),
            "tags": FieldValue.arrayUnion(articleData.tagsArray),
            "likesCount": FieldValue.arrayUnion(articleData.likesCountArray),
            "commentsCount": FieldValue.arrayUnion(articleData.commentsCountArray),
            "url": FieldValue.arrayUnion(articleData.urlArray)
        ]) { (error) in
               if error != nil {
                   bookmarkRef.setData([
                       "title": self.articleData.titleArray,
                       "profileImage": self.articleData.profileImageURLArray,
                       "body": self.articleData.bodyArray,
                       "tags": self.articleData.tagsArray,
                       "likesCount": self.articleData.likesCountArray,
                       "commentsCount": self.articleData.commentsCountArray,
                       "url": self.articleData.urlArray
                   ], merge: true)
               }
           }
    }
    
    func fetchBookmarkArticles() {
        let docRef = db.collection("users").document("bookmark_articles")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let titleData = document.data(), let title = Titles(data: titleData) else { return }
                self.articleData.titleArray.append(contentsOf: title.articleTitles)
                guard let bodyData = document.data(), let body = Bodys(data: bodyData) else { return }
                self.articleData.bodyArray.append(contentsOf: body.articleBodys)
                guard let tagsData = document.data(), let tags = Tags(data: tagsData) else { return }
                self.articleData.tagsArray.append(contentsOf: tags.articleTags)
                guard let likesData = document.data(), let likes = LikesCount(data: likesData) else { return }
                self.likesCountArray.append(contentsOf: likes.likesCount)
                guard let commentsData = document.data(), let comments = CommentsCount(data: commentsData) else { return }
                self.commentsCountArray.append(contentsOf: comments.commentsCount)
                guard let urlData = document.data(), let url = Urls(data: urlData) else { return }
                self.commentsCountArray.append(contentsOf: url.articleUrl)
                print("success fetch DB data: \(document)")
                } else {
                    print("Document does not exist")
                }
        }
    }
}

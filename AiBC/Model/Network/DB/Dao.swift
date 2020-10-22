//
//  Dao.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/10/22.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation
import Firebase

protocol DaoDelegate: class {
    func onSuccess()
    func onError(error: Error)
}

final class Dao {
  
    let db = Firestore.firestore()
    weak var delegate: DaoDelegate?
    
    // MARK: - Access DB to preserve articles data
    func bookmarkArticles(title: [String], profileImageURL: [String], body: [String], tags: [String], url: [String]) {
        let bookmarkRef = db.collection("users").document("bookmark_articles")
        bookmarkRef.updateData([
            "title": FieldValue.arrayUnion(title),
            "profileImage": FieldValue.arrayUnion(profileImageURL),
            "body": FieldValue.arrayUnion(body),
            "tags": FieldValue.arrayUnion(tags),
            "url": FieldValue.arrayUnion(url)
        ]) { (error) in
            bookmarkRef.setData([
                "title": title,
                "profileImage": profileImageURL,
                "body": body,
                "tags": tags,
                "url": url
            ], merge: true) { (error) in
                if let e = error {
                    self.delegate?.onError(error: e)
                    return
                }
                self.delegate?.onSuccess()
            }
            self.delegate?.onSuccess()
        }
    }
  
  
//    func bookmarkArticle(title: [String], profileImageURL: [String], body: [String], tags: [String], url: [String]) {
//        if title[0] != nil {
//        let bookmarkRef = db.collection("users").document("bookmark_articles")
//        bookmarkRef.updateData([
//            "title": FieldValue.arrayUnion(title),
//            "profileImage": FieldValue.arrayUnion(profileImageURL),
//            "body": FieldValue.arrayUnion(body),
//            "tags": FieldValue.arrayUnion(tags),
//            "url": FieldValue.arrayUnion(url)
//        ]) { (error) in
//            if let e = error {
//                self.delegate?.onError(error: e)
//                return
//            }
//            self.delegate?.onSuccess()
//        }
//        } else {
//            let bookmarkRef = db.collection("users").document("bookmark_articles")
//            bookmarkRef.setData([
//                "title": title,
//                "profileImage": profileImageURL,
//                "body": body,
//                "tags": tags,
//                "url": url
//            ], merge: true) { (error) in
//                if let e = error {
//                    self.delegate?.onError(error: e)
//                    return
//                }
//                self.delegate?.onSuccess()
//            }
//            self.delegate?.onSuccess()
//        }
//    }
  
    // MARK: - Access DB to fetch articles data
    func fetchBookmarkArticles(title: [String], profileImageURL: [String], body: [String], tags: [String], url: [String]) {
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
  
    // MARK: - Access DB to delete articles data
    func trashBookmarkArticles(title: [String], profileImageURL: [String], body: [String], tags: [String], url: [String]) {
        db.collection("users").document("bookmark_articles").updateData([
            "title": FieldValue.arrayRemove(title),
            "profileImage": FieldValue.arrayRemove(profileImageURL),
            "body": FieldValue.arrayRemove(body),
            "tags": FieldValue.arrayRemove(tags),
            "url": FieldValue.arrayRemove(url)
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}

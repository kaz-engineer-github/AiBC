//
//  Dao.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/10/22.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation
import Firebase

final class Dao {
  
    let db = Firestore.firestore()
    
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
                if error != nil {
                    print("Error")
                    return
                }
            }
        }
        print("success update DB")
    }
  
    // MARK: - Access DB to fetch articles data
//    func fetchBookmarkArticles() {
//        let docRef = db.collection("users").document("bookmark_articles")
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                print("success fetch data")
//            } else {
//                print("Document does not exist")
//            }
//        }
//    }
//
//    // MARK: - Access DB to delete articles data
//    func trashBookmarkArticles(title: [String], profileImageURL: [String], body: [String], tags: [String], url: [String]) {
//        db.collection("users").document("bookmark_articles").updateData([
//            "title": FieldValue.arrayRemove(title),
//            "profileImage": FieldValue.arrayRemove(profileImageURL),
//            "body": FieldValue.arrayRemove(body),
//            "tags": FieldValue.arrayRemove(tags),
//            "url": FieldValue.arrayRemove(url)
//        ]) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//        }
//    }
}

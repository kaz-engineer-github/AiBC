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
  
    private let db = Firestore.firestore()
  
    // MARK: - Access DB to preserve articles data
    //DBに直接アクセスして、記事データを更新(初期設定)する
    func updateData(title: [String], profileImageURL: [String], body: [String], tags: [String], url: [String]) {
        let bookmarkRef = db.collection(Constants.FStore.collectionName).document(Constants.FStore.documentName)
        //データの更新
        bookmarkRef.updateData([
            //配列データに追加
            Constants.FStore.titleField: FieldValue.arrayUnion(title),
            Constants.FStore.profField: FieldValue.arrayUnion(profileImageURL),
            Constants.FStore.bodyField: FieldValue.arrayUnion(body),
            Constants.FStore.tagsField: FieldValue.arrayUnion(tags),
            Constants.FStore.urlField: FieldValue.arrayUnion(url)
        ]) { (error) in
            if error != nil {
                //初期データの追加
                bookmarkRef.setData([
                    Constants.FStore.titleField: title,
                    Constants.FStore.profField: profileImageURL,
                    Constants.FStore.bodyField: body,
                    Constants.FStore.tagsField: tags,
                    Constants.FStore.urlField: url
                ], merge: true)
                return
            }
        }
        print("success update DB")
    }
  
    // MARK: - Access DB to fetch articles data
//    func fetchBookmarkArticles() {
//        let bookmarkRef = db.collection(Constants.FStore.collectionName).document(Constants.FStore.documentName)
//        bookmarkRef.getDocument { (document, error) in
//            if error != nil {
//                print("Document does not exist")
//            } else if let document = document, document.exists {
//
//                print("success fetch data")
//            }
//        }
//    }
}

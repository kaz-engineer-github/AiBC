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
        let ref = db.collection(Constants.FStore.collectionName).document(Constants.FStore.documentName)
        //データがあるか読み取り
        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                //データの更新
                ref.updateData([
                    //配列データに追加
                    Constants.FStore.titleField: FieldValue.arrayUnion(title),
                    Constants.FStore.profField: FieldValue.arrayUnion(profileImageURL),
                    Constants.FStore.bodyField: FieldValue.arrayUnion(body),
                    Constants.FStore.tagsField: FieldValue.arrayUnion(tags),
                    Constants.FStore.urlField: FieldValue.arrayUnion(url)
                ]) { (error) in
                    if error != nil {
                        print("don't update data \(error)")
                    }
                }
            } else {
                //初期データの追加
                ref.setData([
                    Constants.FStore.titleField: title,
                    Constants.FStore.profField: profileImageURL,
                    Constants.FStore.bodyField: body,
                    Constants.FStore.tagsField: tags,
                    Constants.FStore.urlField: url
                ], merge: true) { (error) in
                    if error != nil {
                        print("don't set data \(error)")
                    }
                }
            }
        }
    }
  

}

//
//  Repository.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/10/22.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation
import Firebase

protocol RepositoryDelegate: class {
    func fetchBookmarkArticles(title: [String],profileImageURL: [String], body: [String], tags: [String], url: [String])
}

final class Repository {
  
    private let dao = Dao()
    private let db = Firestore.firestore()
    var articleData = ArticleData(title: "", profileImageURL: "", body: "", tags: "", likesCount: 0, commentsCount: 0, url: "")
    weak var delegate: RepositoryDelegate?
  
    // MARK: - Update or set articles data
    //DBのお気に入りの記事データを更新する
    func updateBookmarkArticles(title: String, profileImageURL: String, body: String, tags: String, url: String) {
        //DBに直接アクセス
        dao.updateData(title: [title], profileImageURL: [profileImageURL], body: [body], tags: [tags], url: [url])
    }
  
  // MARK: - Access DB to fetch articles data
  //記事データを取得する
    func fetchBookmarkArticles() {
        let ref = db.collection(Constants.FStore.collectionName).document(Constants.FStore.documentName)
        ref.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                guard let titleData = document.data(), let title = Titles(data: titleData) else { return }
                    guard let bodyData = document.data(), let body = Bodys(data: bodyData) else { return }
                    guard let profileImageUrlData = document.data(), let profileImageUrl = ProfileImageUrls(data: profileImageUrlData) else { return }
                    guard let tagsData = document.data(), let tags = Tags(data: tagsData) else { return }
                    guard let urlData = document.data(), let url = Urls(data: urlData) else { return }
                    self.delegate?.fetchBookmarkArticles(title: title.articleTitles,profileImageURL: profileImageUrl.profileImageUrl, body: body.articleBodys, tags: tags.articleTags, url: url.articleUrl)
            } else {
                print("Document does not exist")
            }
        }
    }
  
  // MARK: - Delete articles data
  //DBのお気に入りの記事データを削除する
    func deleteBookmarkArticles(title: String, profileImageURL: String, body: String, tags: String, url: String) {
        //DBに直接アクセス
        dao.deleteData(title: [title], profileImageURL: [profileImageURL], body: [body], tags: [tags], url: [url])
    }
    
}

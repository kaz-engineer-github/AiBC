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
                    self.articleData.titleArray.append(contentsOf: title.articleTitles)
                    guard let bodyData = document.data(), let body = Bodys(data: bodyData) else { return }
                    self.articleData.bodyArray.append(contentsOf: body.articleBodys)
                    guard let profileImageUrlData = document.data(), let profileImageUrl = ProfileImageUrls(data: profileImageUrlData) else { return }
                    self.articleData.profileImageURLArray.append(contentsOf: profileImageUrl.profileImageUrl)
                    guard let tagsData = document.data(), let tags = Tags(data: tagsData) else { return }
                    self.articleData.tagsArray.append(contentsOf: tags.articleTags)
                    guard let urlData = document.data(), let url = Urls(data: urlData) else { return }
                    self.articleData.urlArray.append(contentsOf: url.articleUrl)
                self.delegate?.fetchBookmarkArticles(title: articleData.titleArray,profileImageURL: articleData.profileImageURLArray, body: articleData.bodyArray, tags: self.articleData.tagsArray, url: articleData.urlArray)
            } else {
                print("Document does not exist")
            }
        }
    }
  
//  func getQiitaData() {
//      apiClient.getItems(page: currentPage) { [weak self] result in
//          switch result {
//          case .success(let response):
//              self?.currentItems = response.items
//              self?.delegate?.onSuccess(with: response.items, isReachLastPage: false)
//          case .failure(let error):
//              self?.delegate?.onError(with: error)
//          }
//      }
//  }
    
}

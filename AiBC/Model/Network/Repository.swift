//
//  Repository.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/10/22.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation

//protocol RepositoryDelegate: class {
//    func bookmarkArticles()
//    func onError()
//}

final class Repository {
  
    private let dao = Dao()
//    weak var delegate: RepositoryDelegate?
  
    // MARK: - Update or set articles data
    //DBのお気に入りの記事データを更新する
    func updateBookmarkArticles(title: String, profileImageURL: String, body: String, tags: String, url: String) {
        //DBに直接アクセス
        dao.updateData(title: [title], profileImageURL: [profileImageURL], body: [body], tags: [tags], url: [url])
    }
  
  //StockViewControllerから記事データを取得しろと命令がくる
//    func passFetchBookmarkArticles() {
//      記事データをfetchするために
//        dao.fetchBookmarkArticles()
//    }
  
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

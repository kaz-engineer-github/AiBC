//
//  Repository.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/10/22.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation

protocol RepositoryDelegate: AnyObject {
    func onSuccess()
    func onError()
}

class Repository {
  
    private let dao = Dao()
    weak var delegate: RepositoryDelegate?
    var articleData = ArticleData(title: "", profileImageURL: "", body: "", tags: "", likesCount: 0, commentsCount: 0, url: "")
  
    // MARK: - Pass data to bookmarkArticles
    func passBookmarkArticles(title: String, profileImageURL: String, body: String, tags: String, url: String) {
            self.articleData.titleArray.append(title)
            self.articleData.profileImageURLArray.append(profileImageURL)
            self.articleData.bodyArray.append(body)
            self.articleData.tagsArray.append(tags)
            self.articleData.urlArray.append(url)
            dao.bookmarkArticles(title: articleData.titleArray, profileImageURL: articleData.profileImageURLArray, body: articleData.bodyArray, tags: articleData.tagsArray, url: articleData.urlArray)
//      dao.bookmarkArticles(title: title, profileImageURL: profileImageURL, body: body, tags: tags, url: url)
    }
  
    // MARK: - Pass data to trashBookmarkArticles
//    func passTrashBookmarkArticles(title: String, profileImageURL: String, body: String, tags: String, url: String) {
//          self.articleData.titleArray.append(title)
//          self.articleData.profileImageURLArray.append(profileImageURL)
//          self.articleData.bodyArray.append(body)
//          self.articleData.tagsArray.append(tags)
//          self.articleData.urlArray.append(url)
//          dao.trashBookmarkArticles(title: articleData.titleArray, profileImageURL: articleData.profileImageURLArray, body: articleData.bodyArray, tags: articleData.tagsArray, url: articleData.urlArray)
//    }
}

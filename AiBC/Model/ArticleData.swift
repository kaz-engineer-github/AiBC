//
//  ArticleData.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/21.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation

struct ArticleData {
    var title: String
    var profileImageURL: String?
    var body: String
    var tags: String
    var likesCount: Int
    var commentsCount: Int
    var url: String
  
    var titleArray: [String] = []
    var profileImageURLArray: [String] = []
    var bodyArray: [String] = []
    var tagsArray: [String] = []
    var likesCountArray: [Int] = []
    var commentsCountArray: [Int] = []
    var urlArray: [String] = []
  
    init(title: String, profileImageURL: String?, body: String, tags: String, likesCount: Int, commentsCount: Int, url:String) {
    self.title = title
    self.profileImageURL = profileImageURL
    self.body = body
    self.tags = tags
    self.likesCount = likesCount
    self.commentsCount = commentsCount
    self.url = url
  }
}

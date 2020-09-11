//
//  QiitaItems.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/11.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation

struct QiitaItems: Decodable {
  let user: QiitaUser
  let title: String
  let body: String
  let tags: [QiitaTags]
  let likesCount: Int
  let commentsCount: Int
  let url: String
  
  private enum CodingKeys: String, CodingKey {
    case user
    case title
    case body
    case tags
    case likesCount = "likes_count"
    case commentsCount = "comments_count"
    case url
  }
}

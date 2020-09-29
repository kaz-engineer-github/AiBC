//
//  DBConverter.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/27.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation

//CloudfirestoreからDBをfetchする際に辞書型のデータを変換する
struct Titles {
    let articleTitles: [String]
}

extension Titles {
    init?(data: [String: Any]) {
        guard let articleTitlesData = data["title"] as? [String] else { return nil }
        self.init(articleTitles: articleTitlesData)
    }
}

struct ProfileImageUrls {
    let profileImageUrl: [String]
}

extension ProfileImageUrls {
    init?(data: [String: Any]) {
        guard let profileImageUrlData = data["profileImage"] as? [String] else { return nil }
        self.init(profileImageUrl: profileImageUrlData)
    }
}

struct Bodys {
    let articleBodys: [String]
}

extension Bodys {
    init?(data: [String: Any]) {
        guard let articleBodysData = data["body"] as? [String] else { return nil }
        self.init(articleBodys: articleBodysData)
    }
}

struct Tags {
    let articleTags: [String]
}

extension Tags {
    init?(data: [String: Any]) {
        guard let articleTagsData = data["tags"] as? [String] else { return nil }
        self.init(articleTags: articleTagsData)
    }
}

struct LikesCount {
    let likesCount: [String]
}

extension LikesCount {
    init?(data: [String: Any]) {
        guard let likesCountData = data["likesCount"] as? [String] else { return nil }
        self.init(likesCount: likesCountData)
    }
}

struct CommentsCount {
    let commentsCount: [String]
}

extension CommentsCount {
    init?(data: [String: Any]) {
        guard let commentsCountData = data["commentsCount"] as? [String] else { return nil }
        self.init(commentsCount: commentsCountData)
    }
}

struct Urls {
    let articleUrl: [String]
}

extension Urls {
    init?(data: [String: Any]) {
        guard let articleUrlData = data["url"] as? [String] else { return nil }
        self.init(articleUrl: articleUrlData)
    }
}

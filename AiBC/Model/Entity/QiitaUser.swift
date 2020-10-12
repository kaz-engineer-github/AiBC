//
//  QiitaUser.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/11.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation

struct QiitaUser: Decodable {
    let profileImageURL: String
  
    private enum CodingKeys: String, CodingKey {
        case profileImageURL = "profile_image_url"
    }
}

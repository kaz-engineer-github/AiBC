//
//  Constants.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/11/04.
//  Copyright © 2020 吉本和史. All rights reserved.
//

struct Constants {
    
    struct Segue {
        static let titleSegue = "titleViewController"
        static let webViewSegue = "WebViewController"
        static let tabBarSegue = "tabBarController"
    }
  
    struct Cell {
        static let itemsViewControllerCell = "ItemsViewControllerCell"
        static let itemsSearchViewControllerCell = "ItemsSearchViewControllerCell"
        static let itemsViewControllerIndicatorCell = "ItemsViewControllerIndicatorCell"
        static let itemsStockViewControllerCell = "ItemsStockViewControllerCell"
    }
    
    struct FStore {
        static let collectionName = "users"
        static let documentName = "bookmark_articles"
        static let titleField = "title"
        static let profField = "profileImage"
        static let bodyField = "body"
        static let tagsField = "tags"
        static let urlField = "url"
    }
}

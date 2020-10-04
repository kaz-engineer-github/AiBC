//
//  ItemsSearchModel.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/10/04.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation
import Alamofire

protocol ItemsSearchModelDelegate: AnyObject {
    func onSearchSuccess(with dataSource: [QiitaItems])
    func onSearchError(with error: Error)
}

final class ItemsSearchModel {
  
    weak var delegate: ItemsSearchModelDelegate?
    private let apiClient: QiitaAPIClientProtocol
//    private var currentPage: Int = 1
    private var currentItems: [QiitaItems] = []
    private var isLoading: Bool = false
    private var isReachLastPage: Bool = false
    var searchBarText: String = ""
    private let baseURL: String = "https://qiita.com/api/v2"

    init(apiClient: QiitaAPIClientProtocol = QiitaAPIClient.shared) {
        self.apiClient = apiClient
    }
  
    func getSearchData(text: String) {
        searchBarText = text
        apiClient.getSearchItems(text: searchBarText) { [weak self] result in
            switch result {
            case .success(let response):
                self?.currentItems = response.items
              print("検索できてる\(self?.currentItems)")
                self?.delegate?.onSearchSuccess(with: response.items)
            case .failure(let error):
                self?.delegate?.onSearchError(with: error)
            }
        }
    }
}

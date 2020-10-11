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
    func onSearchSuccess(with dataSource: [QiitaItems], isReachLastPage: Bool)
    func onSearchError(with error: Error)
}

final class ItemsSearchModel {
  
    weak var delegate: ItemsSearchModelDelegate?
    private let apiClient: QiitaAPIClientProtocol
    private var currentPage: Int = 1
    private var currentItems: [QiitaItems] = []
    private var isLoading: Bool = false
    private var isReachLastPage: Bool = false
    var searchBarText: String = ""

    init(apiClient: QiitaAPIClientProtocol = QiitaAPIClient.shared) {
        self.apiClient = apiClient
    }
  
    func getSearchData(text: String) {
        searchBarText = text
        apiClient.getSearchItems(page: currentPage, text: searchBarText) { [weak self] result in
            switch result {
            case .success(let response):
                self?.currentItems = response.items
                self?.delegate?.onSearchSuccess(with: response.items, isReachLastPage: false)
            case .failure(let error):
                self?.delegate?.onSearchError(with: error)
            }
        }
    }
    
    func onSearchReachBottom() {
        guard !isLoading && !isReachLastPage else { return }
      
        let nextPage = currentPage + 1
        isLoading = true
      
        apiClient.getItems(page: nextPage) { [weak self] result in
            switch result {
            case .success(let response):
                self?.currentItems += response.items
                self?.currentPage = nextPage
                self?.isLoading = false
                self?.isReachLastPage = nextPage >= response.totalCount
                self?.delegate?.onSearchSuccess(with: self?.currentItems ?? [], isReachLastPage: nextPage >= response.totalCount)
            case .failure(let error):
                self?.delegate?.onSearchError(with: error)
            }
        }
    }
}

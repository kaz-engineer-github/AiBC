//
//  ItemsModel.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/11.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation
import Alamofire

protocol ItemsModelDelegate: AnyObject {
    func onSuccess(with dataSource: [QiitaItems], isReachLastPage: Bool)
    func onError(with error: Error)
}

final class ItemsModel {
  
    weak var delegate: ItemsModelDelegate?
    private let apiClient: QiitaAPIClientProtocol
    private var currentPage: Int = 1
    private var currentItems: [QiitaItems] = []
    private var isLoading: Bool = false
    private var isReachLastPage: Bool = false

    init(apiClient: QiitaAPIClientProtocol = QiitaAPIClient.shared) {
        self.apiClient = apiClient
    }
  
    func getQiitaData() {
        apiClient.getItems(page: currentPage) { [weak self] result in
            switch result {
            case .success(let response):
                self?.currentItems = response.items
                self?.delegate?.onSuccess(with: response.items, isReachLastPage: false)
            case .failure(let error):
                self?.delegate?.onError(with: error)
            }
        }
    }
  
    func onReachBottom() {
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
                self?.delegate?.onSuccess(with: self?.currentItems ?? [], isReachLastPage: nextPage >= response.totalCount)
            case .failure(let error):
                self?.delegate?.onError(with: error)
            }
        }
    }
}

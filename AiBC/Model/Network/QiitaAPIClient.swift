//
//  QiitaAPIClient.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/10/02.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import Foundation
import Alamofire

protocol QiitaAPIClientProtocol {
    func getItems(page: Int, completion: @escaping (Result<QiitaItemsResponse, Error>) -> Void)
    func getSearchItems(page: Int, text: String, completion: @escaping (Result<QiitaItemsResponse, Error>) -> Void)
}

final class QiitaAPIClient: QiitaAPIClientProtocol {
  
    static let shared: QiitaAPIClient = .init()
    private let baseURL: String = "https://qiita.com/api/v2"
    private init() {}
  
    func getItems(page: Int, completion: @escaping (Result<QiitaItemsResponse, Error>) -> Void) {
        let url = baseURL + "/items?page=\(page)"
        let headers = HTTPHeaders([HTTPHeader(name: "Authorization", value: "Bearer " + qiitaAccessToken)])
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data,
                        let totalCountString = response.response?.headers["total-count"],
                        let totalCount = Int(totalCountString) else { return }
                    
                    let items = try JSONDecoder().decode([QiitaItems].self, from: data)
                    completion(.success(QiitaItemsResponse(items: items, totalCount: totalCount)))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
  
//    func getSearchItems(page: Int, text: String, completion: @escaping (Result<QiitaItemsResponse, Error>) -> Void) {
//        let url = baseURL + "?/items?page=\(page)&query=tag%3A" + text
    func getSearchItems(page: Int, text: String, completion: @escaping (Result<QiitaItemsResponse, Error>) -> Void) {
        let url = baseURL + "/items?page=\(page)&query=tag%3A" + text
        let headers = HTTPHeaders([HTTPHeader(name: "Authorization", value: "Bearer " + qiitaAccessToken)])
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data,
                        let totalCountString = response.response?.headers["total-count"],
                        let totalCount = Int(totalCountString) else { return }
                    
                    let items = try JSONDecoder().decode([QiitaItems].self, from: data)
                    completion(.success(QiitaItemsResponse(items: items, totalCount: totalCount)))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

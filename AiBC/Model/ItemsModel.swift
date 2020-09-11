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
    func getQiitaData(qiitaItems: [QiitaItems])
}

final class ItemsModel {
  
    weak var delegate: ItemsModelDelegate?

    func getQiitaData() {
        let urlString = "https://qiita.com/api/v2/items?page=1&per_page=20"
        let url = URL(string: urlString)
        AF.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
                case .success:
                    do {
                        guard let data = response.data else { return }
                        let qiitaItems = try JSONDecoder().decode([QiitaItems].self, from: data)
                        print(qiitaItems)
                        self.delegate?.getQiitaData(qiitaItems: qiitaItems)
                    } catch {
                        // デコードのエラー
                        print(error)
                    }
                //レスポンスのエラー
                case .failure:
                  print("failure")
            }
        }
    }
}

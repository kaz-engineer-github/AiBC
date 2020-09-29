//
//  ItemsStockViewController.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/22.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit

class ItemsStockViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var dataSource: [String] = []
    var fetchArticleData = ArticleData(title: "", profileImageURL: "", body: "", tags: "", likesCount: 0, commentsCount: 0, url: "")
    private let itemsStockModel = BookmarkModel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        itemsStockModel.delegate = self
        itemsStockModel.fetchBookmarkArticles()
    }
}

extension ItemsStockViewController: BookmarkModelDelegate {
    func fetchBookmarkArticles(document: String) {
        dataSource.append(document)
        tableView.reloadData()
    }
}

extension ItemsStockViewController {
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemsStockViewControllerCell.nib, forCellReuseIdentifier: ItemsStockViewControllerCell.reuseIdentifier)
    }
}

extension ItemsStockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsStockViewControllerCell.reuseIdentifier, for: indexPath) as! ItemsStockViewControllerCell
            return cell
    }
}

extension ItemsStockViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = dataSource[indexPath.row]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebViewController" {
            let webVC: WebViewController = (segue.destination as? WebViewController)!
            guard let imageURL =  fetchArticleData.profileImageURL else { return }
            webVC.articleData.title = fetchArticleData.title
            webVC.articleData.profileImageURL = imageURL
            webVC.articleData.url = fetchArticleData.url
        }
    }
}

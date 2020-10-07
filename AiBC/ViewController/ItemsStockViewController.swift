//
//  ItemsStockViewController.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/22.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit
import Kingfisher

class ItemsStockViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var fetchArticleData = ArticleData(title: "", profileImageURL: "", body: "", tags: "", likesCount: 0, commentsCount: 0, url: "")
    private let itemsStockModel = BookmarkModel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        itemsStockModel.delegate = self
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemsStockModel.fetchBookmarkArticles()
    }
}

extension ItemsStockViewController: BookmarkModelDelegate {
    func fetchBookmarkArticles(title: [String], profileImageURL: [String], body: [String], tags: [String], url: [String]) {
        fetchArticleData.titleArray.append(contentsOf: title)
        fetchArticleData.profileImageURLArray.append(contentsOf: profileImageURL)
        fetchArticleData.bodyArray.append(contentsOf: body)
        fetchArticleData.tagsArray.append(contentsOf: tags)
        fetchArticleData.urlArray.append(contentsOf: url)
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
        return fetchArticleData.titleArray.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemsStockViewControllerCell.reuseIdentifier, for: indexPath) as! ItemsStockViewControllerCell
        cell.titleLabel.text = fetchArticleData.titleArray[indexPath.row]
        cell.bodyLabel.text = fetchArticleData.bodyArray[indexPath.row]
        cell.tagsLabel.text = fetchArticleData.tagsArray[indexPath.row]
        let url = URL(string: fetchArticleData.profileImageURLArray[indexPath.row])
        cell.profileIconImage.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.3))])
        return cell
    }
}

extension ItemsStockViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fetchArticleData.url = fetchArticleData.urlArray[indexPath.row]
        self.performSegue(withIdentifier: "WebViewController", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebViewController" {
            let webVC: WebViewController = (segue.destination as? WebViewController)!
            webVC.articleData.url = fetchArticleData.url
        }
    }
}

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
    private var dataSource: [ItemsViewControllerCellType] = []
    var fetchArticleData = ArticleData(title: "", profileImageURL: "", body: "", tags: "", bookmarkCount: 0, commentsCount: 0, url: "")
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
}

extension ItemsStockViewController {
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemsViewControllerCell.nib, forCellReuseIdentifier: ItemsViewControllerCell.reuseIdentifier)
    }
}

extension ItemsStockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = dataSource[indexPath.row]
      
        switch cellType {
        case .item(let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsViewControllerCell.reuseIdentifier, for: indexPath) as! ItemsViewControllerCell
          
            cell.configureCell(
                profileImageURL: item.user.profileImageURL,
                title: item.title,
                body: item.body,
                tags: item.tags.reduce("") { $0 + "#\($1.name) " },
                bookmarkCount: item.likesCount,
                commentsCount: item.commentsCount,
                url: item.url)
            return cell
        default:
          break
        }
      return UITableViewCell()
    }
}

extension ItemsStockViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = dataSource[indexPath.row]
        
            switch cellType {
            case .item(let item):
                fetchArticleData.title = item.title
                fetchArticleData.profileImageURL = item.user.profileImageURL
                fetchArticleData.url = item.url
                self.performSegue(withIdentifier: "WebViewController", sender: nil)
            default:
                break
            }
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

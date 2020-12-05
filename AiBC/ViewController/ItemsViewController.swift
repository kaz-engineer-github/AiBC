//
//  ItemsViewController.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/10.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var dataSource: [ItemsViewControllerCellType] = []
    private let itemsModel = ItemsModel()
    var articleData = ArticleData(title: "", profileImageURL: "", body: "", tags: "", likesCount: 0, commentsCount: 0, url: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        itemsModel.delegate = self
        itemsModel.getQiitaData()
    }
}

extension ItemsViewController: ItemsModelDelegate {
    func onSuccess(with items: [QiitaItems], isReachLastPage: Bool) {
        dataSource = items.map { .item(with: $0) } + (isReachLastPage ? [] : [.indicator])
        tableView.reloadData()
    }
  
    func onError(with error: Error) {
        let ac = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
}

extension ItemsViewController {
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemsViewControllerCell.nib, forCellReuseIdentifier: ItemsViewControllerCell.reuseIdentifier)
        tableView.register(ItemsViewControllerIndicatorCell.nib, forCellReuseIdentifier: ItemsViewControllerIndicatorCell.reuseIdentifier)
    }
}

extension ItemsViewController: UITableViewDataSource {
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
        case .indicator:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemsViewControllerIndicatorCell.reuseIdentifier, for: indexPath) as! ItemsViewControllerIndicatorCell
            cell.configureCell()
            return cell
        }
    }
}

extension ItemsViewController: UITableViewDelegate {
  
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y + tableView.frame.size.height > tableView.contentSize.height - 24 && tableView.isDragging {
            itemsModel.onReachBottom()
        }
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = dataSource[indexPath.row]
        
        switch cellType {
        case .item(let item):
            articleData.title = item.title
            articleData.profileImageURL = item.user.profileImageURL
            articleData.body = item.body
            articleData.tags = item.tags.reduce("") { $0 + "#\($1.name) " }
            articleData.url = item.url
          
            self.performSegue(withIdentifier: Constants.Segue.webViewSegue, sender: nil)
        default:
            break
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.webViewSegue {
            let webVC: WebViewController = (segue.destination as? WebViewController)!
            guard let imageURL =  articleData.profileImageURL else { return }
            webVC.articleData.title = articleData.title
            webVC.articleData.profileImageURL = imageURL
            webVC.articleData.body = articleData.body
            webVC.articleData.tags = articleData.tags
            webVC.articleData.url = articleData.url
        }
    }
}


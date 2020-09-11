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
    var articleUrl: URL?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        itemsModel.delegate = self
        itemsModel.getQiitaData()
    }
}

extension ItemsViewController: ItemsModelDelegate {
    func getQiitaData(qiitaItems: [QiitaItems]) {
        let dataSource = qiitaItems.map { ItemsViewControllerCellType.item(with: $0) }
        self.dataSource = dataSource
        tableView.reloadData()
    }
}

extension ItemsViewController {
    private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(ItemsViewControllerCell.nib, forCellReuseIdentifier: ItemsViewControllerCell.reuseIdentifier)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = dataSource[indexPath.row]
        
            switch cellType {
            case .item(let item):
                guard let url = URL(string: item.url) else { return }
                articleUrl = url
                self.performSegue(withIdentifier: "WebViewController", sender: nil)
            default:
                break
            }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebViewController" {
            let webVC: WebViewController = (segue.destination as? WebViewController)!
            webVC.url = articleUrl
        }
    }
}


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
    private var dataSource: [String] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemsViewControllerCell.reuseIdentifier, for: indexPath) as! ItemsViewControllerCell
        return cell
    }
}

extension ItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

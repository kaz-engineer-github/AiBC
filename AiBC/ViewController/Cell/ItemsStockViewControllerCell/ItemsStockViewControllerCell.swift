//
//  ItemsStockViewControllerCell.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/28.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit

class ItemsStockViewControllerCell: UITableViewCell {
  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileIconImage: UIImageView!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    static let reuseIdentifier: String = Constants.Cell.itemsStockViewControllerCell
    static let nib: UINib = UINib(nibName: Constants.Cell.itemsStockViewControllerCell, bundle: nil)
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

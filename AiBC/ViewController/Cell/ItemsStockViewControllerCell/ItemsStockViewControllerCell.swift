//
//  ItemsStockViewControllerCell.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/28.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit

class ItemsStockViewControllerCell: UITableViewCell {

    static let reuseIdentifier: String = "ItemsStockViewControllerCell"
    static let nib: UINib = UINib(nibName: "ItemsStockViewControllerCell", bundle: nil)
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

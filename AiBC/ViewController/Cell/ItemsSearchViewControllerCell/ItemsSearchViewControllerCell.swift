//
//  ItemsSearchViewControllerCell.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/10/05.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit

class ItemsSearchViewControllerCell: UITableViewCell {
  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileIconImage: UIImageView!
    static let reuseIdentifier: String = "ItemsViewControllerCell"
    static let nib: UINib = UINib(nibName: "ItemsViewControllerCell", bundle: nil)
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

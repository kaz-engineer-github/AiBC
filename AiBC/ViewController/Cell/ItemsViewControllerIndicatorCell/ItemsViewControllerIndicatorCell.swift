//
//  ItemsViewControllerIndicatorCell.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/11.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit

class ItemsViewControllerIndicatorCell: UITableViewCell {

    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    static let reuseIdentifier: String = "ItemsViewControllerIndicatorCell"
    static let nib: UINib = UINib(nibName: "ItemsViewControllerIndicatorCell", bundle: nil)
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell() {
        activityIndicatorView.startAnimating()
    }
}

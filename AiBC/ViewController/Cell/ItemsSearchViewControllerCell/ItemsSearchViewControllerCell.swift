//
//  ItemsSearchViewControllerCell.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/10/05.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit
import Kingfisher

class ItemsSearchViewControllerCell: UITableViewCell {
  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileIconImage: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    static let reuseIdentifier: String = Constants.Cell.itemsSearchViewControllerCell
    static let nib: UINib = UINib(nibName: Constants.Cell.itemsSearchViewControllerCell, bundle: nil)
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(profileImageURL: String?, title: String, body: String, tags: String, bookmarkCount: Int, commentsCount: Int, url:String) {
        titleLabel.text = title
        tagsLabel.text = tags
        
        if let url = URL(string: profileImageURL ?? "") {
            profileIconImage.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.3))])
        }
    }
}

//
//  ItemsViewControllerCell.swift
//  AiBC
//
//  Created by 吉本和史 on 2020/09/10.
//  Copyright © 2020 吉本和史. All rights reserved.
//

import UIKit
import Kingfisher

class ItemsViewControllerCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileIconImage: UIImageView!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var bookmarkCountLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    static let reuseIdentifier: String = "ItemsViewControllerCell"
    static let nib: UINib = UINib(nibName: "ItemsViewControllerCell", bundle: nil)
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(profileImageURL: String?, title: String, body: String, tags: String, bookmarkCount: Int, commentsCount: Int, url:String) {
        titleLabel.text = title
        bodyLabel.text = body
        tagsLabel.text = tags
        bookmarkCountLabel.text = "\(bookmarkCount)"
        commentsCountLabel.text = "\(commentsCount)"
        
        if let url = URL(string: profileImageURL ?? "") {
            profileIconImage.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.3))])
        }
    }
}

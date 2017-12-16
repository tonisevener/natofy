//
//  TranslationTableViewCell.swift
//  Natofy
//
//  Created by Toni Sevener on 12/15/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import UIKit

class TranslationTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

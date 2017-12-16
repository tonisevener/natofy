//
//  AlphabetCollectionViewCell.swift
//  Natofy
//
//  Created by Toni Sevener on 12/15/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import UIKit

class AlphabetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var letterLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    func configure(letter: String, name:String) {
        letterLabel.text = letter
        nameLabel.text = name
    }
}

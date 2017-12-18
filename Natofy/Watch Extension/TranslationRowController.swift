//
//  TranslationRowController.swift
//  Watch Extension
//
//  Created by Toni Sevener on 12/17/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import WatchKit

class TranslationRowController: NSObject {
    @IBOutlet var translationLabel: WKInterfaceLabel!
    
    var translation: String? {
        didSet {
            guard let translation = translation else { return }
            translationLabel.setText(translation)
        }
    }
}

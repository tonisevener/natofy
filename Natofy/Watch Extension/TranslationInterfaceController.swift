//
//  TranslationInterfaceController.swift
//  Watch Extension
//
//  Created by Toni Sevener on 12/16/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import WatchKit
import Foundation


class TranslationInterfaceController: WKInterfaceController {

    @IBOutlet var translationTable: WKInterfaceTable!
    private var dataSource: [String] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let context = context as? [String] else {
            return
        }
        
        dataSource = context
        
        translationTable.setNumberOfRows(dataSource.count, withRowType: "TranslationRow")
        
        for index in 0..<translationTable.numberOfRows {
            guard let controller = translationTable.rowController(at: index) as? TranslationRowController else { continue }
            
            controller.translation = dataSource[index]
        }
    }
    
}

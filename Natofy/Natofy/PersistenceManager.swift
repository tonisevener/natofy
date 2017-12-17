//
//  PersistenceManager.swift
//  Natofy
//
//  Created by Toni Sevener on 12/16/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import Foundation

class PersistenceManager {
    static func saveLastTranslation(translation: [String]) {
        NSKeyedArchiver.archiveRootObject(translation, toFile: "lastTranslation")
    }
    
    static func getLastTranslation() -> [String]? {
        guard let translation = NSKeyedUnarchiver.unarchiveObject(withFile: "lastTranslation") as? [String] else {
            return nil
        }
        
        return translation
    }
}

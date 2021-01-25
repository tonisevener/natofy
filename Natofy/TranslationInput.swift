//
//  TranslationInput.swift
//  Natofy
//
//  Created by Toni Sevener on 1/24/21.
//

import Foundation

class TranslationInput: ObservableObject {
    @Published var text: String
    
    init(inputText: String) {
        self.text = inputText
    }
}

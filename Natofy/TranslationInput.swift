//
//  TranslationInput.swift
//  Natofy
//
//  Created by Toni Sevener on 1/24/21.
//

import Foundation

class TranslationInput: ObservableObject {
    static let placeholderString = "Enter text to translate."
    @Published var text: String = placeholderString
    
    init(inputText: String = placeholderString) {
        self.text = inputText
    }
}

//
//  TranslationList.swift
//  Natofy
//
//  Created by Toni Sevener on 1/24/21.
//

import SwiftUI

struct TranslationList: View {
    
    @ObservedObject var translationInput: TranslationInput
    
    var translationResult: [Translation] {
        NatoConverter.convert(text: translationInput.text)
    }
    
    var body: some View {
        List {
            Section(header: Text(translationInput.text)) {
                ForEach(translationResult) { translation in
                    Text(translation.long)
                }
            }
        }
    }
}

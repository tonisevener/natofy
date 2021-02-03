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
    
    private let maxHeaderTextLength = 200
    
    private var headerText: String {
        return translationInput.text.count > maxHeaderTextLength ? translationInput.text.prefix(maxHeaderTextLength) + "..." : translationInput.text
    }
    
    var body: some View {
        List {
            Section(header: Text(headerText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .textCase(.none)
            ) {
                ForEach(translationResult) { translation in
                    Text(translation.long)
                        .font(.title2)
                }
            }
        }
        .accessibilityIdentifier(AccessibilityIdentifiers.translateOutputList.rawValue)
    }
}

struct TranslationList_Previews: PreviewProvider {
    static var previews: some View {
        TranslationList(translationInput: TranslationInput(inputText: "testing"))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
            .previewDisplayName("iPhone 12 mini")
            .environment(\.colorScheme, .dark)
    }
}

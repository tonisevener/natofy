//
//  TranslateTextEditor.swift
//  Natofy
//
//  Created by Toni Sevener on 1/24/21.
//

import SwiftUI

struct TranslateTextEditor: View {
    @Binding var textToTranslate: String
    let textEditorWidth: CGFloat
    var body: some View {
        TextEditor(text: $textToTranslate)
            .frame(minWidth: textEditorWidth, idealWidth: textEditorWidth, maxWidth: textEditorWidth, minHeight: 50.0, idealHeight: 200.0, maxHeight: 200.0, alignment: .center)
            .background(Color.secondarySystemBackground)
            .foregroundColor(self.textToTranslate == TranslationInput.placeholderString ? .secondary : .primary)
            .cornerRadius(10.0)
            .onTapGesture {
                if self.textToTranslate == TranslationInput.placeholderString {
                  self.textToTranslate = ""
                }
            }
            .accessibilityIdentifier(AccessibilityIdentifiers.translateInputTextEditor.rawValue)
    }
}

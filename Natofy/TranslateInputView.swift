//
//  TranslateInputView.swift
//  Natofy
//
//  Created by Toni Sevener on 1/24/21.
//

import SwiftUI
import MobileCoreServices

struct TranslateInputView: View {
    @State var pushView = false
    @ObservedObject var clipboard: Clipboard
    @StateObject var translationInput: TranslationInput = TranslationInput(inputText: "testing")
    
    init(clipboard: Clipboard) {
        UITextView.appearance().backgroundColor = .clear
        self.clipboard = clipboard
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    NavigationLink(destination: TranslateOutputView(translationInput: translationInput), isActive: $pushView) {
                        Button("Use Clipboard", action: {
                            translationInput.text = clipboard.value
                            pushView = true
                        })
                        .font(.headline)
                        .disabled(clipboard.value.count == 0)
                    }
                    
                    let textEditorWidth = geometry.size.width * 0.66
                        
                    TranslateTextEditor(textToTranslate: $translationInput.text, textEditorWidth: textEditorWidth)
                    NavigationLink(destination: TranslateOutputView(translationInput: translationInput), isActive: $pushView) {
                        Button("Go!", action: {
                            pushView = true
                        })
                            .font(.headline)
                    }
                    Spacer()
                }
                Spacer()
            }
        })
        .navigationBarTitle("Translate")
    }
}

struct TranslateView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TranslateInputView(clipboard: Clipboard())
                .navigationBarTitle("Translate")
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
        .previewDisplayName("iPhone 12 mini")
        .environment(\.colorScheme, .light)
        
        
        NavigationView {
            TranslateInputView(clipboard: Clipboard())
                .navigationBarTitle("Translate")
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
        .previewDisplayName("iPhone 12 mini")
        .environment(\.colorScheme, .dark)
    }
}

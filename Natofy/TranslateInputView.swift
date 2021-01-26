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
    @StateObject var translationInput: TranslationInput = TranslationInput()
    
    private var clipboardIsEmpty: Bool {
        return clipboard.value.count == 0
    }
    
    private var textEditorIsEmpty: Bool {
        return translationInput.text.count == 0
    }
    
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
                    NavigationLink(destination: TranslateOutputView(translationInput: translationInput)) {
                        Text("Use Clipboard")
                            .font(.headline)
                        }
                        .disabled(clipboardIsEmpty)
                        .simultaneousGesture(TapGesture().onEnded {
                            if !clipboardIsEmpty {
                                translationInput.text = clipboard.value
                                hideKeyboard()
                            }
                        })
                    
                    let textEditorWidth = geometry.size.width * 0.66
                        
                    TranslateTextEditor(textToTranslate: $translationInput.text, textEditorWidth: textEditorWidth)
                    NavigationLink(destination: TranslateOutputView(translationInput: translationInput)) {
                            Text("Translate!")
                                .font(.headline)
                        }
                    .disabled(textEditorIsEmpty)
                    .simultaneousGesture(TapGesture().onEnded {
                        if !textEditorIsEmpty {
                            hideKeyboard()
                        }
                    })
                    
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

private extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

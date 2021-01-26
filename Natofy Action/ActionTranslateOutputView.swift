//
//  ActionTranslateOutputView.swift
//  Natofy Action
//
//  Created by Toni Sevener on 1/24/21.
//

import SwiftUI

struct ActionTranslateOutputView: View {
    @ObservedObject var translationInput: TranslationInput
    
    var body: some View {
        TranslationList(translationInput: translationInput)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ActionTranslateOutputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ActionTranslateOutputView(translationInput: TranslationInput())
        }
    }
}

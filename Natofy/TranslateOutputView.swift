//
//  TranslateOutputView.swift
//  Natofy
//
//  Created by Toni Sevener on 1/24/21.
//

import SwiftUI

struct TranslateOutputView: View {
    @ObservedObject var translationInput: TranslationInput
    @StateObject var watchSender = WatchSender()
    
    var body: some View {
        TranslationList(translationInput: translationInput)
        .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Send to Watch", action: {
                self.watchSender.session.sendMessage(["message" : self.translationInput.text], replyHandler: nil) { (error) in
                        print(error.localizedDescription)
                    }
                })
                .disabled(watchSender.isNotReachable)
            )
    }
}

struct TranslateOutputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TranslateOutputView(translationInput: TranslationInput())
        }
    }
}

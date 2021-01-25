//
//  ContentView.swift
//  Natofy Watch Extension
//
//  Created by Toni Sevener on 1/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var watchReceiver: WatchReceiver
    
    var body: some View {
        let translationResult = NatoConverter.convert(text: watchReceiver.messageText)
        if translationResult.count > 0 {
            List {
                ForEach(translationResult) { translation in
                    Text(translation.long)
                }
            }
        } else {
            Text("To see the latest translation, open iPhone app and tap the Send to Watch button")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(watchReceiver: WatchReceiver(messageText: "test"))
    }
}

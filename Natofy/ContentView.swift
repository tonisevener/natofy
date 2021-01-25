//
//  ContentView.swift
//  Natofy
//
//  Created by Toni Sevener on 1/24/21.
//

import SwiftUI

class Clipboard: ObservableObject {
    @Published var value: String = ""
    
    init() {
        NotificationCenter.default.addObserver(forName: UIPasteboard.changedNotification, object: nil, queue: nil) { [unowned self] (notification) in
            value = UIPasteboard.general.string ?? ""
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [unowned self] (notification) in
            value = UIPasteboard.general.string ?? ""
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var clipboard: Clipboard
    
    var body: some View {
        TabView {
            NavigationView {
                TranslateInputView(clipboard: clipboard)
                Text("Open panel on the left to enter text for translation.")
            }
            .tabItem {
                Image(systemName: "chevron.right.2")
                Text("Translate")
            }
            NavigationView {
                AlphabetView()
            }
            .tabItem {
                Image(systemName: "square.grid.2x2")
                Text("Alphabet")
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(clipboard: Clipboard())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
            .previewDisplayName("iPhone 12 mini")
            .environment(\.colorScheme, .light)
        
        ContentView(clipboard: Clipboard())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
            .previewDisplayName("iPhone 12 mini")
            .environment(\.colorScheme, .dark)
    }
}

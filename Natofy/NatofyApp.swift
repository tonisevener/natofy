//
//  NatofyApp.swift
//  Natofy
//
//  Created by Toni Sevener on 1/24/21.
//

import SwiftUI

@main
struct NatofyApp: App {
    
    @StateObject var clipboard = Clipboard()
    
    var body: some Scene {
        WindowGroup {
            ContentView(clipboard: clipboard)
        }
    }
}

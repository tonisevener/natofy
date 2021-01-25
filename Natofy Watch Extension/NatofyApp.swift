//
//  NatofyApp.swift
//  Natofy Watch Extension
//
//  Created by Toni Sevener on 1/24/21.
//

import SwiftUI

@main
struct NatofyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(watchReceiver: WatchReceiver())
            }
        }
    }
}

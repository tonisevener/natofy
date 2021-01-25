//
//  WatchReceiver.swift
//  Natofy Watch Extension
//
//  Created by Toni Sevener on 1/24/21.
//

import Foundation
import WatchConnectivity

class WatchReceiver : NSObject,  WCSessionDelegate, ObservableObject {
    var session: WCSession
    @Published var messageText: String
    
    init(session: WCSession = .default, messageText: String = "") {
        self.messageText = messageText
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.messageText = message["message"] as? String ?? "Unknown"
        }
    }
}

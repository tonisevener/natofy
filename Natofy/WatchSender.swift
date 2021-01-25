//
//  WatchSender.swift
//  Natofy
//
//  Created by Toni Sevener on 1/24/21.
//

import Foundation
import WatchConnectivity

class WatchSender : NSObject,  WCSessionDelegate, ObservableObject {
    
    @Published var isNotReachable = true
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
        isNotReachable = !self.session.isReachable
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isNotReachable = !session.isReachable
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
}

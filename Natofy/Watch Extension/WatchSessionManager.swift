//
//  WatchSessionManager.swift
//  WatchConnectivityDemo
//
//  Created by Natasha Murashev on 9/3/15.
//  Copyright © 2015 NatashaTheRobot. All rights reserved.
//  Updated by Simon Krüger on 2/27/17.
//  Changes © 2017 Kayoslab.
//

import WatchKit
import WatchConnectivity

class WatchSessionManager: NSObject, WCSessionDelegate {
    
    static let sharedManager = WatchSessionManager()
    fileprivate let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil
    fileprivate var validSession: WCSession? {
        // paired - the user has to have their device paired to the watch
        // watchAppInstalled - the user must have your watch app installed
        
        // Note: if the device is paired, but your watch app is not installed
        // consider prompting the user to install it for a better experience
        if let session = session {
            return session
        }
        return nil
    }
    
    private override init() {
        super.init()
    }
    
    func startSession() {
        session?.delegate = self
        session?.activate()
    }
    
    /**
     * Called when the session has completed activation.
     * If session state is WCSessionActivationStateNotActivated there will be an error with more details.
     */
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
}

// MARK: Interactive Messaging
extension WatchSessionManager {
    
    // Live messaging! App has to be reachable
    private var validReachableSession: WCSession? {
        if let session = validSession, session.isReachable {
            return session
        }
        return nil
    }
    
    // Sender
    func sendMessage(message: [String : Any], replyHandler: (([String : Any]) -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        validReachableSession?.sendMessage(message, replyHandler: replyHandler, errorHandler: errorHandler)
    }
    
    func sendMessageData(data: Data, replyHandler: ((Data) -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        validReachableSession?.sendMessageData(data, replyHandler: replyHandler, errorHandler: errorHandler)
    }
    
    // Receiver
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async() {
            // make sure to put on the main queue to update UI!
            
            if let translations = message[kLastTranslationKey] {
                WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "Translation", context: translations as AnyObject)])
            }
        }
    }
}

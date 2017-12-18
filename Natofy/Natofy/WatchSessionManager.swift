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

let kNotificationWatchIsActive = "kNotificationWatchIsActive"
let kNotificationWatchIsInActive = "kNotificationWatchIsInActive"

class WatchSessionManager: NSObject, WCSessionDelegate {
    
    static let sharedManager = WatchSessionManager()
    fileprivate let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil
    fileprivate var validSession: WCSession? {
        // paired - the user has to have their device paired to the watch
        // watchAppInstalled - the user must have your watch app installed
        
        // Note: if the device is paired, but your watch app is not installed
        // consider prompting the user to install it for a better experience
        if let session = session, session.isPaired && session.isWatchAppInstalled {
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
    
    /**
     * Called when the session can no longer be used to modify or add any new transfers and,
     * all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur.
     * This will happen when the selected watch is being changed.
     */
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    /**
     * Called when all delegate callbacks for the previously selected watch has occurred.
     * The session can be re-activated for the now selected watch using activateSession.
     */
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func shouldShowMessageOption() -> Bool {
        return validSession != nil
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
    
    func shouldShowMessageOptionEnabled() -> Bool {
        return validSession != nil && validReachableSession != nil
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
            
            if let isActive = message[kWatchIsActiveNotificationName] as? Bool {
                if isActive == true {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationWatchIsActive), object: nil)
                } else {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationWatchIsInActive), object: nil)
                }
            }
        }
    }
}

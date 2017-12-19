//
//  TranslateOutputContainerViewController.swift
//  Natofy
//
//  Created by Toni Sevener on 12/18/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import UIKit

class TranslateOutputContainerViewController: UIViewController {
    
    @IBOutlet var sendToWatchButton: UIBarButtonItem!
    
    private var notifications: [AnyObject] = []
    
    private var translateOutputVC: TranslateOutputViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNotifications()
        
        configureWatchButton(shouldShow: WatchSessionManager.sharedManager.shouldShowMessageOption(), shouldEnable: WatchSessionManager.sharedManager.shouldShowMessageOptionEnabled())
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        for notification in notifications {
            NotificationCenter.default.removeObserver(notification)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "TranslationOutputEmbedSegue",
            let translateOutputVC = segue.destination as? TranslateOutputViewController else {
                return
        }
        
        self.translateOutputVC = translateOutputVC
    }
    
    func reloadData(text: String) {
        translateOutputVC.reloadData(text: text)
    }
    
    @IBAction func tappedSendToWatch(_ sender: UIBarButtonItem) {
        
        if !WatchSessionManager.sharedManager.shouldShowMessageOptionEnabled() {
            let alert = UIAlertController(title: "Open Watch app", message: "You must open the watch app to send this translation.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
        
        WatchSessionManager.sharedManager.sendMessage(message: [kLastTranslationKey: translateOutputVC.dataSource as AnyObject])
    }
    
    

}

//MARK: Helpers

private extension TranslateOutputContainerViewController {
    func setupNotifications() {
        let watchActiveNotification = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: kNotificationWatchIsActive), object: nil, queue: nil, using: { [unowned self] (notification) in
            self.configureWatchButton(shouldShow: true, shouldEnable: true)
        })
        
        let watchInActiveNotification = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: kNotificationWatchIsInActive), object: nil, queue: nil, using: { [unowned self] (notification) in
            self.configureWatchButton(shouldShow: true, shouldEnable: false)
        })
        
        notifications.append(watchActiveNotification)
        notifications.append(watchInActiveNotification)
    }
    
    func configureWatchButton(shouldShow: Bool, shouldEnable: Bool) {
        sendToWatchButton.isEnabled = shouldShow
        sendToWatchButton.tintColor = shouldShow ? (shouldEnable ? UIColor.blue : UIColor.gray) : UIColor.clear
    }
}

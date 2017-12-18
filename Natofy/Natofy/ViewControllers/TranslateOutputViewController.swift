//
//  TranslateOutputViewController.swift
//  Natofy
//
//  Created by Toni Sevener on 12/14/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import UIKit

class TranslateOutputViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var originalTranslationView: UIView!
    @IBOutlet private var originalTranslationLabel: UILabel!
    @IBOutlet private var originalTranslationViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var sendToWatchButton: UIBarButtonItem!
    
    private var dataSource: [String] = []
    private var originalText: String! {
        didSet {
            originalTranslationLabel.text = originalText
            view.setNeedsLayout()
            view.layoutIfNeeded()
            evaluateOriginalTextView(collection: traitCollection)
        }
    }
    private var previousContentOffsetY = CGFloat(0)
    private var originalContentOffsetY = CGFloat(0)
    
    var notifications: [AnyObject] = []
    
    //MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         evaluateOriginalTextView(collection: traitCollection)
        
        setupNotifications()
        
        configureWatchButton(shouldShow: WatchSessionManager.sharedManager.shouldShowMessageOption(), shouldEnable: WatchSessionManager.sharedManager.shouldShowMessageOptionEnabled())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        previousContentOffsetY = tableView.contentOffset.y
        if originalContentOffsetY == 0 {
            originalContentOffsetY = previousContentOffsetY
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        for notification in notifications {
            NotificationCenter.default.removeObserver(notification)
        }
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        evaluateOriginalTextView(collection: newCollection)
    }
    
    func reloadData(text: String) {
        let translation = NatoConverter.convert(text: text)
        dataSource = translation
        tableView.reloadData()
        originalText = text
    }
    
    @IBAction func tappedSendToWatch(_ sender: UIBarButtonItem) {
        
        if !WatchSessionManager.sharedManager.shouldShowMessageOptionEnabled() {
            let alert = UIAlertController(title: "Open Watch app", message: "You must open the watch app to send this translation.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
        
        WatchSessionManager.sharedManager.sendMessage(message: [kLastTranslationKey: dataSource as AnyObject])
    }
}

//MARK: Helpers

private extension TranslateOutputViewController {
    
    func setupNotifications() {
        let dynamicTypeChangeNotification = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil, queue: nil, using: { [unowned self] (notification) in
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            self.evaluateOriginalTextView(collection: self.traitCollection)
        })
        
        let watchActiveNotification = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: kNotificationWatchIsActive), object: nil, queue: nil, using: { [unowned self] (notification) in
            self.configureWatchButton(shouldShow: true, shouldEnable: true)
        })
        
        let watchInActiveNotification = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: kNotificationWatchIsInActive), object: nil, queue: nil, using: { [unowned self] (notification) in
            self.configureWatchButton(shouldShow: true, shouldEnable: false)
        })
        
        notifications.append(dynamicTypeChangeNotification)
        notifications.append(watchActiveNotification)
        notifications.append(watchInActiveNotification)
    }
    
    func configureWatchButton(shouldShow: Bool, shouldEnable: Bool) {
            sendToWatchButton.isEnabled = shouldShow
            sendToWatchButton.tintColor = shouldShow ? (shouldEnable ? UIColor.blue : UIColor.gray) : UIColor.clear
    }
    
    func evaluateOriginalTextView(collection: UITraitCollection) {
        switch collection.horizontalSizeClass {
        case .compact:
                originalTranslationView.isHidden = false
                originalTranslationViewTopConstraint.constant = 0
                tableView.contentInset.top = originalTranslationView.frame.height
            default:
                originalTranslationView.isHidden = true
                originalTranslationViewTopConstraint.constant = -originalTranslationView.frame.height
                tableView.contentInset.top = 0
        }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        if dataSource.count > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
}

extension TranslateOutputViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var newValue = originalTranslationViewTopConstraint.constant
        
        if traitCollection.horizontalSizeClass != .compact {
            return
        }
        
        if scrollView.isBouncingBottom && originalTranslationViewTopConstraint.constant != originalTranslationView.frame.height {
            newValue = originalTranslationView.frame.height
            setOriginalTranslationViewConstraint(newValue: newValue)
            return
        }
        
        if scrollView.isBouncing {
            return
        }
        
        let delta = -(-originalContentOffsetY + scrollView.contentOffset.y)
        
        if scrollView.contentOffset.y > previousContentOffsetY {
            newValue = min(originalTranslationView.frame.height,-delta)
        } else {
            newValue = 0
        }
        
        setOriginalTranslationViewConstraint(newValue: newValue)
        
        previousContentOffsetY = scrollView.contentOffset.y
    }
    
    func setOriginalTranslationViewConstraint(newValue: CGFloat) {
        if newValue != originalTranslationViewTopConstraint.constant {
            originalTranslationViewTopConstraint.constant = newValue
            UIView.animate(withDuration: 0.2, animations: {
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            })
        }
    }
}

//MARK: UITableViewDataSource

extension TranslateOutputViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let letter = dataSource[safe: indexPath.row] else {
            fatalError()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "translatorLetterCellIdentifier", for: indexPath)
        
        if let translationCell = cell as? TranslationTableViewCell {
            translationCell.configure(title: letter)
        }
        
        return cell
    }
}

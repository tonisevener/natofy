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
    
    public private(set) var dataSource: [String] = []
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
    
}

//MARK: Helpers

private extension TranslateOutputViewController {
    
    func setupNotifications() {
        let dynamicTypeChangeNotification = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil, queue: nil, using: { [unowned self] (notification) in
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            self.evaluateOriginalTextView(collection: self.traitCollection)
        })
        
        notifications.append(dynamicTypeChangeNotification)
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

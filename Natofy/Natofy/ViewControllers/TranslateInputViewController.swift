//
//  TranslateInputViewController.swift
//  Natofy
//
//  Created by Toni Sevener on 12/12/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import UIKit

protocol TranslateInputViewControllerDelegate: class {
    func tappedTranslate(text: String)
}

class TranslateInputViewController: UIViewController {
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var translateFromClipboardButton: UIButton!
    @IBOutlet private var goButton: UIButton!
    @IBOutlet private var dynamicBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var verticalCenterConstraint: NSLayoutConstraint!
    
    weak var delegate: TranslateInputViewControllerDelegate?
    private var originalDynamicBottomConstraintConstant: CGFloat = 0
    private var bottomConstraintSet = false

    private var observers:[AnyObject] = []
    
    let placeholderText = "Enter text to translate."
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        evaluateClipboardButton(parentSize: view.frame.size)
        evaluateGoButton()
        
        textView.textColor = .lightGray
        textView.text = placeholderText
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !bottomConstraintSet {
            let insets = view.safeAreaInsets
            dynamicBottomConstraint.constant = (view.frame.height - insets.bottom) - stackView.frame.maxY
            originalDynamicBottomConstraintConstant = dynamicBottomConstraint.constant
            dynamicBottomConstraint.isActive = true
            verticalCenterConstraint.isActive = false
            bottomConstraintSet = true
            view.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        for observer in observers {
            NotificationCenter.default.removeObserver(observer)
        }
        
        observers = []
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        dynamicBottomConstraint.isActive = false
        verticalCenterConstraint.isActive = true
        bottomConstraintSet = false
        
        evaluateClipboardButton(parentSize: size)
    }
}

//MARK: IBActions

private extension TranslateInputViewController {
    @IBAction func tappedTranslate(_ sender: Any) {
        textView.resignFirstResponder()
        translate()
    }
    
    @IBAction func tappedBackground(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func tappedTranslateFromClipboard(_ sender: UIButton) {
        
        textView.resignFirstResponder()
        
        if let clipboardText = UIPasteboard.general.string {
            textView.text = clipboardText
            textView.textColor = .black
            translate()
        }
    }
}

//MARK: Private Helpers

private extension TranslateInputViewController {
    
    func evaluateClipboardButton(parentSize: CGSize) {
        translateFromClipboardButton.isEnabled = UIPasteboard.general.string != nil
        
        if parentSize.width < 330 {
            translateFromClipboardButton.setTitle("Clipboard", for: .normal)
        } else {
            translateFromClipboardButton.setTitle("Use clipboard", for: .normal)
        }
    }
    
    func evaluateGoButton() {
        goButton.isEnabled = textView.text.count > 0
    }
    
    func translate() {
        delegate?.tappedTranslate(text: textView.text)
    }
    
    func setupKeyboardNotifications() {
        let observer1 = NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) { [unowned self] (notification) in
            guard let userInfo = notification.userInfo,
                let frame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
                let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
                self.dynamicBottomConstraint.constant == self.originalDynamicBottomConstraintConstant else {
                    return
            }
            
            let convertedFrame = self.view.convert(frame, from: UIScreen.main.coordinateSpace)
            let intersectedKeyboardFrame = self.stackView.frame.intersection(convertedFrame)
            
            self.dynamicBottomConstraint.constant += intersectedKeyboardFrame.height
            
            UIView.animate(withDuration: duration, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
        
        let observer2 = NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) { [unowned self] (notification) in
            guard let userInfo = notification.userInfo,
                let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
                self.dynamicBottomConstraint.constant != self.originalDynamicBottomConstraintConstant else {
                    return
            }
            
            self.dynamicBottomConstraint.constant = self.originalDynamicBottomConstraintConstant
            
            UIView.animate(withDuration: duration, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
        
        let observer3 = NotificationCenter.default.addObserver(forName: .UIPasteboardChanged, object: nil, queue: nil) { [unowned self] (notification) in
            self.evaluateClipboardButton(parentSize: self.view.frame.size)
        }
        
        let observer4 = NotificationCenter.default.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: nil) { [unowned self] (notification) in
            self.evaluateClipboardButton(parentSize: self.view.frame.size)
        }
        
        observers.append(contentsOf: [observer1, observer2, observer3, observer4])
    }
}

extension TranslateInputViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        evaluateGoButton()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
}

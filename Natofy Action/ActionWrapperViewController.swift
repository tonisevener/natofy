//
//  ActionWrapperViewController.swift
//  Natofy Action
//
//  Created by Toni Sevener on 1/24/21.
//

import UIKit
import SwiftUI

class ActionWrapperViewController: UIViewController {
    
    private var hostingViewController: UIHostingController<ActionTranslateOutputView>?
    
    var highlightedText: String? {
        didSet {
            guard let highlightedText = highlightedText,
                  highlightedText.count > 0 else {
                return
            }
            
            setupHostingControllerIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHostingControllerIfNeeded()
    }

    private func setupHostingControllerIfNeeded() {
        
        guard let highlightedText = highlightedText,
              highlightedText.count > 0,
              isViewLoaded,
              hostingViewController == nil else {
            return
        }
        
        let hostingViewController = UIHostingController(rootView: ActionTranslateOutputView(translationInput: TranslationInput(inputText: highlightedText)))
        
        addChild(hostingViewController)
        view.addSubview(hostingViewController.view)
        self.hostingViewController = hostingViewController
        setupConstraints()
    }
    
    private func setupConstraints() {
        guard let hostingViewController = self.hostingViewController else {
            return
        }
        
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

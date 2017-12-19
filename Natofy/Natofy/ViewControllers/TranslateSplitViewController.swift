//
//  TranslateSplitViewController.swift
//  Natofy
//
//  Created by Toni Sevener on 12/12/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import UIKit

class TranslateSplitViewController: UISplitViewController {
    
    var inputVC: TranslateInputViewController!
    var containerOutputVC: TranslateOutputContainerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredDisplayMode = .allVisible
        delegate = self
        
        if let navVC = viewControllers[safe: 0] as? UINavigationController,
        let inputVC = navVC.viewControllers[safe: 0] as? TranslateInputViewController,
        let containerOutputVC = viewControllers[safe: 1] as? TranslateOutputContainerViewController {
            self.inputVC = inputVC
            inputVC.delegate = self
            
            self.containerOutputVC = containerOutputVC
        } else {
            fatalError()
        }

        // Do any additional setup after loading the view.
    }
}

extension TranslateSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

extension TranslateSplitViewController: TranslateInputViewControllerDelegate {
    func tappedTranslate(text: String) {
        containerOutputVC.reloadData(text: text)
        showDetailViewController(containerOutputVC, sender: nil)
    }
}

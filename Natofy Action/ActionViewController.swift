//
//  ActionViewController.swift
//  Natofy Action
//
//  Created by Toni Sevener on 1/24/21.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    var actionWrapperVC: ActionWrapperViewController? {
        didSet {
            if let highlightedText = highlightedText,
               highlightedText.count > 0 {
                actionWrapperVC?.highlightedText = highlightedText
            }
        }
    }
    
    private var highlightedText: String? {
        didSet {
            if let highlightedText = highlightedText,
               highlightedText.count > 0 {
                actionWrapperVC?.highlightedText = highlightedText
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        var textFound = false
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! {
                if provider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
                    provider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { [unowned self] (text, error) in
                        if let text = text as? String {
                            DispatchQueue.main.async {
                                self.highlightedText = text
                            }
                        }
                    })
                    
                    textFound = true
                    break
                }
            }
            
            if (textFound) {
                break
            }
        }
        
        preferredContentSize = CGSize(width: super.preferredContentSize.width, height: CGFloat.infinity)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "wrapperEmbedSegue",
            let actionWrapperVC = segue.destination as? ActionWrapperViewController else {
                return
        }
        
        self.actionWrapperVC = actionWrapperVC
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}

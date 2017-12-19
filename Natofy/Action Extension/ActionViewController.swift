//
//  ActionViewController.swift
//  Action Extension
//
//  Created by Toni Sevener on 12/18/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var translateOutputVC: TranslateOutputViewController? {
        didSet {
            if highlightedText != nil {
                translateOutputVC?.reloadData(text: highlightedText!)
            }
        }
    }
    
    private var highlightedText: String? {
        didSet {
            if highlightedText != nil {
                translateOutputVC?.reloadData(text: highlightedText!)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        var textFound = false
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "TranslationOutputEmbedSegue",
            let translateOutputVC = segue.destination as? TranslateOutputViewController else {
                return
        }
        
        self.translateOutputVC = translateOutputVC
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}

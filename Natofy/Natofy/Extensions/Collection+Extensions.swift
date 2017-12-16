//
//  Collection+Extensions.swift
//  Natofy
//
//  Created by Toni Sevener on 12/12/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import Foundation
import UIKit

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIScrollView {
    var isBouncing: Bool {
        return isBouncingTop || isBouncingLeft || isBouncingBottom || isBouncingRight
    }
    var isBouncingTop: Bool {
        return contentOffset.y < -adjustedContentInset.top
    }
    var isBouncingLeft: Bool {
        return contentOffset.x < -adjustedContentInset.left
    }
    var isBouncingBottom: Bool {
        let contentFillsScrollEdges = contentSize.height + adjustedContentInset.top + adjustedContentInset.bottom >= bounds.height
        return contentFillsScrollEdges && contentOffset.y > contentSize.height - bounds.height + adjustedContentInset.bottom
    }
    var isBouncingRight: Bool {
        let contentFillsScrollEdges = contentSize.width + adjustedContentInset.left + adjustedContentInset.right >= bounds.width
        return contentFillsScrollEdges && contentOffset.x > contentSize.width - bounds.width + adjustedContentInset.right
    }
}

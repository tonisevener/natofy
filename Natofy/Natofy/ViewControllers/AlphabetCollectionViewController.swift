//
//  AlphabetCollectionViewController.swift
//  Natofy
//
//  Created by Toni Sevener on 12/12/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import UIKit

private let reuseIdentifier = "alphabetLetterCellIdentifier"

class AlphabetCollectionViewController: UICollectionViewController {
    
    let dataSource = NatoConverter.alphabetArray
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    var futureSizeClass: UITraitCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        futureSizeClass = traitCollection
        determineCellSize(traitCollection: futureSizeClass, size: view.frame.size)
    }
    
    private func determineCellSize(traitCollection: UITraitCollection, size: CGSize) {
        let numCellsPerRow = traitCollection.horizontalSizeClass == .regular ? CGFloat(5) : CGFloat(3)
        let cellSide = size.width / numCellsPerRow
        flowLayout.itemSize = CGSize(width: cellSide, height: cellSide)
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        futureSizeClass = newCollection
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        //NOTE: This logic depends on (willTransition to newCollection) to be called before viewWillTransition(to size:)....is there a better way?
        if isViewLoaded {
            determineCellSize(traitCollection: futureSizeClass, size: size)
            flowLayout.invalidateLayout()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let translation = dataSource[safe: indexPath.row] else {
            fatalError()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let alphabetCell = cell as? AlphabetCollectionViewCell {
            alphabetCell.configure(letter: translation.short, name: translation.long)
        }
    
        return cell
    }

}

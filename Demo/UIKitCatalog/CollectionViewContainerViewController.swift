/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A `UICollectionViewController` who's cells each contain a `UICollectionView`. This class demonstrates how to ensure focus behaves correctly in this situation.
*/

import UIKit

class CollectionViewContainerViewController: UICollectionViewController {
    // MARK: Properties
    
    private static let minimumEdgePadding = CGFloat(90.0)
    
    private let dataItemsByGroup: [[DataItem]] = {
        return DataItem.Group.allGroups.map { group in
            return DataItem.sampleItems.filter { $0.group == group }
        }
    }()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Make sure their is sufficient padding above and below the content.
        guard let collectionView = collectionView, let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        collectionView.contentInset.top = CollectionViewContainerViewController.minimumEdgePadding - layout.sectionInset.top
        collectionView.contentInset.bottom = CollectionViewContainerViewController.minimumEdgePadding - layout.sectionInset.bottom
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Our collection view displays 1 section per group of items.
        return dataItemsByGroup.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Each section contains a single `CollectionViewContainerCell`.
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue a cell from the collection view.
        return collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewContainerCell.reuseIdentifier, for: indexPath)
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CollectionViewContainerCell else { fatalError("Expected to display a `CollectionViewContainerCell`.") }
        
        // Configure the cell.
        let sectionDataItems = dataItemsByGroup[indexPath.section]
        cell.configure(with: sectionDataItems)
    }
    
    override func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        /*
            Return `false` because we don't want this `collectionView`'s cells to
            become focused. Instead the `UICollectionView` contained in the cell
            should become focused.
        */
        return false
    }
}

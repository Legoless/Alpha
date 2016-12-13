/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A `UICollectionViewCell` subclass that contains a `UICollectionView`. This class demonstrates how to ensure the focus is passed to the contained collection view.
*/

import UIKit

class CollectionViewContainerCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: Properties
    
    static let reuseIdentifier = "CollectionViewContainerCell"
    
    @IBOutlet var collectionView: UICollectionView!
    
    private var dataItems = [DataItem]()
    
    private let cellComposer = DataItemCellComposer()
    
    override var preferredFocusedView: UIView? {
        return collectionView
    }
    
    // MARK: Configuration
    
    func configure(with dataItems: [DataItem]) {
        self.dataItems = dataItems
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: DataItemCollectionViewCell.reuseIdentifier, for: indexPath)
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? DataItemCollectionViewCell else { fatalError("Expected to display a DataItemCollectionViewCell") }
        let item = dataItems[(indexPath as NSIndexPath).row]
        
        // Configure the cell.
        cellComposer.compose(cell, withDataItem: item)
    }
}

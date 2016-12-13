/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use a `UICollectionViewController`. A custom `UIView` subclass, `GradientMaskView` is used to mask the contents of the collection view as it scrolls beneath the containing `UINavigationController`'s `UINavigationBar`.
*/

import UIKit

class CollectionViewController: UICollectionViewController {
    // MARK: Properties
    
    private let items = DataItem.sampleItems
    
    private let cellComposer = DataItemCellComposer()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let collectionView = collectionView else { return }
        
        /*
            Add a gradient mask to the collection view. This will fade out the
            contents of the collection view as it scrolls beneath the transparent
            navigation bar.
        */
        collectionView.mask = GradientMaskView(frame: CGRect(origin: CGPoint.zero, size: collectionView.bounds.size))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let collectionView = collectionView,
                let maskView = collectionView.mask as? GradientMaskView,
                let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        else {
            return
        }
        
        /*
            Update the mask view to have fully faded out any collection view
            content above the navigation bar's label.
        */
        maskView.maskPosition.end = topLayoutGuide.length * 0.8

        /*
            Update the position from where the collection view's content should
            start to fade out. The size of the fade increases as the collection
            view scrolls to a maximum of half the navigation bar's height.
        */
        let maximumMaskStart = maskView.maskPosition.end + (topLayoutGuide.length * 0.5)
        let verticalScrollPosition = max(0, collectionView.contentOffset.y + collectionView.contentInset.top)
        maskView.maskPosition.start = min(maximumMaskStart, maskView.maskPosition.end + verticalScrollPosition)
        
        /*
            Position the mask view so that it is always fills the visible area of
            the collection view.
        */
        var rect = CGRect(origin: CGPoint(x: 0, y: collectionView.contentOffset.y), size: collectionView.bounds.size)
        
        /*
            Increase the width of the mask view so that it doesn't clip focus
            shadows along its edge. Here we are basing the amount to increase the
            frame by on the spacing defined in the collection view's layout.
        */
        rect = rect.insetBy(dx: -layout.minimumInteritemSpacing, dy: 0)
        
        maskView.frame = rect
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // The collection view shows all items in a single section.
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue a cell from the collection view.
        return collectionView.dequeueReusableCell(withReuseIdentifier: DataItemCollectionViewCell.reuseIdentifier, for: indexPath)
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? DataItemCollectionViewCell else { fatalError("Expected to display a `DataItemCollectionViewCell`.") }
        let item = items[(indexPath as NSIndexPath).row]

        // Configure the cell.
        cellComposer.compose(cell, withDataItem: item)
    }
}

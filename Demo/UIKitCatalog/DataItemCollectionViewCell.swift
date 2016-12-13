/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A `UICollectionViewCell` subclass used to display `DataItem`s within `UICollectionView`s.
*/

import UIKit

class DataItemCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    
    static let reuseIdentifier = "DataItemCell"
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var representedDataItem: DataItem?
    
    // MARK: Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // These properties are also exposed in Interface Builder.
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.clipsToBounds = false
        
        label.alpha = 0.0
    }
    
    // MARK: UICollectionReusableView
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset the label's alpha value so it's initially hidden.
        label.alpha = 0.0
    }
    
    // MARK: UIFocusEnvironment
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        /*
            Update the label's alpha value using the `UIFocusAnimationCoordinator`.
            This will ensure all animations run alongside each other when the focus
            changes.
        */
        coordinator.addCoordinatedAnimations({
            if self.isFocused {
                self.label.alpha = 1.0
            }
            else {
                self.label.alpha = 0.0
            }
        }, completion: nil)
    }
}

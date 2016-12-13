/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A `UIView` subclass that is used to mask the contents of a `CollectionViewController`.
*/

import UIKit

class GradientMaskView: UIView {
    // MARK: Properties
    
    /// The position in points between which the gradient is drawn.
    var maskPosition: (start: CGFloat, end: CGFloat) {
        didSet {
            updateGradientLayer()
        }
    }

    /// The `CAGradientLayer` responsible for drawing the alpha gradient.
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(white: 0.0, alpha: 0.0).cgColor, UIColor(white: 0.0, alpha: 1.0).cgColor]
        
        return layer
    }()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        maskPosition = (start: 0, end: 0)
        
        super.init(frame: frame)
        
        layer.addSublayer(gradientLayer)
        updateGradientLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        maskPosition = (start: 0, end: 0)

        super.init(coder: aDecoder)
        
        layer.addSublayer(gradientLayer)
        updateGradientLayer()
    }
    
    // MARK: UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateGradientLayer()
    }
    
    // MARK: Convenience
    
    private func updateGradientLayer() {
        // Update the `gradientLayer` frame to match the view's bounds.
        gradientLayer.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
        
        /*
            Update the `gradientLayer`'s gradient locations with the `maskPosition`
            converted to the `gradientLayer`'s unit coordinate space.
        */
        gradientLayer.locations = [maskPosition.end / bounds.size.height as NSNumber, maskPosition.start / bounds.size.height as NSNumber]
    }
}

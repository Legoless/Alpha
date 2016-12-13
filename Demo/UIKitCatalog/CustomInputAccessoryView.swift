/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A `UIView` subclass that is used to add a custom title to the text input screens for `UITextField`s.
*/

import UIKit

class CustomInputAccessoryView: UIView {
    // MARK: Properties
    
    let titleLabel = UILabel(frame: CGRect.zero)
    
    // MARK: Initialization
    
    init(title: String) {
        /*
            Call the designated initializer with an inital zero frame. The final
            frame will be determined by the layout constraints added later.
        */
        super.init(frame: CGRect.zero)

        // Setup the label and add it to the view.
        titleLabel.font = UIFont.systemFont(ofSize: 60, weight: UIFontWeightMedium)
        titleLabel.text = title
        
        addSubview(titleLabel)
        
        /*
            Turn off automatic transaltion of resizing masks into constraints as
            we'll be specifying our own layout constraints.
        */
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        /*
            Add layout constraints to the label that specifies it must fill the
            containing view with an additional 60pts of bottom padding.
        */
        let viewsDictionary = ["titleLabel": titleLabel]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: [], metrics: nil, views: viewsDictionary))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel]-60-|", options: [], metrics: nil, views: viewsDictionary))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}

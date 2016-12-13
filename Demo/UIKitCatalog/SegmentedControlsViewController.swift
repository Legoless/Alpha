/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use `UISegmentedControl`.
*/

import UIKit

class SegmentedControlsViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var customBackgroundSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCustomBackgroundSegmentedControl()
    }
    
    private func configureCustomBackgroundSegmentedControl() {
        // Set the background images for each control state.
        let normalSegmentBackgroundImage = UIImage(named: "stepper_and_segment_background")
        customBackgroundSegmentedControl.setBackgroundImage(normalSegmentBackgroundImage, for: UIControlState(), barMetrics: .default)

        let disabledSegmentBackgroundImage = UIImage(named: "stepper_and_segment_background_disabled")
        customBackgroundSegmentedControl.setBackgroundImage(disabledSegmentBackgroundImage, for: .disabled, barMetrics: .default)

        let highlightedSegmentBackgroundImage = UIImage(named: "stepper_and_segment_background_highlighted")
        customBackgroundSegmentedControl.setBackgroundImage(highlightedSegmentBackgroundImage, for: .highlighted, barMetrics: .default)

        // Set the divider image.
        let segmentDividerImage = UIImage(named: "stepper_and_segment_divider")
        customBackgroundSegmentedControl.setDividerImage(segmentDividerImage, forLeftSegmentState: UIControlState(), rightSegmentState: UIControlState(), barMetrics: .default)

        // Create a font to use for the attributed title (both normal and highlighted states).
        let captionFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFontTextStyle.caption1)
        let font = UIFont(descriptor: captionFontDescriptor, size: 0)

        let normalTextAttributes = [
            NSForegroundColorAttributeName: UIColor.purple,
            NSFontAttributeName: font
        ]
        customBackgroundSegmentedControl.setTitleTextAttributes(normalTextAttributes, for: UIControlState())

        let highlightedTextAttributes = [
            NSForegroundColorAttributeName: UIColor.purple,
            NSFontAttributeName: font
        ]
        customBackgroundSegmentedControl.setTitleTextAttributes(highlightedTextAttributes, for: .highlighted)
    }
}

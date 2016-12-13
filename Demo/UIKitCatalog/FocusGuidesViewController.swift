/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to add and update `UIFocusGuide`s.
*/

import UIKit

class FocusGuidesViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet var topRightButton: UIButton!
    
    @IBOutlet var bottomLeftButton: UIButton!
    
    private var focusGuide: UIFocusGuide!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
            Create a focus guide to fill the gap below button 2 and to the right
            of button 3.
        */
        focusGuide = UIFocusGuide()
        view.addLayoutGuide(focusGuide)
        
        // Anchor the top left of the focus guide.
        focusGuide.leftAnchor.constraint(equalTo: topRightButton.leftAnchor).isActive = true
        focusGuide.topAnchor.constraint(equalTo: bottomLeftButton.topAnchor).isActive = true
        
        // Anchor the width and height of the focus guide.
        focusGuide.widthAnchor.constraint(equalTo: topRightButton.widthAnchor).isActive = true
        focusGuide.heightAnchor.constraint(equalTo: bottomLeftButton.heightAnchor).isActive = true
    }

    // MARK: UIFocusEnvironment
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        /*
            Update the focus guide's `preferredFocusedView` depending on which
            button has the focus.
        */
        guard let nextFocusedView = context.nextFocusedView else { return }

        switch nextFocusedView {
            case topRightButton:
                focusGuide.preferredFocusEnvironments = [bottomLeftButton]
            
            case bottomLeftButton:
                focusGuide.preferredFocusEnvironments = [topRightButton]
            
            default:
                focusGuide.preferredFocusEnvironments = []
        }
    }
}

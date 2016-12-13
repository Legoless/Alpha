/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    The `MenuTableViewController` subclass for the "Text Entry" section of the app.
*/

import UIKit

class TextEntryMenuViewController: MenuTableViewController {
    // MARK: Properties
    
    override var segueIdentifierMap: [[String]] {
        return [
            [
                "ShowSimpleForm",
                "ShowAlertForm"
            ]
        ]
    }
}

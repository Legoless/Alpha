/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how customize the `inputAccessoryView` of `UITextField`s.
*/

import UIKit

class TextFieldsViewController: UIViewController {
    // MARK: Properties

    @IBOutlet var regularKeyboardTextField: UITextField!
    
    @IBOutlet var emailKeyboardTextField: UITextField!
    
    @IBOutlet var numberPadTextField: UITextField!
    
    @IBOutlet var numbersAndPunctuationKeyboardTextField: UITextField!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Specify custom input accessory fields for each text view.
        regularKeyboardTextField.inputAccessoryView = CustomInputAccessoryView(title: NSLocalizedString("Regular Text", comment: ""))
        emailKeyboardTextField.inputAccessoryView = CustomInputAccessoryView(title: NSLocalizedString("Email Address", comment: ""))
        numberPadTextField.inputAccessoryView = CustomInputAccessoryView(title: NSLocalizedString("Number Pad", comment: ""))
        numbersAndPunctuationKeyboardTextField.inputAccessoryView = CustomInputAccessoryView(title: NSLocalizedString("Numbers and Punctation", comment: ""))
    }
}

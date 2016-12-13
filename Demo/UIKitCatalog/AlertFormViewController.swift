/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to implement text entry using `UIAlertController`.
*/

import UIKit

class AlertFormViewController: UIViewController {
    // MARK: Properties
    
    private weak var secureTextAlertAction: UIAlertAction?
    
    // MARK: IB Actions
    
    @IBAction func showSimpleForm(_ sender: AnyObject) {
        let title = NSLocalizedString("A Short Title is Best", comment: "")
        let message = NSLocalizedString("A message should be a short, complete sentence.", comment: "")
        let acceptButtonTitle = NSLocalizedString("OK", comment: "")
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add two text fields for text entry.
        alertController.addTextField { textField in
            // Customize the text field.
            textField.placeholder = NSLocalizedString("Name", comment: "")
            
            // Specify a custom input accessory view with a descriptive title.
            let inputAccessoryView = CustomInputAccessoryView(title: NSLocalizedString("Enter your name", comment: ""))
            textField.inputAccessoryView = inputAccessoryView
        }

        alertController.addTextField { textField in
            // Customize the text field.
            textField.keyboardType = .emailAddress
            textField.placeholder = NSLocalizedString("example@example.com", comment: "")
            
            // Specify a custom input accessory view with a descriptive title.
            let inputAccessoryView = CustomInputAccessoryView(title: "Enter your email address")
            textField.inputAccessoryView = inputAccessoryView
        }

        // Create the actions.
        let acceptAction = UIAlertAction(title: acceptButtonTitle, style: .default) {[unowned alertController] _ in
            print("The \"Text Entry\" alert's other action occured.")
            
            if let enteredText = alertController.textFields?.first?.text {
                print("The text entered into the \"Text Entry\" alert's text field was \"\(enteredText)\"")
            }
        }
        
        /*
            The cancel action is created the the `Cancel` style and no title.
            This will allow us to capture the user clicking the menu button to
            cancel the alert while not showing a specific cancel button.
        */
        let cancelAction = UIAlertAction(title: nil, style: .cancel) { _ in
            print("The \"Text Entry\" alert's cancel action occured.")
        }
        
        // Add the actions.
        alertController.addAction(acceptAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    /**
        Show a secure text entry alert with "OK" and "Cancel" buttons.
    
        The "OK" button is only enabled when at least 5 characters have been
        entered into the text field.
    */
    @IBAction func showSecureTextEntry(_ sender: AnyObject) {
        let title = NSLocalizedString("A Short Title is Best", comment: "")
        let message = NSLocalizedString("A message should be a short, complete sentence.", comment: "")
        let acceptButtonTitle = NSLocalizedString("OK", comment: "")
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add the text field for the secure text entry.
        alertController.addTextField { textField in
            // Customize the text field.
            textField.placeholder = NSLocalizedString("Password", comment: "")
            textField.isSecureTextEntry = true

            // Specify a custom input accessory view with a descriptive title.
            let inputAccessoryView = CustomInputAccessoryView(title: "Enter at least 5 characters")
            textField.inputAccessoryView = inputAccessoryView
            
            /*
                Add a target that is called when the text field's text is changed so that we
                can toggle the `otherAction` enabled property based on whether the user has
                entered a long enough string.
            */
            textField.addTarget(self, action: #selector(AlertFormViewController.handleTextFieldTextDidChangeNotification(_:)), for: .editingChanged)
        }

        // Create the actions.
        let acceptAction = UIAlertAction(title: acceptButtonTitle, style: .default) { _ in
            print("The \"Secure Text Entry\" alert's other action occured.")
        }
        
        /*
            The cancel action is created with the `Cancel` style and no title.
            This will allow us to capture the user clicking the menu button to
            cancel the alert while not showing a specific cancel button.
        */
        let cancelAction = UIAlertAction(title: nil, style: .cancel) { _ in
            print("The \"Text Entry\" alert's cancel action occured.")
        }
        
        // The text field initially has no text in the text field, so we'll disable it.
        acceptAction.isEnabled = false
        
        /*
            Hold onto the secure text alert action to toggle the enabled / disabled 
            state when the text changed.
        */
        secureTextAlertAction = acceptAction
        
        // Add the actions.
        alertController.addAction(acceptAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Convenience
    
    func handleTextFieldTextDidChangeNotification(_ textField: UITextField) {
        guard let secureTextAlertAction = secureTextAlertAction else { fatalError("secureTextAlertAction has not been set") }
        
        // Enforce a minimum length of >= 5 characters for secure text alerts.
        let text = textField.text ?? ""
        secureTextAlertAction.isEnabled = text.characters.count >= 5
    }
}

/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that displays the image for a `DataItem`. An instance of this class is created for each page of `PageViewController`.
*/

import UIKit

class DataItemViewController: UIViewController {
    // MARK: Properties
    
    static let storyboardIdentifier = "DataItemViewController"

    @IBOutlet var imageView: UIImageView!
    
    var dataItem: DataItem!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: dataItem.largeImageName)
    }
    
    // MARK: Convenience
    
    func configure(with dataItem: DataItem) {
        self.dataItem = dataItem
    }
}

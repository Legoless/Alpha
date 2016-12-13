/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that demonstrates how to use `UIPageViewController`. Each page shows a `DataItem` via an instance of a `DataItemViewController`.
*/

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    private let dataItems = DataItem.sampleItems.filter { $0.group == .Lola }
    
    private let dataItemViewControllerCache = NSCache<NSString, DataItemViewController>()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        let initialViewController = dataItemViewController(forPage: 0)
        setViewControllers([initialViewController], direction: .forward, animated: false, completion: nil)
    }

    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = indexOfDataItem(forViewController: viewController)
        
        if index > 0 {
            return dataItemViewController(forPage: index - 1)
        }
        else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = indexOfDataItem(forViewController: viewController)
        
        if index < dataItems.count - 1 {
            return dataItemViewController(forPage: index + 1)
        }
        else {
            return nil
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataItems.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentViewController = pageViewController.viewControllers?.first else { fatalError("Unable to get the page controller's current view controller.") }
        
        return indexOfDataItem(forViewController: currentViewController)
    }
    
    // MARK: Convenience
    
    private func indexOfDataItem(forViewController viewController: UIViewController) -> Int {
        guard let viewController = viewController as? DataItemViewController else { fatalError("Unexpected view controller type in page view controller.") }
        guard let viewControllerIndex = dataItems.index(of: viewController.dataItem) else { fatalError("View controller's data item not found.") }
        
        return viewControllerIndex
    }
    
    private func dataItemViewController(forPage pageIndex: Int) -> DataItemViewController {
        let dataItem = dataItems[pageIndex]
        
        if let cachedController = dataItemViewControllerCache.object(forKey: dataItem.identifier as NSString) {
            // Return the cached view controller.
            return cachedController
        }
        else {
            // Instantiate and configure a `DataItemViewController` for the `DataItem`.
            guard let controller = storyboard?.instantiateViewController(withIdentifier: DataItemViewController.storyboardIdentifier) as? DataItemViewController else { fatalError("Unable to instantiate a DataItemViewController.") }
            controller.configure(with: dataItem)
            
            // Cache the view controller so it can be reused.
            dataItemViewControllerCache.setObject(controller, forKey: dataItem.identifier as NSString)
            
            // Return the newly created and cached view controller.
            return controller
        }
    }
}

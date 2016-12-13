/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A class used to populate a `DataItemCollectionViewCell` for a given `DataItem`. The composer class handles processing and caching images for `DataItem`s.
*/

import UIKit

class DataItemCellComposer {
    // MARK: Properties
    
    /// Cache used to store processed images, keyed on `DataItem` identifiers.
    static private var processedImageCache = NSCache<NSString, UIImage>()
    
    /**
        A dictionary of `NSOperationQueue`s for `DataItemCollectionViewCell`s. The
        queues contain operations that process images for `DataItem`s before updating
        the cell's `UIImageView`.
    */
    private var operationQueues = [DataItemCollectionViewCell: OperationQueue]()

    // MARK: Implementation
    
    func compose(_ cell: DataItemCollectionViewCell, withDataItem dataItem: DataItem) {
        // Cancel any queued operations to process images for the cell.
        let queue = operationQueue(forCell: cell)
        queue.cancelAllOperations()
        
        // Set the cell's properties.
        cell.representedDataItem = dataItem
        cell.label.text = dataItem.title
        cell.imageView.alpha = 1.0
        cell.imageView.image = DataItemCellComposer.processedImageCache.object(forKey: dataItem.identifier as NSString)
        
        // No further work is necessary if the cell's image view has an image.
        guard cell.imageView.image == nil else { return }

        /*
            Initial rendering of a jpeg image can be expensive. To avoid stalling
            the main thread, we create an operation to process the `DataItem`'s
            image before updating the cell's image view.
        
            The execution block is added after the operation is created to allow
            the block to check if the operation has been cancelled.
        */
        let processImageOperation = BlockOperation()
        
        processImageOperation.addExecutionBlock { [unowned processImageOperation] in
            // Ensure the operation has not been cancelled.
            guard !processImageOperation.isCancelled else { return }
            
            // Load and process the image.
            guard let image = self.processImage(named: dataItem.imageName) else { return }
            
            // Store the processed image in the cache.
            DataItemCellComposer.processedImageCache.setObject(image, forKey: dataItem.identifier as NSString)
            
            OperationQueue.main.addOperation {
                // Check that the cell is still showing the same `DataItem`.
                guard dataItem == cell.representedDataItem else { return }

                // Update the cell's `UIImageView` and then fade it into view.
                cell.imageView.alpha = 0.0
                cell.imageView.image = image
                
                UIView.animate(withDuration: 0.25) {
                    cell.imageView.alpha = 1.0
                }
            }
        }
        
        queue.addOperation(processImageOperation)
    }
    
    // MARK: Convenience
    
    /**
        Returns the `NSOperationQueue` for a given cell. Creates and stores a new
        queue if one doesn't already exist.
    */
    private func operationQueue(forCell cell: DataItemCollectionViewCell) -> OperationQueue {
        if let queue = operationQueues[cell] {
            return queue
        }
        
        let queue = OperationQueue()
        operationQueues[cell] = queue
        
        return queue
    }
    
    /**
        Loads a UIImage for a given name and returns a version that has been drawn
        into a `CGBitmapContext`.
    */
    private func processImage(named imageName: String) -> UIImage? {
        // Load the image.
        guard let image = UIImage(named: imageName) else { return nil }
        
        /*
            We only need to process jpeg images. Do no processing if the image
            name doesn't have a jpg suffix.
        */
        guard imageName.hasSuffix(".jpg") else { return image }
        
        // Create a `CGColorSpace` and `CGBitmapInfo` value that is appropriate for the device.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
        
        // Create a bitmap context of the same size as the image.
        let imageWidth = Int(Float(image.size.width))
        let imageHeight = Int(Float(image.size.height))
        
        let bitmapContext = CGContext(data: nil, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: imageWidth * 4, space: colorSpace, bitmapInfo: bitmapInfo)
        
        // Draw the image into the graphics context.
        guard let imageRef = image.cgImage else { fatalError("Unable to get a CGImage from a UIImage.") }
        bitmapContext?.draw(imageRef, in: CGRect(origin: CGPoint.zero, size: image.size))
        
        // Create a new `CGImage` from the contents of the graphics context.
        guard let newImageRef = bitmapContext?.makeImage() else { return image }
        
        // Return a new `UIImage` created from the `CGImage`.
        return UIImage(cgImage: newImageRef)
    }
}

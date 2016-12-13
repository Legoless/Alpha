/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    An extension of `DataItem` that provides string properties for a `DataItem`'s image name.
*/

import Foundation

extension DataItem {
    var imageName: String {
        switch group {
            case .Scenery:
                return "\(group.rawValue) \(number)"
                
            default:
                return "\(group.rawValue) \(number).jpg"
        }
    }
    
    var largeImageName: String {
        switch group {
            case .Scenery:
                return "\(group.rawValue) \(number) Large"
                
            default:
                return "\(group.rawValue) \(number) Large.jpg"
        }
    }
}

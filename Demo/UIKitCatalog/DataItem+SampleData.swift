/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    An extension of `DataItem` that provides a static array of sample `DataItem`s.
*/

import Foundation

extension DataItem {
    /// A static sample set of `DataItem`s.
    static var sampleItems: [DataItem] = {
        return [
            DataItem(group: .Scenery, number: 1, title: "Scenery 1"),
            DataItem(group: .Scenery, number: 2, title: "Scenery 2"),
            DataItem(group: .Scenery, number: 3, title: "Scenery 3"),
            DataItem(group: .Scenery, number: 4, title: "Scenery 4"),
            DataItem(group: .Scenery, number: 5, title: "Scenery 5"),
            DataItem(group: .Scenery, number: 6, title: "Scenery 6"),

            DataItem(group: .Iceland, number: 1, title: "Iceland 1"),
            DataItem(group: .Iceland, number: 2, title: "Iceland 2"),
            DataItem(group: .Iceland, number: 3, title: "Iceland 3"),
            DataItem(group: .Iceland, number: 4, title: "Iceland 4"),
            DataItem(group: .Iceland, number: 5, title: "Iceland 5"),
            DataItem(group: .Iceland, number: 6, title: "Iceland 6"),
            DataItem(group: .Iceland, number: 7, title: "Iceland 7"),
            DataItem(group: .Iceland, number: 8, title: "Iceland 8"),

            DataItem(group: .Lola, number: 1, title: "Roll Over"),
            DataItem(group: .Lola, number: 2, title: "Tug-of-war"),
            DataItem(group: .Lola, number: 3, title: "Face Off"),
            DataItem(group: .Lola, number: 4, title: "Favorite Toy"),

            DataItem(group: .Baby, number: 1, title: "Baby 1"),
            DataItem(group: .Baby, number: 2, title: "Baby 2"),
            DataItem(group: .Baby, number: 3, title: "Baby 3"),
            DataItem(group: .Baby, number: 4, title: "Baby 4"),
            DataItem(group: .Baby, number: 5, title: "Baby 5"),
            DataItem(group: .Baby, number: 6, title: "Baby 6"),
            DataItem(group: .Baby, number: 7, title: "Baby 7"),
            DataItem(group: .Baby, number: 8, title: "Baby 8")
        ]
    }()
    
    /// A static sample set of `DataItem`s to show on the Top Shelf with inset style.
    static var sampleItemsForInsetTopShelfItems: [DataItem] = {
        // Limit the items we show to the first 4 items in the `Lola` group.
        let lolaItems = DataItem.sampleItems.filter { $0.group == .Lola }
        return Array(lolaItems.prefix(4))
    }()
    
    /// A static sample set of `DataItem`s to show on the Top Shelf with sectioned style.
    static var sampleItemsForSectionedTopShelfItems: [[DataItem]] = {
        /*
            Limit the items we show to the first 2 items in the `Lola` and
            `Iceland` groups.
        */
        return [DataItem.Group.Lola, DataItem.Group.Iceland].map { group in
            let currentGroupItems = DataItem.sampleItems.filter { $0.group == group }
            return Array(currentGroupItems.prefix(2))
        }
    }()
}
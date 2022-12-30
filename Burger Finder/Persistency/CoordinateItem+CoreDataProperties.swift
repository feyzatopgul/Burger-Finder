//
//  CoordinateItem+CoreDataProperties.swift
//  Burger Finder
//
//  Created by fyz on 12/29/22.
//

import Foundation
import CoreData

@objc(CoordinateItem)
public class CoordinateItem: NSManagedObject {
    
}

extension CoordinateItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoordinateItem> {
        return NSFetchRequest<CoordinateItem>(entityName: "CoordinateItem")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
}

extension CoordinateItem : Identifiable {

}


//
//  LocationItem+CoreDataProperties.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/29/22.
//

import Foundation
import CoreData

@objc(LocationItem)
public class LocationItem: NSManagedObject {
    
}

extension LocationItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationItem> {
        return NSFetchRequest<LocationItem>(entityName: "LocationItem")
    }

    @NSManaged public var formattedAddress: String?
    @NSManaged public var locality: String?
}

extension LocationItem : Identifiable {

}

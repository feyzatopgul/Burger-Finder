//
//  LocationItem+CoreDataProperties.swift
//  Burger Finder
//
//  Created by fyz on 12/29/22.
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
    @NSManaged public var country: String?
    @NSManaged public var postcode: String?
    @NSManaged public var region: String?
}

extension LocationItem : Identifiable {

}

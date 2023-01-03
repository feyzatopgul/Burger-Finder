//
//  PlaceItem+CoreDataProperties.swift
//  Burger Finder
//
//  Created by fyz on 12/29/22.
//

import Foundation
import CoreData

@objc(PlaceItem)
public class PlaceItem: NSManagedObject {
    
}

extension PlaceItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaceItem> {
        return NSFetchRequest<PlaceItem>(entityName: "PlaceItem")
    }

    @NSManaged public var id: String
    @NSManaged public var distance: Int32
    @NSManaged public var hours: HoursItem
    //@NSManaged public var geocodes: GeocodesItem
    @NSManaged public var coordinates: CoordinateItem
    @NSManaged public var location: LocationItem?
    @NSManaged public var name: String
    @NSManaged public var rating: Double
    @NSManaged public var phoneNumber: String?
    @NSManaged public var website: String?
    @NSManaged public var photos: NSSet?
    @NSManaged public var price: Int32
}

extension PlaceItem: Identifiable {
    
}

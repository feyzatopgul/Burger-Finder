//
//  HoursItem+CoreDataProperties.swift
//  Burger Finder
//
//  Created by fyz on 12/29/22.
//

import Foundation
import CoreData

@objc(HoursItem)
public class HoursItem: NSManagedObject {
    
}

extension HoursItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HoursItem> {
        return NSFetchRequest<HoursItem>(entityName: "HoursItem")
    }

    @NSManaged public var display: String?
    @NSManaged public var openNow: Bool
}

extension HoursItem : Identifiable {

}

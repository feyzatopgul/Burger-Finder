//
//  PhotoItem+CoreDataProperties.swift
//  Burger Finder
//
//  Created by fyz on 12/29/22.
//

import Foundation
import CoreData

@objc(PhotoItem)
public class PhotoItem: NSManagedObject {
    
}
extension PhotoItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoItem> {
        return NSFetchRequest<PhotoItem>(entityName: "PhotoItem")
    }
    @NSManaged public var id: String
    @NSManaged public var prefix: String
    @NSManaged public var suffix: String
    @NSManaged public var width: Int32
    @NSManaged public var height: Int32
}

extension PhotoItem : Identifiable {

}

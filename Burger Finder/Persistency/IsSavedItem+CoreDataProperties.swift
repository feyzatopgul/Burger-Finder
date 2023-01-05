//
//  CoreDataManager+isSavedItem.swift
//  Burger Finder
//
//  Created by fyz on 1/5/23.
//

import Foundation
import CoreData

@objc(IsSavedItem)
public class IsSavedItem: NSManagedObject {
    
}

extension IsSavedItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<IsSavedItem> {
        return NSFetchRequest<IsSavedItem>(entityName: "IsSavedItem")
    }
    @NSManaged public var id: String
    @NSManaged public var isSaved: Bool
}

extension IsSavedItem : Identifiable {

}

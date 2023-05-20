//
//  Garland+CoreDataProperties.swift
//  
//
//  Created by macOS on 19/05/23.
//
//

import Foundation
import CoreData


extension Garland {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Garland> {
        return NSFetchRequest<Garland>(entityName: "Garland")
    }

    @NSManaged public var date: Date?
    @NSManaged public var note: String?
    @NSManaged public var reminder: Int16
    @NSManaged public var startValue: Int16
    @NSManaged public var targetValue: Int16
    @NSManaged public var title: String?

}

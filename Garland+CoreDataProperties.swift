//
//  Garland+CoreDataProperties.swift
//  PrayerGod
//
//  Created by iMac on 29/06/23.
//
//

import Foundation
import CoreData


extension Garland {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Garland> {
        return NSFetchRequest<Garland>(entityName: "Garland")
    }

    @NSManaged public var date: Date?
    @NSManaged public var isActive: Bool
    @NSManaged public var note: String?
    @NSManaged public var reminder: Int32
    @NSManaged public var startValue: Int32
    @NSManaged public var targetValue: Int32
    @NSManaged public var title: String?

}

extension Garland : Identifiable {

}

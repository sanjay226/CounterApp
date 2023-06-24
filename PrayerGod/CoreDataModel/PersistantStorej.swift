//
//  PersistantStorej.swift
//  PrayerGod
//
//  Created by macOS on 18/04/23.
//

import Foundation
import CoreData

final class PersistantStorej {
    private init(){}
    static var shared = PersistantStorej()
  lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "CoreDataModel")
                container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
  lazy var context = persistentContainer.viewContext
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
                } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    
}

//
//  CoreDataCrudOpretion.swift
//  PrayerGod
//
//  Created by macOS on 18/04/23.
//

import Foundation
import CoreData
import UIKit

class databasehelper{
    static let sharaintance = databasehelper()
    let context = PersistantStorej.shared.persistentContainer.viewContext
    func dataSave(object: TaskModel){
        let user = NSEntityDescription.insertNewObject(forEntityName: "Garland" , into: context) as? Garland
        user?.title = object.title
        user?.reminder = Int32(object.reminder ?? 0)
        user?.startValue = Int32(object.startValue ?? 0)
        user?.note = object.note
        user?.targetValue = Int32(object.targetValue ?? 0)
        user?.date = object.date ?? Date()
        user?.isActive = object.isActive ?? false
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func saveItems(){
        do{
            try context.save()
        }catch{
            print("Error Saving item with \(error)")
        }
    }
    
    func getdata() -> [Garland]{
        var fetchdata = [Garland]()
        let fetchreqast = NSFetchRequest<NSManagedObject>(entityName: "Garland")
        do{
            fetchdata = try context.fetch(fetchreqast) as! [Garland]
        }catch
        {
            print(error.localizedDescription)
        }
        return fetchdata
    }
    // func allDelit( objUser: Garland) -> [Garland]{
    func allDelit( _ index : Int, objUser: Garland) -> [Garland]{
        context.delete(objUser)
        do{
            try context.save()
        }catch
        {
            print(error.localizedDescription)
        }
        return databasehelper.sharaintance.getdata()
    }
 }

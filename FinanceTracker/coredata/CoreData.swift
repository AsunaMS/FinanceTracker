//
//  CoreData.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 03/02/2021.
//

import CoreData
class CoreData {
    
    // shared referece for our CoreData static object
    public static let shared:CoreData = CoreData()
    public static let sharedContext = shared.persistentContainer.viewContext
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinanceTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // Deletes all users -> used for debugging reasons
    func deleteAll() {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "CorePerson")
        guard let people = try? context.fetch(request)else{return}
        
        for person in people {
            context.delete(person)
        }
        saveContext()
        
    }
    //  get the current user from device storage if exists
    func getUser()-> CorePerson?{
        let context = persistentContainer.viewContext
        //1) fetch request
        let request: NSFetchRequest<CorePerson> = CorePerson.fetchRequest()
        
        //2) execute:
        var pool:[CorePerson] = []
        if let people = try? context.fetch(request){
           pool = people
        }
        if pool.count > 1 {
            print("Found more then one user on a single user app")
            return pool[0]
        }
        if pool.count  < 1 {
           return nil
        }
        return pool[0]
    }
    // save the user to core data -> used if other db functions arise
    func saveUser(person:CorePerson) {
        saveContext()
    }
    // save the whole core data context
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    private init() {}
}

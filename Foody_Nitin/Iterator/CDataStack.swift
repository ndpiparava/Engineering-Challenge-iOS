//
//  CDataStack.swift
//  Foody
//
//  Created by npiprava on 7/3/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import Foundation
import CoreData


class CDataStack {
    
    let context: NSManagedObjectContext
    let psc:NSPersistentStoreCoordinator
    let model: NSManagedObjectModel
    let store: NSPersistentStore?
    
    
    func applicationDocumentsDirectory() -> NSURL {
        let fileManger = NSFileManager.defaultManager()
        let urls = fileManger.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as! [NSURL]
        
        return urls[0]
    }
    
     init () {
        
        //super.init()
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("Foody", withExtension: "momd")
        model = NSManagedObjectModel(contentsOfURL: modelURL!)!
        
        psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        context = NSManagedObjectContext()
        //context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator  = psc
        
        
        let fileManger = NSFileManager.defaultManager()
        let urls = fileManger.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as! [NSURL]
        let documentURL = urls[0]
        let storeURL = documentURL.URLByAppendingPathComponent("Foody")
        let options = [NSMigratePersistentStoresAutomaticallyOption: true]
        
        var error: NSError? = nil
        self.store = psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options, error: &error)
        
        if store == nil  {
            println("Error adding persistent store: \(error)")
            abort()
        }
    }
    
    func saveContext() -> Bool  {
        
        var error: NSError? = nil
        if context.hasChanges && !context.save(&error) {
            println("Could not save: \(error) \(error?.userInfo)")
            return false
        }
        
        return true
        
    }
}

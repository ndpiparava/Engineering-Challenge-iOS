//
//  AddDataManager.swift
//  Foody
//
//  Created by npiprava on 7/7/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit
import CoreData

class AddDataManager: NSObject {
    
    var cdataStack =  CDataStack()
    var managedContext: NSManagedObjectContext!
    
    func addMeal(entry : Foods) {
        
        TICK()
        let entity_Food = NSEntityDescription.insertNewObjectForEntityForName("Entity_Food", inManagedObjectContext: self.cdataStack.context) as! Entity_Food
        
        entity_Food.name = entry.foodName
        var importantlist = entity_Food.relImportant.mutableCopy() as! NSMutableOrderedSet
        
        for importants in entry.foodImportants {
            
            let important = importants as struct_important
            let entity_Important = NSEntityDescription.insertNewObjectForEntityForName("Entity_Important", inManagedObjectContext: self.cdataStack.context) as! Entity_Important
            entity_Important.important_Name = important.importantName
            entity_Important.unit = important.unit
            entity_Important.value = important.value
            
            importantlist.addObject(entity_Important)
        }
        
        entity_Food.relImportant = importantlist.copy() as! NSOrderedSet
        self.cdataStack.saveContext()
        TOCK()// Print CoreData Save operatin Time
        
        let alert:UIAlertView = UIAlertView(title: "Save Meal", message: "Meal sucessfully added !!! ", delegate: self, cancelButtonTitle: "Ok")
        alert.show()
    }

   
}

//
//  Entity_Important.swift
//  Foody
//
//  Created by npiprava on 7/7/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import Foundation
import CoreData

class Entity_Important: NSManagedObject {

    @NSManaged var important_Name: String
    @NSManaged var unit: String
    @NSManaged var value: NSNumber
    @NSManaged var relFood: Entity_Food

}

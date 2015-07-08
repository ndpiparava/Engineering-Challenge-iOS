//
//  Entity_Food.swift
//  Foody
//
//  Created by npiprava on 7/7/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import Foundation
import CoreData

class Entity_Food: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var relExtra: NSSet
    @NSManaged var relImportant: NSOrderedSet

}

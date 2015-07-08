//
//  AddInteractor.swift
//  Foody
//
//  Created by npiprava on 7/7/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit
import CoreData

class AddInteractor: NSObject {
    
    var addDataManager : AddDataManager?

    func saveFoodtoDB(index:Int, foodSummaryDataSource: NSMutableArray) {
        let food  = foodSummaryDataSource.objectAtIndex(index) as! Foods
        addDataManager?.addMeal(food)
    }
    
}

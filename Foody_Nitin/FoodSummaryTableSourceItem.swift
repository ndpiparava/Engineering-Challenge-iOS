//
//  FoodSummaryTableSourceItem.swift
//  Foody
//
//  Created by npiprava on 7/3/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit
import Foundation
import CoreData

enum CellType {
    
    case FoodCellTypeSummary
    case FoodCellTypeDetails
   
}
typealias FoodCellType = CellType;

class FoodSummaryTableSourceItem : NSObject {
    
    var foodCellType : FoodCellType!
    let parentIndex: NSInteger!
    let childrenCount: NSInteger!
    
    init (_foodCellType: FoodCellType, _parentIndex: NSInteger, _childrenCount : NSInteger) {
        
        self.foodCellType = _foodCellType
        self.parentIndex = _parentIndex
        self.childrenCount = _childrenCount
    }
}

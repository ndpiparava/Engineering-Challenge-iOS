//
//  SearchModuleInterface.swift
//  Foody
//
//  Created by npiprava on 7/7/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit

protocol SearchModuleInterface {
    func searchFood(foodName : String)
    func addMeal(index: Int, DataSource: NSMutableArray)
}

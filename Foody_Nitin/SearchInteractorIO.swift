//
//  SearchInteractorIO.swift
//  Foody
//
//  Created by npiprava on 7/7/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit

protocol SearchInteractorInput {
    func searchFood(searchString:String)
}


protocol SearchInteractorOutPut {
    
    func searchedFoods(upcomingFoods: NSMutableArray)
    func updateTable(foodObject: Foods)
}

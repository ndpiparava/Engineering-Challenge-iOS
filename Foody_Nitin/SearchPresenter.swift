//
//  SearchPresenter.swift
//  Foody
//
//  Created by npiprava on 7/7/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit

@objc
protocol SearchPresenterDelegate {
    
    func updateDataSource(foodDataSource: NSMutableArray)
}

class SearchPresenter: NSObject,SearchModuleInterface,SearchInteractorOutPut{
   
    var delegate: SearchPresenterDelegate?
    var searchViewInterface : SearchViewInterface?
    var searchInteractor : SearchInteractor?
    var addInteractor: AddInteractor?
    var searchWireFrame : SearchWireFrame?
    
    
    
    func searchedFoods(upcomingFoods: NSMutableArray) {
        
        dispatch_async(dispatch_get_main_queue(), {
             //self.searchViewInterface!.updateDataSource(upcomingFoods)
        })
    }
    
    func searchFood(foodName: String)  {
        
        //self.searchInteractor = SearchInteractor()
        self.searchInteractor!.searchFood(foodName)
    }
    
    func addMeal(index: Int, DataSource: NSMutableArray) {
            addInteractor?.saveFoodtoDB(index, foodSummaryDataSource: DataSource)
    }
    
    func updateTable(foodObject: Foods) {
         self.searchViewInterface!.updateTable(foodObject)
    }
}

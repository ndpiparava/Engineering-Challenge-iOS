//
//  SearchInteractor.swift
//  Foody
//
//  Created by npiprava on 7/7/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit


class SearchInteractor: NSObject,SearchInteractorInput,servicesDelegate{
   
    var output :  SearchInteractorOutPut?
    //var foodSummaryDataSource: NSMutableArray!
    
    func searchFood(searchString:String)  {
        
        let service : Services = Services()
        service.delegate = self
        service.searchFoods(searchString, suceess: { (loadDataSource) -> Void in
            //self.output = SearchInteractorOutPut()
            self.output?.searchedFoods(loadDataSource)
        })
    }
    
    func updateTable(foodObject: Foods) {
        
        self.output?.updateTable(foodObject)
    }
}

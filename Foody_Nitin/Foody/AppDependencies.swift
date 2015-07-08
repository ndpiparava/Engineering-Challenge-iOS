//
//  AppDependencies.swift
//  Foody
//
//  Created by npiprava on 7/8/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit

class AppDependencies {
    
    
    var searchWireFrame = SearchWireFrame()
    
    init(){
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        searchWireFrame.presentFoodInterfaceFromWindow(window)
    }
    
    func configureDependencies() {

        let rootWireFrame = RootWireframe()
        
        
        let searchPresenter = SearchPresenter()
        let addDataManager = AddDataManager()
        let searchInteractor = SearchInteractor()
        
        let addInteractor = AddInteractor()
        
        searchInteractor.output = searchPresenter
        
        searchPresenter.searchInteractor = searchInteractor
        searchPresenter.searchWireFrame = searchWireFrame
        
        searchWireFrame.searchPresenter = searchPresenter
        searchWireFrame.rootWireframe = rootWireFrame
        
        searchPresenter.addInteractor = addInteractor
        addInteractor.addDataManager = addDataManager
        
    }
   
}

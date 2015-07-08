//
//  SearchViewFrame.swift
//  Foody
//
//  Created by npiprava on 7/8/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit
import Foundation

let FoodViewControllerIdentifer = "FoodViewControllerIdentifer"

class SearchWireFrame: NSObject {
   
    var searchPresenter: SearchPresenter?
    var rootWireframe : RootWireframe?
    var foodViewController : FoodViewController?
    
    func presentFoodInterfaceFromWindow(window: UIWindow) {
        let viewController = FoodViewControllerFromStoryboard()
        viewController.eventHandler = searchPresenter
        foodViewController = viewController
        searchPresenter!.searchViewInterface = viewController
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
   
    
    func FoodViewControllerFromStoryboard() -> FoodViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(FoodViewControllerIdentifer) as! FoodViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
}

//
//  Foody_Constant.swift
//  Foody
//
//  Created by npiprava on 7/3/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

//http://test.holmusk.com/food/search?q=food_search_query"

import UIKit
import Foundation

//Define Globla COnstants
let skipperTintcolor = UIColor(red: 26/255, green: 162/255, blue: 120/255, alpha: 1.0)
let baseService = "http://test.holmusk.com/food/search"
let screenSize: CGRect = UIScreen.mainScreen().bounds
let graphWidth  = Int(screenSize.width - 80)

class Foody_Constant: NSObject {
    
}


var startTime = NSDate()
func TICK(){ startTime =  NSDate() }
func TOCK(function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__){
    println("\(function) Time: \(startTime.timeIntervalSinceNow)\nLine:\(line) File: \(file)")
}


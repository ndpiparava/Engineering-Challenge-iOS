//
//  Services.swift
//  Foody
//
//  Created by npiprava on 7/3/15.
//  Copyright (c) Foody,LLC. All rights reserved.
//

import CoreData

@objc
protocol servicesDelegate {
    
    func updateTable(foodObject: Foods)
}

class Services: NSObject {
    
    //data Operators
    var cdataStack =  CDataStack()
    var delegate :servicesDelegate?
    var managedContext: NSManagedObjectContext!

    //get requested Search Data
    func searchFoods (foodSearch: String, suceess:((loadDataSource:NSMutableArray!) -> Void)){
        
        var foodDatsSource: NSMutableArray? = NSMutableArray()
        let url = URLFactory.searchFood(foodSearch)
        JSONService.proceedGetFood(url,suceess: {(foodData) -> Void in
            
            //Parsing
            let json = JSON(data: foodData)
            let foods = json.arrayValue! 
            
            for fooditem in foods {
                
                var food = Foods()
                food.foodName = fooditem["name"].stringValue!
                
                let portions = fooditem["portions"].arrayValue!
                food.foodName = fooditem["name"].stringValue!
                for nutrients in portions {
                    let importants = nutrients["nutrients"]["important"].dictionaryValue!
                    let keys = importants.keys.array
                    for key in keys {
                        
                        if let important = importants[key]!.dictionaryValue {
                            //key == "monounsaturated"
                            if (key == "polyunsaturated" || key == "saturated" || key == "total_fats" || key == "sugar" || key == "total_carbs" || key == "protein") {
                                let imp = struct_important(struct_importantName: key, struct_unit: important["unit"]!.stringValue!, struct_value: important["value"]!.floatValue!);
                                
                                food.foodImportants.append(imp)
                            }
                            
                            if key == "sugar" {
                                if let important = importants[key]!.dictionaryValue {
                                    if  important["value"]!.floatValue! > 1 {
                                        food.isSugerFree = false
                                    }
                                }
                            }
                            
                        }
                    }
                 // Update table for single object and dont wait for whole object to parse
                    dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
                        self.delegate?.updateTable(food)
                    }
                
                }
            }
            //suceess(loadDataSource: foodDatsSource)
        })
    }
}

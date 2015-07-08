//
//  Services.swift
//  MagixList
//
//  Created by npiprava on 3/11/15.
//  Copyright (c) MagixList,LLC. All rights reserved.
//



import CoreData


class Services: NSObject {
    
    //data Operators
    var cdataStack =  CDataStack()
    var managedContext: NSManagedObjectContext!
    
   
//    //Mark - getListData
//    class func proceedGetFood(url: NSURL, suceess:((listData:NSData!) -> Void)) {
//        
//        loadDataFromURL(url, completion: {(data,error) -> Void in
//            if let urlData = data {
//                suceess(listData: urlData)
//            }
//        })
//    }
    
    func getOffers(foodSearch: String) -> NSMutableArray {
        
        var foodDatsSource: NSMutableArray? = NSMutableArray()
        let url = URLFactory.searchFood(foodSearch)
        JSONService.proceedGetFood(url,suceess: {(foodData) -> Void in
            
            //Parsing
            let json = JSON(data: foodData)
            let foods = json.arrayValue!
            for fooditem in foods {
                
                let food = NSEntityDescription.insertNewObjectForEntityForName("Food", inManagedObjectContext: self.cdataStack.context) as! Food
                let total_Carbs = NSEntityDescription.insertNewObjectForEntityForName("Total_Carbs", inManagedObjectContext: self.cdataStack.context) as! Total_Carbs
                let soduim = NSEntityDescription.insertNewObjectForEntityForName("Soduim", inManagedObjectContext: self.cdataStack.context) as! Soduim
                let calories = NSEntityDescription.insertNewObjectForEntityForName("Calories", inManagedObjectContext: self.cdataStack.context) as! Calories
                let monounsaturated = NSEntityDescription.insertNewObjectForEntityForName("Monounsaturated", inManagedObjectContext: self.cdataStack.context) as! Monounsaturated
                let polyunsaturated = NSEntityDescription.insertNewObjectForEntityForName("Polyunsaturated", inManagedObjectContext: self.cdataStack.context) as! Polyunsaturated
                let cholesterol = NSEntityDescription.insertNewObjectForEntityForName("Cholesterol", inManagedObjectContext: self.cdataStack.context) as! Cholesterol
                let protein = NSEntityDescription.insertNewObjectForEntityForName("Protein", inManagedObjectContext: self.cdataStack.context) as! Protein
                let dietary_fibre = NSEntityDescription.insertNewObjectForEntityForName("Dietary_fibre", inManagedObjectContext: self.cdataStack.context) as! Dietary_fibre
                let total_fats = NSEntityDescription.insertNewObjectForEntityForName("Total_fats", inManagedObjectContext: self.cdataStack.context) as! Total_fats
                let trans = NSEntityDescription.insertNewObjectForEntityForName("Trans", inManagedObjectContext: self.cdataStack.context) as! Trans
                let potassium = NSEntityDescription.insertNewObjectForEntityForName("Potassium", inManagedObjectContext: self.cdataStack.context) as! Potassium
                let saturated = NSEntityDescription.insertNewObjectForEntityForName("Saturated", inManagedObjectContext: self.cdataStack.context) as! Saturated
                
                let portions = fooditem["portions"].arrayValue!
                food.name = fooditem["name"].stringValue!
                for nutrients in portions {
                    let importants = nutrients["nutrients"]["important"].dictionaryValue!
                    let keys = importants.keys.array
                    for key in keys {
                        
                        if let important = importants[key]!.dictionaryValue {
                            
                            switch key {
                                
                            case "total_Carbs" :
                                total_Carbs.value = important["value"]!.floatValue!
                                total_Carbs.unit = important["unit"]!.stringValue!
                                food.relTotal_Carbs = total_Carbs
                            case "polyunsaturated" :
                                polyunsaturated.value = important["value"]!.floatValue!
                                polyunsaturated.unit = important["unit"]!.stringValue!
                                food.relPolyunsaturated = polyunsaturated
                            case "protein" :
                                protein.value = important["value"]!.floatValue!
                                protein.unit = important["unit"]!.stringValue!
                                food.relProtein = protein
                            case "trans" :
                                trans.value = important["value"]!.floatValue!
                                trans.unit = important["unit"]!.stringValue!
                                food.relTrans = trans
                            case "monounsaturated" :
                                monounsaturated.value = important["value"]!.floatValue!
                                monounsaturated.unit = important["unit"]!.stringValue!
                                food.relMonounsaturated = monounsaturated
                            case "potassium" :
                                potassium.value = important["value"]!.floatValue!
                                potassium.unit = important["unit"]!.stringValue!
                                food.relPotassium = potassium
                            case "saturated" :
                                saturated.value = important["value"]!.floatValue!
                                saturated.unit = important["unit"]!.stringValue!
                                food.relSaturated = saturated
                            case "dietary_fibre" :
                                dietary_fibre.value = important["value"]!.floatValue!
                                dietary_fibre.unit = important["unit"]!.stringValue!
                                food.relDietary_fibre = dietary_fibre
                            case "total_fats" :
                                total_fats.value = important["value"]!.floatValue!
                                total_fats.unit = important["unit"]!.stringValue!
                                food.relTotal_fats = total_fats
                            case "cholesterol" :
                                cholesterol.value = important["value"]!.floatValue!
                                cholesterol.unit = important["unit"]!.stringValue!
                                food.relCholesterol = cholesterol
                            case "calories" :
                                calories.value = important["value"]!.floatValue!
                                calories.unit = important["unit"]!.stringValue!
                                food.relCalories = calories
                                
                            default:
                                break
                                
                                
                            }
                            
                        }
                        
                    }
                    
                    println("\(food.name)")
                    println("\(food.relCalories.value)")
                    foodDatsSource!.addObject(food)
                    
                }
            }

            
        })
        
        return foodDatsSource!
    }

}

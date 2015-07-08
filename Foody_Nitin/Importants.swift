//
//  Importants.swift
//  Foody
//
//  Created by npiprava on 7/5/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit

struct struct_important  {
    var importantName : String
    var unit:String
    var value: Float
    
    init(struct_importantName:String, struct_unit:String, struct_value:Float) {
        self.unit = struct_unit
        self.value = struct_value
        self.importantName = struct_importantName
    }
}
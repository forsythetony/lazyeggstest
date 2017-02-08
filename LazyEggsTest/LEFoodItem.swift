//
//  LEFoodItem.swift
//  LazyEggsTest
//
//  Created by Tony Forsythe on 2/7/17.
//  Copyright © 2017 self.edu. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LEFoodItem {
    var uuid            : String = ""
    var name            : String = ""
    var description     : String = ""
    var basePrice       : Double = 0.0
    //lazy var defaultMods = [LEFoodItemMod]()
    //lazy var availableMods = [LEFoodItemMod]()
}

/*
  Constructors
*/
extension LEFoodItem {
    
    static func buildWithSnapshot( snapshot : FIRDataSnapshot ) -> LEFoodItem? {
        
        guard let snapData = snapshot.value as? Dictionary<String, AnyObject> else { return nil }
        
        let retValue = LEFoodItem()
        
        if let uuid = snapData[Keys.FoodItem.uuid] as? String {
            retValue.uuid = uuid
        }
        else {
            return nil
        }
        if let name = snapData[Keys.FoodItem.name] as? String {
            retValue.name = name
        }
        else {
            return nil
        }
        if let desc = snapData[Keys.FoodItem.description] as? String {
            retValue.description = desc
        }
        else {
            return nil
        }
        if let basePrice = snapData[Keys.FoodItem.basePrice] as? Double {
            retValue.basePrice = basePrice
        }
        else {
            return nil
        }
        
        return retValue
    }
}

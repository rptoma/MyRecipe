//
//  Ingredient.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 02/05/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import Foundation

class Ingredient: CustomStringConvertible {
    public var name: String?
    public var quantity: Double?
    public var unit: String?
    
    public var description: String {
        let name = self.name ?? "no name"
        let quantity = self.quantity ?? -1.0
        let unit = self.unit ?? "no unit"
        let ret = name + "\n" + String(quantity) + "\n" + unit
        return ret
    }
    
    public init(fromJsonDictionary dictionary: [String: AnyObject]) {
        name = dictionary["name"] as? String
        quantity = dictionary["quantity"] as? Double
        unit = dictionary["unit"] as? String
    }
}

//
//  RecipeDescription.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 02/05/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import Foundation

class RecipeDescription: CustomStringConvertible {
    public var name: String?
    public var images = [String]()
    public var duration: Int?
    public var recipeDescription: String?
    public var ingredients = [Ingredient]()
    
    public var description: String {
        let name = self.name ?? "No name"
        let images = self.images.description
        let duration = self.duration ?? -1
        let recipeDescription = self.recipeDescription ?? "no description"
        let ingredients = self.ingredients.description
        
        var ret = name + "\n" + images + "\n" + String(duration)
        ret = "\n" + ret + recipeDescription + "\n" + ingredients
        
        return ret
    }
    
    public init(fromJson dictionary: [String: AnyObject]) {
        name = dictionary["name"] as? String
        duration = dictionary["duration"] as? Int
        if let imagesArray = dictionary["images"] as? [String] {
            images = imagesArray
        }
        recipeDescription = dictionary["description"] as? String
        
        if let ingredientsArray = dictionary["ingredients"] as? [AnyObject] {
            for ingredient in ingredientsArray {
                if let ingredient = ingredient as? [String: AnyObject] {
                    ingredients.append(Ingredient(fromJsonDictionary: ingredient))
                }
            }
        }
    }
}

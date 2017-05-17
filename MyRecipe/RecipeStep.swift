//
//  RecipeSteps.swift
//  MyRecipe
//
//  Created by Alexandru Radu on 21/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import Foundation

class RecipeStep: CustomStringConvertible {
    
    public var task: String?
    public var details: String?

    
    public var description: String {
        
        let task = self.task ?? "no name"
        let details = self.details ?? "no details"
        
        return task + "\n" + details
    }
    
    public init(fromJson dictionary: [String: AnyObject]) {
    
        task = dictionary["task"] as? String
        details = dictionary["description"] as? String
    
    }
}

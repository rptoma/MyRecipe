//
//  Base.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 17/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import Foundation

class Base {
    static var DEFAULT_IMAGE_PATH: String! {
        get {
            return "default_image.jpg"
        }
    }
    
    static var RECIPES_LIST_BASE_URL: String! {
        get {
            return "https://private-anon-c6e411992b-myrecipes1.apiary-mock.com/api/v1/recipes?page="
        }
    }
}
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
    
    static var RECIPES_STEPS_LIST_BASE_URL: String! {
        get {
            return "https://private-anon-c6e411992b-myrecipes1.apiary-mock.com/api/v1/steps/"
        }
    }
    
    static var RECIPES_SEARCH_LIST_BASE_URL: String! {
        get {
            return "https://private-anon-c6e411992b-myrecipes1.apiary-mock.com/api/v1/recipes"
        }
    }
    
    static var RECIPE_PREVIEW_BASE_URL: String! {
        get {
            return "https://private-anon-c6e411992b-myrecipes1.apiary-mock.com/api/v1/previews/"
        }
    }
    
    static var NUMBER_OF_ROWS_BEFORE_UPDATE: Int! {
        get {
            return 5
        }
    }
}

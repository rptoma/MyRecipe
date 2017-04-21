//
//  RequestManager.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 16/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher

class RequestManager {
    
    private let recipeListBaseURL = Base.RECIPES_LIST_BASE_URL!
    private let recipeStepsListBaseURL = Base.RECIPES_STEPS_LIST_BASE_URL
    private let recipesSearchListBaseURL = Base.RECIPES_SEARCH_LIST_BASE_URL
    
    public func requestRecipes(forPage page: Int, completionHandler: @escaping (_ result: [Recipe]?, _ error: String?) ->()) {
        
        let requestURL = recipeListBaseURL + String(page)
        
        Alamofire.request(requestURL).validate().responseJSON { response in
            
            var result: [Recipe]?
            var error: String?
            
            switch response.result {

            case .success(let data):
                var recipes = [Recipe]()
                let responeJson = data as? [String: AnyObject]
                let recipesJson = responeJson?["recipes"] as? [AnyObject]
                
                if let recipesJson = recipesJson {
                    for recipeJson in recipesJson {
                        if let recipeJson = recipeJson as? [String: AnyObject] {
                            recipes.append(Recipe(fromJson: recipeJson))
                        }
                    }
                }
                
                result = recipes
                
            case .failure(let errorAlamo):
                var message : String!
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 404:
                        message = "404 error"
                    default:
                        break
                    }
                } else {
                    message = errorAlamo.localizedDescription
                }
                error = message
            }
            
            completionHandler(result, error)
        }
    }
    
    public func requestRecipeSteps(forRecipe recipe: String, completionHandler: @escaping (_ result: [RecipeStep]?, _ error: String?) ->()) {
        
        let requestURL = recipeStepsListBaseURL! + recipe
        
        Alamofire.request(requestURL).validate().responseJSON { response in
            
            var result: [RecipeStep]?
            var error: String?
            
            switch response.result {
                
            case .success(let data):
                var recipeSteps = [RecipeStep]()
                let responseJSON = data as? [String: AnyObject]
                let recipeStepsJSON = responseJSON?["steps"] as? [AnyObject]
                
                if let recipeStepsJSON = recipeStepsJSON {
                    for recipeStepJSON in recipeStepsJSON{
                        if let recipeStepJSON = recipeStepJSON as? [String: AnyObject] {
                            recipeSteps.append(RecipeStep(fromJson: recipeStepJSON))
                        }
                    }
                }
                
                result = recipeSteps
                
            case .failure(let errorAlamo):
                var message : String!
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 404:
                        message = "404 error"
                    default:
                        break
                    }
                } else {
                    message = errorAlamo.localizedDescription
                }
                error = message
            }
            
            completionHandler(result, error)
                
            }
            
        }
    
        
    
    
    public func requestRecipes(forQuery query: String, forPage page: Int, completionHandler: @escaping (_ result: [Recipe]?, _ error: String?) ->()) {
        
        let parameters: Parameters = [
            "page": page,
            "keywords": query
        ]
        
        Alamofire.request(Base.RECIPES_SEARCH_LIST_BASE_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            var result: [Recipe]?
            var error: String?
            
            switch response.result {
                
            case .success(let data):
                var recipes = [Recipe]()
                let responeJson = data as? [String: AnyObject]
                let recipesJson = responeJson?["recipes"] as? [AnyObject]
                
                if let recipesJson = recipesJson {
                    for recipeJson in recipesJson {
                        if let recipeJson = recipeJson as? [String: AnyObject] {
                            recipes.append(Recipe(fromJson: recipeJson))
                        }
                    }
                }
                
                result = recipes
                
            case .failure(let errorAlamo):
                var message : String!
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 404:
                        message = "404 error"
                    default:
                        break
                    }
                } else {
                    message = errorAlamo.localizedDescription
                }
                error = message
            }
            
            completionHandler(result, error)
        }
    }

}

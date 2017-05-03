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
    
    public func requestRecipeDesctiption(forUID uid: String, completionHandler: @escaping (_ result: RecipeDescription?, _ error: String?) ->()) {
        
        let requestURL = Base.RECIPE_DESCRIPTION_BASE_URL + uid
        
        Alamofire.request(requestURL).validate().responseJSON { response in
            
            var result: RecipeDescription?
            var error: String?
            
            switch response.result {
                
            case .success(let data):
                let responseJson = data as? [String: AnyObject]
                
                if let responseJson = responseJson {
                    result = RecipeDescription(fromJson: responseJson)
                }
                
            case .failure(let errorAlamo):
                var message : String!
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 404:
                        message = "404 error"
                    default:
                        message = errorAlamo.localizedDescription
                    }
                } else {
                    message = errorAlamo.localizedDescription
                }
                error = message
            }
            
            completionHandler(result, error)
        }
    }
    
    public func requestRecipePreview(forUID uid: String, completionHandler: @escaping (_ result: Recipe?, _ error: String?) -> ()) {
        let requestURL = Base.RECIPE_PREVIEW_BASE_URL + uid
        
        Alamofire.request(requestURL).validate().responseJSON { response in
            
            var result: Recipe?
            var error: String?
            
            switch response.result {
                
            case .success(let data):
                let responseJson = data as? [String: AnyObject]
                
                if let responseJson = responseJson {
                    result = Recipe(fromJson: responseJson)
                }
                
            case .failure(let errorAlamo):
                var message : String!
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 404:
                        message = "404 error"
                    default:
                        message = errorAlamo.localizedDescription
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

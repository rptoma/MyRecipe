//
//  RequestManager.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 16/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    
    private let recipeListBaseURL = Base.RECIPES_LIST_BASE_URL!
    
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
    
    public func requestImage(for url: String, completionHandler: @escaping (UIImage?) -> ()) {
        var image: UIImage?
        Alamofire.request(url).validate().response { (response) in
            if let data = response.data {
                image =  UIImage(data: data)
                completionHandler(image)
            }
        }
    }
}

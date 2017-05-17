//
//  DetailView.swift
//  MyRecipe
//
//  Created by Alexandru Radu on 16/05/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import Foundation

class DetailView: UIView {
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
  
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var durationTextView: UITextView!
    
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    func hideLabels(){
        descriptionLabel.isHidden = true
        durationLabel.isHidden = true
        ingredientsLabel.isHidden = true
    }
    
    
    func revealLabels(){
        
        descriptionLabel.isHidden = false
        durationLabel.isHidden = false
        ingredientsLabel.isHidden = false
    }
    
    func updateDetailViewObjects(recipeDescription:RecipeDescription){
        DispatchQueue.main.async {
            self.descriptionTextView.text = recipeDescription.recipeDescription
            self.durationTextView.text = TimeConverter.getTime(from: recipeDescription.duration!)
            var ingredientsList:String = String()
            for ingredient in recipeDescription.ingredients{
                ingredientsList = ingredientsList + "\(ingredient.name!) - \(Int(ingredient.quantity!)) \(ingredient.unit!) \n"
            }
            self.ingredientsTextView.text = ingredientsList
        }
    }
    
}

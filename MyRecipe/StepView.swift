//
//  StepView.swift
//  MyRecipe
//
//  Created by Eduard Radu on 17/05/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import Foundation

class StepView: UIView{
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var taskDescriptionView: UITextView!
   
    func updateViewObject(recipeStep: RecipeStep){
        taskLabel.text = recipeStep.task
        taskDescriptionView.text = recipeStep.description
    }
    
}

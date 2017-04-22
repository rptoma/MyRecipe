//
//  RecipeStepViewController.swift
//  MyRecipe
//
//  Created by Eduard Radu on 22/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import UIKit

class RecipeStepViewController: UIViewController {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var taskDescriptionView: UITextView!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    var taskCounter:Int = 0
    
    var recipeSteps:[RecipeStep] = [RecipeStep]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateForTask()
        
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        updateForTask()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func updateForTask(){
        if taskCounter < recipeSteps.count {
            if taskCounter == recipeSteps.count - 1 {
                nextButtonOutlet.setTitle("Finish", for: UIControlState.normal)
            }
            taskLabel.text = recipeSteps[taskCounter].task
            taskDescriptionView.text = recipeSteps[taskCounter].description
            taskCounter += 1
            
        }
        else {
            finishMessageAlert()
        }
    }
    
    func finishMessageAlert(){
        let alert = UIAlertController(title: "Congratulations!", message: "You have cooked a dish.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            self.backToDetailView()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func backToDetailView(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    
}

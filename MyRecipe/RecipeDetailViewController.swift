//
//  RecipeDetailViewController.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 19/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    
    var recipe: Recipe!
    let requestManager = RequestManager()
    var recipeSteps = [RecipeStep]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.white
        
        recipeStepsRequest()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func startButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "Start and Show Step", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Start and Show Step":
                    if let vc = segue.destination as? RecipeStepViewController {
                        //print(indexPath.row)
                        vc.recipeSteps = self.recipeSteps
                    }
                
            default:
                break
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func recipeStepsRequest(){
        
        requestManager.requestRecipeSteps(forRecipe: recipe.uid!) { (result, error) in
            if error == nil {
                print("made steps request for recipe \(self.recipe.uid!) with name: \(self.recipe.name!)")
                self.recipeSteps = result!
            }
            else {
                print(error!)
            }
        }
        
    }

}

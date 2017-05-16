//
//  RecipeDetailViewController.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 19/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet var detailView: DetailView!

    
    var recipe: Recipe!
    let requestManager = RequestManager()
    var recipeSteps = [RecipeStep]()
    var gotSteps:Bool = false
    var gotDescription:Bool = false

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.detailView.hideLabels()
        navigationController?.navigationBar.tintColor = UIColor.white
        customizeStartButton()
        makeRequests()
    }

    @IBAction func favoriteRecipe(_ sender: UIButton) {
        if let uid = recipe?.uid {
            CoreDataManager.init().addFavorite(uid: uid)
        }
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
*/

    func customizeStartButton(){
        startButton.transformButton()
        self.startButton.isUserInteractionEnabled = false
        startButton.addShadow()
        startButton.addTextSpacing()
    }
    
    func makeRequests(){
        activityIndicatorView.startAnimating()
        recipeStepsRequest()
        recipeDescriptionRequest()
    }
    
    func notifyIndicator(){
        if gotDescription == true && gotSteps == true{
            activityIndicatorView.stopAnimating()
            startButton.isUserInteractionEnabled = true
            self.detailView.revealLabels()
        }
    }
    
    func recipeStepsRequest(){
        
        requestManager.requestRecipeSteps(forRecipe: recipe.uid!) { (result, error) in
            if error == nil {
                //print("made steps request for recipe \(self.recipe.uid!) with name: \(self.recipe.name!)")
                self.gotSteps = true
                self.recipeSteps = result!
                self.notifyIndicator()
        }
            else {
                print(error!)
            }
        }
        
    }
    
    func recipeDescriptionRequest(){
        
        requestManager.requestRecipeDesctiption(forUID: recipe.uid!) { (result, error) in
            if error == nil {
                //print("made steps request for recipe \(self.recipe.uid!) with name: \(self.recipe.name!)")
                self.gotDescription = true
                self.detailView.updateDetailViewObjects(recipeDescription: result!)
                self.notifyIndicator()
                
            }
            else {
                print(error!)
            }
        }
    }
    
   
}

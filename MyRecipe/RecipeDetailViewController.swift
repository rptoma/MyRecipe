//
//  RecipeDetailViewController.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 19/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    let coreDataManager = CoreDataManager()
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    @IBAction func favoriteRecipe(_ sender: UIButton) {
        if let uid = recipe?.uid {
            coreDataManager.addFavorite(uid: uid)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

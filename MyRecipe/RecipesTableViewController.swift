//
//  RecipesTableViewController.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 16/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    var recipes = [Recipe]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    let recipeAPI = RequestManager()
    
    var pageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        pageNumber = 0
        
        recipeAPI.requestRecipes(forPage: pageNumber) { (result, error) in
            if error == nil {
                self.recipes += result!
            }
            else {
                print(error!)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(pageNumber)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RecipeTableViewCell
        
        cell.loadRecipePreview(recipe: recipes[indexPath.row])
        
        if indexPath.row == recipes.count - 1 {
            recipeAPI.requestRecipes(forPage: pageNumber, completionHandler: { (result, error) in
                if error == nil {
                    self.recipes += result!
                    self.pageNumber = self.pageNumber + 1
                }
                else {
                    print(error!)
                }
            })
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


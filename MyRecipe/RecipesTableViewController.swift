//
//  RecipesTableViewController.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 16/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var recipes = [Recipe]() {
        didSet {
            if searchController.isActive == true {
                recipeRequest()
            }
            else {
                tableView.reloadData()
            }
        }
    }
    
    var searchRecipes = [Recipe]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    let requestManager = RequestManager()
    
    var pageNumber = 0
    var pageNumberSearch = 0
    
    func recipeRequest() {
        requestManager.requestRecipes(forPage: pageNumber) { (result, error) in
            if error == nil {
                print("made list request")
                self.recipes += result!
                self.pageNumber = self.pageNumber + 1
            }
            else {
                print(error!)
            }
        }
    }
    
    func recipeSearchRequest() {
        requestManager.requestRecipes(forPage: pageNumberSearch, completionHandler: { (result, error) in
            if error == nil {
                print("made request search")
                self.searchRecipes += result!
                self.pageNumberSearch = self.pageNumberSearch + 1
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a recipe"
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        pageNumber = 0
        pageNumberSearch = 0
        
        recipeRequest()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RecipeTableViewCell
        
        if searchController.isActive == false {
            cell.loadRecipePreview(recipe: recipes[indexPath.row])
            if indexPath.row == recipes.count - 1 {
                recipeRequest()
            }
        }
        else {
            cell.loadRecipePreview(recipe: searchRecipes[indexPath.row])
            if indexPath.row == searchRecipes.count - 1 {
                recipeSearchRequest()
            }
        }
        
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchRecipes.count
        }
        else {
            return recipes.count
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        recipes = [Recipe]()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchRecipes = [Recipe]()
        recipeSearchRequest()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


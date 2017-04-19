//
//  RecipesTableViewController.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 16/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var recipes = [Recipe]() {
        didSet {
            if searchController.isActive == true {
                tableView.setContentOffset(CGPoint.zero, animated: false)
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
    
    var pageNumber: Int!
    var pageNumberSearch: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchBar()
        
        pageNumber = 0
        pageNumberSearch = 0
        
        recipeRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        //tableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func setupSearchBar() {
        searchController.searchBar.delegate = self
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a recipe"
        
        searchController.searchBar.barTintColor = navigationController?.navigationBar.barTintColor
        searchController.searchBar.tintColor = UIColor.white
        
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "Show Recipe Steps":
                if let indexPath = tableView.indexPathForSelectedRow {
                    print(indexPath.row)
                    if let vc = segue.destination as? RecipeStepslViewController {
                        //print(indexPath.row)
                        if searchController.isActive == true {
                            vc.recipe = searchRecipes[indexPath.row]
                        }
                        else {
                            vc.recipe = recipes[indexPath.row]
                        }
                    }
                }
                default:
                    break
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RecipeTableViewCell
        if searchController.isActive == false && indexPath.row < recipes.count && recipes.count != 0 {
            cell.loadRecipePreview(recipe: recipes[indexPath.row])
            if indexPath.row == recipes.count - 1 {
                recipeRequest()
            }
        }
        else {
            cell.loadRecipePreview(recipe: searchRecipes[indexPath.row])
            if indexPath.row == searchRecipes.count - 1 {
                recipeSearchRequest(query: "hamburgers for vegans")
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
    
    func recipeRequest() {
        requestManager.requestRecipes(forPage: pageNumber) { (result, error) in
            if error == nil {
                print("made list request for page \(self.pageNumber)")
                self.recipes += result!
                self.pageNumber = self.pageNumber + 1
            }
            else {
                print(error!)
            }
        }
    }
    
    func recipeSearchRequest(query: String) {
        requestManager.requestRecipes(forQuery: query, forPage: pageNumberSearch) { (result, error) in
            if error == nil {
                print("made search request for page \(self.pageNumberSearch)")
                self.searchRecipes += result!
                self.pageNumberSearch = self.pageNumberSearch + 1
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        recipes = [Recipe]()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchRecipes = [Recipe]()
        pageNumberSearch = 0
        pageNumber = 0
        recipeSearchRequest(query: "hamburgers for vegans")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.tableView.isScrollEnabled = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.tableView.isScrollEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


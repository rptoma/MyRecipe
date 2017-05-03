//
//  FavoritesTableTableViewController.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 02/05/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import UIKit

class FavoritesTableTableViewController: UITableViewController {

    let coreDataManager = CoreDataManager()
    let requestManager = RequestManager()
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var favorites = [Favorite]()
        navigationController?.navigationBar.tintColor = UIColor.white
        coreDataManager.fetchFavorites { (result, error) in
            if let error = error {
                print(error)
            }
            else {
                if let result = result {
                    favorites = result
                }
            }
        }
        
        for favorite in favorites {
            requestManager.requestRecipePreview(forUID: favorite.uid!, completionHandler: { (result, error) in
                if error == nil {
                    if let result = result {
                        self.recipes.append(result)
                         self.tableView.reloadData()
                    }
                }
                else {
                    print(error ?? "unknown error")
                }
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = recipes[indexPath.row].name
        return cell
    }
}

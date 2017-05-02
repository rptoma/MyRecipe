//
//  CoreDataManager.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 02/05/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    public func addFavorite(uid: String) {
        var ok = true
        
        fetchFavorites { (result, error) in
            if let error = error {
                print(error)
                ok = false
            }
            if let result = result {
                for resultUID in result {
                    if resultUID.uid == uid {
                        print("Already exists!")
                        ok = false
                    }
                }
            }
        }
        
        if ok == false {
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let favorite = Favorite(context: context)
        favorite.uid = uid
        do {
            try context.save()
            print("saved")
        }
        catch {
            print("error")
        }
    }
    
    public func fetchFavorites(handler: (_ result: [Favorite]?, _ error: NSError?) -> ())  {
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let favorites = try context.fetch(Favorite.fetchRequest()) as! [Favorite]
            handler(favorites, nil)
        }
        catch let error as NSError{
            handler(nil, error)
        }

    }
}

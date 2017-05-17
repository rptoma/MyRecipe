//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by Eduard Radu on 17/05/2017.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var uid: String?

}

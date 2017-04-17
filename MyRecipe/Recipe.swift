//
//  Recipe.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 16/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import Foundation

class Recipe: CustomStringConvertible {
    
    public var name: String?
    public var difficulty: String?
    public var duration: Int?
    public var unit: String?
    public var icon_image: String?
    public var uid: String?
    
    public var description: String {
        let name = self.name ?? "no name"
        let difficulty = self.difficulty ?? "no difficulty"
        let duration = self.duration ?? -1
        let unit = self.unit ?? "no unit"
        let icon_image = self.icon_image ?? "no icon_image"
        let uid = self.uid ?? "no uid"
        var ret = name + "\n" + difficulty + "\n"
        ret += String(duration) + "\n" + unit + "\n"
        ret += uid + "\n" + icon_image
        return ret
    }
    
    public init(fromJson dictionary: [String: AnyObject]) {
        name = dictionary["name"] as? String
        difficulty = dictionary["difficulty"] as? String
        duration = dictionary["duration"] as? Int
        unit = dictionary["unit"] as? String
        icon_image = dictionary["icon_image"] as? String
        uid = dictionary["uid"] as? String
    }
}

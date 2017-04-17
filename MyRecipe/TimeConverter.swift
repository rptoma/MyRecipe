//
//  TimeConverter.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 17/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import Foundation

class TimeConverter {
    
    public static func getTime(from seconds: Int) -> String {
        if seconds < 60 {
            return "-"
        }
        if seconds == 60 {
            return "1 minute"
        }
        if seconds < 3600 {
            return String(seconds/60) + " minutes"
        }
        if seconds == 3600 {
            return "1 hour"
        }
        else {
            let hours = Double(seconds) / 3600.0
            if hours.truncatingRemainder(dividingBy: 1) == 0 {
                let formatter = NumberFormatter()
                formatter.maximumFractionDigits = 0
                return formatter.string(from: NSNumber(floatLiteral: hours))! + " hours"
            }
            else {
                let formatter = NumberFormatter()
                formatter.maximumFractionDigits = 1
                return formatter.string(from: NSNumber(floatLiteral: hours))! + " hours"
            }
        }
    }
}

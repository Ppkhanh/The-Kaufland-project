//
//  Levelsystem.swift
//  MarketplaceApp
//
//  Created by Linus Lange on 20.11.22.
//

import Foundation

/**
 Class that holds the Levelsystem
 */
struct Levelsystem {
    
    // lower bounds for the levels
    var pointsNeuling = 0
    var pointsBronze = 100
    var pointsSilver = 200
    var pointsGold = 500
    var pointsDiamond = 1000
    
    var loyaltyPoints: Int
    
    /**
     Function, that determines in which level the user currently is
     */
    func getLevel() -> String {
        
        var level = ""
        
        if(loyaltyPoints<pointsBronze){
            level = "Neuling"
        } else if(loyaltyPoints<pointsSilver){
            level = "Bronze"
        }else if(loyaltyPoints<pointsGold){
            level = "Silber"
        } else if(loyaltyPoints<pointsDiamond){
            level = "Gold"
        } else {
            level = "Diamant"
        }
        
        return level
        
    }
    
    func getPoints(level: String) -> Int {
        var lp:Int = 0
        if(level == "Neuling") {
            lp = pointsNeuling
        }else if(level == "Bronze") {
            lp = pointsBronze
        }else if(level == "Silber") {
            lp = pointsSilver
        }else if(level == "Gold") {
            lp = pointsGold
        }else if(level == "Diamant") {
            lp = pointsDiamond
        }
        
        return lp
    }
    
    
    
}

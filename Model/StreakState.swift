//
//  StreakState.swift
//  MarketplaceApp
//
//  Created by Simon Enkel on 30.11.22.
//

import Foundation

struct StreakRewards: Codable {
    var streakArr: [Bool]
    var lastMilestoneActivated: Bool 
}

class StreakState{
    
    static let shared = StreakState()
    @JSONDefaults<StreakRewards>(key: "streakRewards")  var streakRewards: StreakRewards?
     var last10Streak = 40
    
//    init(){
//        streakRewards!.lastMilestoneActivated = false
//    }
     func getState(tile: Int) -> Bool {
         if( streakRewards == nil){
             streakRewards = StreakRewards(streakArr:[false,false,false,false,false,false], lastMilestoneActivated: false)
         }
        return streakRewards!.streakArr[tile]
    }
    
     func setState(tile: Int, bool: Bool) {
        if (streakRewards != nil){
            streakRewards!.streakArr[tile] = bool
        }
    }
    func getLastMilestoneActivated() -> Bool{
        if (streakRewards != nil){
            return streakRewards!.lastMilestoneActivated }
        return false
    }
     func reset(){
        streakRewards = StreakRewards(streakArr:[false,false,false,false,false,false], lastMilestoneActivated: false)
    }
 
    
    
}

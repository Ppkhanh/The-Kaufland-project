//
//  StreakMilestones.swift
//  MarketplaceApp
//
//  Created by Linus Lange on 20.11.22.
//

import Foundation

/**
 Class that includes the Streak Milestones
 */
struct StreakMilestones {
    
    // Array that holds the streak milestones: [points][days]
    var milestonesArr = [[5, 10, 20, 35, 50, 50],[5, 10, 15, 20, 30, 40]]
    
    /**
     Function that calculates how many days are left to reach the next streak milestone
     */
    func daysUntilNextMilestone(streak: Int) -> Int {
        var days = 0
        
        if(streak < milestonesArr[1][0]) {
            days = milestonesArr[1][0] - streak
        } else if(streak < milestonesArr[1][1]) {
            days = milestonesArr[1][1] - streak
        } else if(streak < milestonesArr[1][2]) {
            days = milestonesArr[1][2] - streak
        } else if(streak < milestonesArr[1][3]) {
            days = milestonesArr[1][3] - streak
        } else if(streak < milestonesArr[1][4]) {
            days = milestonesArr[1][4] - streak
        }
        // last milestone that accurs every 10 days
        else {
            days = (streak/10)*10+10 - streak
        }
        
        return days
        
        
    }
    
    /**
     Function that calculates if and which streak milestone has been reached and returns the corresponding extra loyalty points
     */
    func checkForMilestone(streak: Int) -> Int {
        var extraLP = 0
        
        if(streak == milestonesArr[1][0]){
            extraLP = milestonesArr[0][0]
        } else if(streak == milestonesArr[1][1]){
            extraLP = milestonesArr[0][1]
         } else if(streak == milestonesArr[1][2]){
             extraLP = milestonesArr[0][2]
          } else if(streak == milestonesArr[1][3]){
              extraLP = milestonesArr[0][3]
          } else if(streak == milestonesArr[1][4]){
              extraLP = milestonesArr[0][4]
          } else if(streak > milestonesArr[1][4] && streak%10 == 0){
                extraLP = milestonesArr[0][5]

//              if(StreakLPHandler.shared.numberOfDaysBetween(StreakLPHandler.shared.streakHistory!.lastOpenDate, and: .now) != 0)
//                    && streak >= StreakState.last10Streak {
//                  StreakState.setState(tile: 5, bool: false)
//                  StreakState.last10Streak = streak
//              } else{
//                  StreakState.setState(tile: 5,bool: true)
//              }
              // Problem: after closing app the tile can be clicked again
          }
        
        return extraLP
        
    }
    
    func setStateafter30(streak: Int) {
            if(streak > milestonesArr[1][4] && streak%10 == 0){
                if StreakLPHandler.shared.numberOfDaysBetween(StreakLPHandler.shared.streakHistory!.lastActivated, and: .now) == 0
                    && StreakState.shared.getLastMilestoneActivated() == true
                 {
                    StreakState.shared.setState(tile: 5, bool: true)
              
                } else{
                   // StreakState.setLastMileStoneTo(b: false)
                    StreakState.shared.setState(tile: 5, bool: false)
    
                }
            
                // Problem: after closing app the tile can be clicked again
            } else if StreakState.shared.getLastMilestoneActivated() == true{
                StreakState.shared.setState(tile: 5, bool: true)
    
            } else{
                   // StreakState.streakRewards!.lastMilestoneActivated = false
                StreakState.shared.setState(tile: 5, bool: false)
         
            }
                
           
        }
}

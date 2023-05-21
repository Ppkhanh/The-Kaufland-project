//
//  swift
//  MarketplaceApp
//
//  Created by Linus Lange on 11.11.22.
//

import UIKit
import Foundation


struct StreakHistory: Codable {
    var streaks: Int
    var lastOpenDate: Date
    var loyaltyPoints: Int
    var StrkWasUpdated: Bool = false
    var wasReset: Bool = false
    var lastActivated: Date
    var allLP : Int
    //    init(streaks: Int, lastOpenDate: Date, loyaltyPoints: Int, StrkWasUpdated: Bool) {
    //        self.streaks = streaks
    //        self.lastOpenDate = lastOpenDate
    //        self.loyaltyPoints = loyaltyPoints
    //        self.StrkWasUpdated = StrkWasUpdated
    //    }
}

class StreakLPHandler: ObservableObject {
    
    static let shared = StreakLPHandler()
    
    @JSONDefaults<StreakHistory>(key: "streakHistory") var streakHistory: StreakHistory?

    @Published var loyaltyPoints: String = ""
    @Published var streaks: String = ""
    var LPWasUpdated: Bool = false
    
    init(){
        loyaltyPoints = String(calLP())
        streaks = String(calStreak())
    }
     func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let numberOfDays = Calendar.current.dateComponents([.day], from: from, to: to)
        return numberOfDays.day!
    }
    
    
    func calLP() -> Int {
        if(streakHistory != nil){
            if streakHistory!.StrkWasUpdated {
                streakHistory!.loyaltyPoints += 10
                streakHistory!.allLP += 10
                streakHistory!.StrkWasUpdated = false
            }
            
            return streakHistory!.loyaltyPoints
        }else {
            return 10
        }
    }
    
    func updateLP(extraLP: Int) {
        LPWasUpdated = true
        streakHistory!.loyaltyPoints += extraLP
        if (extraLP > 0) {
            streakHistory!.allLP += extraLP
        }
        loyaltyPoints = streakHistory!.loyaltyPoints.description
        
    }
    
    func calStreak() -> Int{
        
        // UserDefaults.standard.set(date.get(.day), forKey: "lastOpen")
        if streakHistory == nil {
            streakHistory = StreakHistory(streaks: 1, lastOpenDate: .now, loyaltyPoints: 10, StrkWasUpdated: false, wasReset: false, lastActivated: .now , allLP: 10)
          
            return 1
        } else {
            let diff = numberOfDaysBetween(streakHistory!.lastOpenDate, and: .now)
            if  diff == 1 {
                streakHistory!.wasReset = false
                streakHistory!.streaks += 1
                streakHistory!.StrkWasUpdated = true
                streakHistory!.lastOpenDate = .now
              
                
            } else{
                if diff != 0{
                    streakHistory!.streaks = 1
                    streakHistory!.StrkWasUpdated = false
                    streakHistory!.wasReset = true
                    streakHistory!.lastOpenDate = .now
                    StreakState.shared.reset()
                } else{
                    return streakHistory!.streaks
                }
            }
            
            return streakHistory!.streaks
        }
        
    }
    
    //test function
    func setStreak(to: Int){
        streakHistory!.streaks = to
    }
    
    func addOneDay() {
        streakHistory!.streaks += 1
    }
    
}

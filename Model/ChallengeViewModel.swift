//
//  ChallengeViewModel.swift
//  MarketplaceApp
//
//  Created by Simon Enkel on 06.01.23.
//
// works the same as WheelViewModel


import Foundation

struct ChallengeHistory: Codable {
    var tries: Int
    var haveTried: Bool
    var lastTry: Date
}


class ChallengeViewModel{
    
    static let shared = ChallengeViewModel()
    @JSONDefaults<ChallengeHistory>(key: "challengeHistory")  var challengeHistory: ChallengeHistory?
 
    var calendar = Calendar(identifier: .gregorian)
    func getNoOfTries(level: String) -> Int{
        if challengeHistory == nil {
            challengeHistory = ChallengeHistory(tries: 0, haveTried: false, lastTry: .now)
        }
        if challengeHistory!.haveTried == false || !calendar.isDateInToday( challengeHistory!.lastTry) {
                if level == "Neuling"{
                    challengeHistory!.tries = 2
                }
                else if level ==  "Bronze" {
                    challengeHistory!.tries = 3}
                else  if level ==  "Silber" {
                    challengeHistory!.tries = 4}
                else  if level ==  "Gold" {
                    challengeHistory!.tries = 5}
                else {
                    challengeHistory!.tries = 6
                }
            return challengeHistory!.tries
            } else{
                return challengeHistory!.tries
            }
    }
    
    
    func haveTried(){
        ChallengeViewModel.shared.challengeHistory!.lastTry = .now
        challengeHistory!.haveTried = true
        challengeHistory!.tries -= 1
    }
    
    func winTry(){
        challengeHistory!.tries += 1
    }
    
    func addTries() {
        challengeHistory!.tries += 3
    }
}


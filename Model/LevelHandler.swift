//
//  LevelHandler.swift
//  MarketplaceApp
//
//  Created by Pham Phuong Khanh on 20.12.22.
//

import Foundation

struct LevelHistory: Codable {
    var currentLevel: String

}

class LevelHandler: ObservableObject{
    static let shared = LevelHandler()
    
    @JSONDefaults<LevelHistory>(key: "levelHistory") var levelHistory: LevelHistory?
    @Published var isLevelUP: Bool = false
    
    init(){
        if(levelHistory == nil){
            levelHistory = LevelHistory(currentLevel: "")
        }
        isLevelUP = isLevelUp()
    }
    
    func isLevelUp() -> Bool{
        let levelSystem = Levelsystem(loyaltyPoints:  StreakLPHandler.shared.calLP())
        if levelHistory!.currentLevel != levelSystem.getLevel(){
            isLevelUP = true
            levelHistory!.currentLevel = levelSystem.getLevel()
            return true
        }
        isLevelUP = false
        return false
    }
    
}

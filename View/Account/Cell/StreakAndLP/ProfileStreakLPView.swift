//
//  ProfileStreakLPView.swift
//  MarketplaceApp
//
//  Created by Linus Lange on 16.11.22.
//

import SwiftUI

/**
 View that displays the current amount of loyalty points, the streak as well as the level system on the account page
 */
struct ProfileStreakLPView: View {
    
    @State var showLPPopup = false
    @State var showStreakPopup = false
    @State var showLevelsystem = false
    @State var lvlupAlreadyShown = false
    
    @ObservedObject var streakHD = StreakLPHandler.shared
    @ObservedObject var levelHD = LevelHandler.shared
    var streakInt: Int{
        return StreakLPHandler.shared.calStreak() }
    
    var loyaltyPoints: Int{
        return StreakLPHandler.shared.calLP()
    }
    
    private func lpString() -> String{
        if(StreakLPHandler.shared.LPWasUpdated){
            return streakHD.loyaltyPoints
        }else{
            return String(StreakLPHandler.shared.calLP())
        }
    }
    
    var levelsystem: Levelsystem{
        return Levelsystem(loyaltyPoints: loyaltyPoints)
    }
    
    var level: String {
        return levelsystem.getLevel()
    }
    
    var showLevelUpPopup: Bool {
        return levelHD.isLevelUP
        
    }
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack{
                /**
                 Loyalty Points Button
                 */
                VStack{
                    
                    Text("Deine Punkte")
                        .font(Font(UIFont.title2))
                        .foregroundColor(KauflandColors.black.swiftUI)
                    
                    Button(action: {
                        lvlupAlreadyShown = true
                       
                        showLPPopup.toggle()
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "trophy.fill")
                                .foregroundColor(.yellow)
                                .padding(.trailing, 10)
                            
                            Text(lpString())
                                .fontWeight(.bold)
                                .foregroundColor(KauflandColors.white.swiftUI)
                            
                            
                            VStack {
                                
                                Text("Treue")
                                Text("Punkte")
                                .font(Font(UIFont.body11))
                                
                            }
                            .foregroundColor(KauflandColors.white.swiftUI)
                            
                        }
                        .padding(7)
                        .padding(.horizontal, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(KauflandColors.redRibbon.swiftUI)
                                .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                                .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
                              
                        )
                    })
                    .sheet(isPresented: $showLPPopup) {
                        LPPopupView()
                            .presentationDetents([.fraction(0.4)])
                    }
                    
                }
                .padding(.trailing, 10)
                /**
                 Streak Button
                 */
                VStack{
                    
                    Text("Deine Streak")
                        .font(Font(UIFont.title2))
                        .foregroundColor(KauflandColors.black.swiftUI)
                    
                    Button(action: {
                        
                        lvlupAlreadyShown = true
                        showStreakPopup.toggle()
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "bolt.fill")
                                .foregroundColor(.yellow)
                                .padding(.trailing, 10)
                            
                            Text(streakHD.streaks)
                                .fontWeight(.bold)
                                .foregroundColor(KauflandColors.white.swiftUI)
                            
                            Text(streakInt == 1 ? " Tag" : "Tage")
                                .foregroundColor(KauflandColors.white.swiftUI)
                                .font(Font(UIFont.body11))
                            
                        }
                        .padding(7.5)
                        .padding(.vertical, 9)
                        .padding(.horizontal, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(KauflandColors.redRibbon.swiftUI)
                                .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                                .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
                        )
                    })
                    .sheet(isPresented: $showStreakPopup) {
                        StreakPopupView(streak: streakInt)
                            .presentationDetents([.fraction(0.7)])
                    }
                    
                }
            }
            Spacer()
            /**
             Levelsystem Section
             */
            VStack() {
                Spacer()
                // display current level
                Text("Level: " + level)
                    .font(Font(UIFont.title2))
                    .foregroundColor(KauflandColors.black.swiftUI)
                
                HStack {
                    Spacer()
                    // display the left trophy in the color of the current level
                    let trophyLeft = Image(systemName: "trophy.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .offset(x: 6)
                    switch level {
                    case "Neuling":
                        trophyLeft.foregroundColor(KauflandColors.green.swiftUI)
                    case "Bronze":
                        trophyLeft.foregroundColor(KauflandColors.orange.swiftUI)
                    case "Silber":
                        trophyLeft.foregroundColor(KauflandColors.gray.swiftUI)
                    case "Gold":
                        trophyLeft.foregroundColor(.yellow)
                    case "Diamant":
                        trophyLeft.foregroundColor(KauflandColors.blue.swiftUI)
                    default:
                        trophyLeft.foregroundColor(.yellow)
                    }
                    
                    Spacer()
                    /**
                     Progress Bar
                     */
                    ZStack (alignment: .leading){
                        
                        // gray bar
                        RoundedRectangle(cornerRadius: 20)
                            .fill(KauflandColors.gray.swiftUI)
                            .frame(width: 250, height: 8)
                        
                        var width = CGFloat(calcProgressbarWidth())
                        
                        // red bar on top of gray bar
                        RoundedRectangle(cornerRadius: 20)
                            .fill(KauflandColors.redRibbon.swiftUI)
                            .frame(width: level != "Diamant" ? width: 250, height: 8) // TODO: sometimes invalid frame dimension in width (build still succeeds)
                        
                    }
                    
                    Spacer()
                    
                    // display the right trophy in the color of the next level
                    let trophyRight = Image(systemName: "trophy.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .offset(x: -6)
                    
                    switch level {
                    case "Neuling":
                        trophyRight.foregroundColor(KauflandColors.orange.swiftUI)
                    case "Bronze":
                        trophyRight.foregroundColor(KauflandColors.gray.swiftUI)
                    case "Silber":
                        trophyRight.foregroundColor(.yellow)
                    case "Gold":
                        trophyRight.foregroundColor(KauflandColors.blue.swiftUI)
                    case "Diamant":
                        trophyRight.foregroundColor(KauflandColors.black.swiftUI)
                    default:
                        trophyRight.foregroundColor(.yellow)
                    }
                    Spacer()
                    
                }
                .padding(.bottom, 5)
                
                // display how many more points need to be collected to reach the next level
//                if(level != "Diamant") {

                        VStack(alignment: .leading){
                            Text(level != "Diamant" ? "Du brauchst noch " + String(calcRemainingLP()) + " Treuepunkte, um das Level " + nextLevel() + " zu erreichen!" : "Du hast das beste Level Diamant erreicht!")
                                .font(Font(UIFont.body22))
                                .foregroundColor(KauflandColors.black.swiftUI)
                                .padding(.bottom, 5)
                        }

        
                        .padding(.horizontal, 10)
                    
                // Button that leads to the levelsystem popup
                    Button(action: {
                        
                        lvlupAlreadyShown = true
                        showLevelsystem.toggle()
                        
                    }, label: {
                        
                        Text("Wie funktioniert das Levelsystem?")
                            .font(Font(UIFont.body11))
                            .foregroundColor(KauflandColors.black.swiftUI)
                            
                    }).offset(x: 30)
                Spacer()
            }
          
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(KauflandColors.white.swiftUI)
                    .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                    .shadow(color: KauflandColors.lightGray.swiftUI, radius: 5, x: 0, y: 3)
                    .padding(.horizontal, 10)
            )
            .padding(.top, 20)
            // LevelUp Popup: shown when a user reaches a new level

            .sheet(isPresented: $showLevelsystem) {
                LevelsystemPopupView(loyaltyPoints: loyaltyPoints, levelsystem: levelsystem)
                    .presentationDetents([.fraction(1)])
            }
            .sheet(isPresented: .constant(showLevelUpPopup && lvlupAlreadyShown == false)) {
                LevelUpPopupView(loyaltyPoints: loyaltyPoints, levelsystem: levelsystem, level: level, showLevelsystem: showLevelsystem)
                    .presentationDetents([.fraction(0.3)])
            }
            
            Spacer()
            
        }
       
    }
    
    /**
     Function that determines the minimum amount of points required for the current level (lower bound)
     */
    func currentLevelPoints() -> Int {
        var nextLevelPoints: Int
        
        switch level {
        case "Neuling":
            nextLevelPoints = levelsystem.pointsNeuling
        case "Bronze":
            nextLevelPoints = levelsystem.pointsBronze
        case "Silber":
            nextLevelPoints = levelsystem.pointsSilver
        case "Gold":
            nextLevelPoints = levelsystem.pointsGold
        default:
            nextLevelPoints = levelsystem.pointsDiamond
        }
        
        return nextLevelPoints
    }
    
    /**
     Function that determines the minimum amount of points required to reach the next level
     */
    func nextLevelPoints() -> Int {
        var nextLevelPoints: Int
        
        switch level {
        case "Neuling":
            nextLevelPoints = levelsystem.pointsBronze
        case "Bronze":
            nextLevelPoints = levelsystem.pointsSilver
        case "Silber":
            nextLevelPoints = levelsystem.pointsGold
        case "Gold":
            nextLevelPoints = levelsystem.pointsDiamond
        default:
            nextLevelPoints = levelsystem.pointsDiamond
        }
        
        return nextLevelPoints
    }
    
    /**
     Function that calculates how many more loyalty points need to be collected to reach the next level
     */
    func calcRemainingLP() -> Int {
        return nextLevelPoints() - loyaltyPoints
    }
    
    /**
     Function that determines which level comes after the current one
     */
    func nextLevel() -> String {
        var nextLevel = ""
        
        switch level {
        case "Neuling":
            nextLevel = "Bronze"
        case "Bronze":
            nextLevel = "Silber"
        case "Silber":
            nextLevel = "Gold"
        case "Gold":
            nextLevel = "Diamant"
        default:
            nextLevel = ""
        }
        
        return nextLevel
    }
    
    /**
     Function that calculates the width of the progress bar
     */
    func calcProgressbarWidth() -> Double {
        return (Double(loyaltyPoints - currentLevelPoints()) / Double(nextLevelPoints() - currentLevelPoints())) * 250.0
    }
    
}


/*struct ProfileStreakLPView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileStreakLPView()
    }
}*/

//
//  TestAndPresent.swift
//  MarketplaceApp
//
//  Created by Marlon Stehl on 19.01.23.
//

import SwiftUI

struct TestAndPresent: View {
    
    @State var showStreakPopup = false
    @State var showStreakResetPopup = false
    @State var showDailyStreakPopup = false
    @State var showLevelUpPopup = false
    
    var streakInt: Int{
        return StreakLPHandler.shared.calStreak()
    }
    
    var levelsystem: Levelsystem{
        return Levelsystem(loyaltyPoints: 100)
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Werte ändern")
                    .font(Font(UIFont.display3))
                Button(action: {
                    WheelViewModel.shared.addTestSpins()
                }, label: {
                    Text("10 Spins hinzufügen")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                        .animation(.default)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.purple)
                        )
                }).padding(.leading, 10)
                
                Button(action: {
                    ChallengeViewModel.shared.addTries()
                }, label: {
                    Text("3 Scrollversuche hinzufügen")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                        .animation(.default)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.blue)
                        )
                }).padding(.leading, 10)
                
                Button(action: {
                    StreakLPHandler.shared.updateLP(extraLP: 1000)
                }, label: {
                    Text("1000 Treuepunkte hinzufügen")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                        .animation(.default)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.green)
                        )
                }).padding(.leading, 10)
                
                Button(action: {
                    StreakLPHandler.shared.streakHistory!.loyaltyPoints = 0
                    StreakLPHandler.shared.updateLP(extraLP: 0)
                }, label: {
                    Text("Treuepunkte zurücksetzen")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                        .animation(.default)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.green)
                        )
                }).padding(.leading, 10)
                
                Button(action: {
                    StreakLPHandler.shared.setStreak(to: 1)
                    StreakState.shared.reset()
                }, label: {
                    Text("Streak zurücksetzen")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                        .animation(.default)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.orange)
                        )
                }).padding(.leading, 10)
                
                Button(action: {
                    StreakLPHandler.shared.addOneDay()
                }, label: {
                    Text("Streak um 1 erhöhen")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                        .animation(.default)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.orange)
                        )
                }).padding(.leading, 10)
                    .padding(.bottom, 30)
            }
            
            VStack {
                Text("Popups öffnen")
                    .font(Font(UIFont.display3))
                
                Button(action: {
                    showStreakPopup.toggle()
                }, label: {
                    Text("Streak Popup")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                        .animation(.default)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.orange)
                        )
                }).padding(.leading, 10)
                
                Button(action: {
                    showStreakResetPopup.toggle()
                }, label: {
                    Text("Streak Lost Popup")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                        .animation(.default)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.red)
                        )
                }).padding(.leading, 10)
                
                Button(action: {
                    showDailyStreakPopup.toggle()
                }, label: {
                    Text("Daily Streak Popup")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                        .animation(.default)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.red)
                        )
                }).padding(.leading, 10)
                
                Button(action: {
                    showLevelUpPopup.toggle()
                }, label: {
                    Text("LevelUp Popup")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                        .animation(.default)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.red)
                        )
                }).padding(.leading, 10)
                
                // streak popup sheet
                    .sheet(isPresented: $showStreakPopup) {
                        StreakPopupView(streak: streakInt )
                            .presentationDetents([.fraction(0.7)])
                    }
                
                    .sheet(isPresented: $showStreakResetPopup) {
                        StreakResetPopupView()
                        .presentationDetents([.fraction(0.3)])
                    }
                    
                
                .sheet(isPresented: $showDailyStreakPopup) {
                     DailyStreakPopupView(streak: streakInt)
                     .presentationDetents([.fraction(0.4)])
                 }
                
                .sheet(isPresented: $showLevelUpPopup) {
                    LevelUpPopupView(loyaltyPoints: 100, levelsystem: levelsystem, level: "Bronze", showLevelsystem: false)
                        .presentationDetents([.fraction(0.3)])
                }
            }
        }
    }
}

struct TestAndPresent_Previews: PreviewProvider {
    static var previews: some View {
        TestAndPresent()
    }
}

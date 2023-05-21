//
//  StreakPopupView.swift
//  MarketplaceApp
//
//  Created by Linus Lange on 10.11.22.
//

import SwiftUI

/**
 View that displays the current streak and explains how streaks work. It also shows the different streak milestones that can be activated.
 */
struct StreakPopupView: View {
    
    @State var streak: Int
    var streakMilestones = StreakMilestones()

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        HStack{
            Spacer()
            Button ( action:{
               dismiss()
            } ,
                     label: {
                Image(systemName: "xmark").font(Font(UIFont.body12))
            }).padding(.top,30)
                .padding(.trailing, 30)
          
        }
        VStack {
                Spacer()
                Text("Wie funktionieren Streaks?")
                    .font(Font(UIFont.title2))
                   // .padding(20)
                    .foregroundColor(KauflandColors.black.swiftUI)
                Spacer()
            
            // display current streak
            ZStack{
                Image(systemName: "bolt.fill")
                    .frame(width: 15, height: 15).foregroundColor(.yellow)
                    .background(Circle().stroke(lineWidth: 1.5) .fill(KauflandColors.gray.swiftUI).frame(width: 60, height: 60) )
                Spacer()
                Text(streak == 1 ? String(streak) + " Tag" : String(streak) + " Tage")
                    .font(Font(UIFont.body12))
                    .foregroundColor(KauflandColors.white.swiftUI)
                    .background(
                        Rectangle()
                            .frame(width: 100, height: 30)
                            .cornerRadius(20)
                            .foregroundColor(KauflandColors.redRibbon.swiftUI)
                    )
                    .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                    .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
                    .offset(y: 30)
            }
           
            Spacer()
            
            // Streak explanation
            Text("An jedem Tag, den du in Folge wieder kommst wird dein persönlicher Streak hochgezählt. Für jeden Tag schenken wir dir 10 Treuepunkte! Diese kannst du dann gegen Coupons einlösen.")
                .font(Font(UIFont.body11))
                .multilineTextAlignment(.center)
                .padding(10)
                .foregroundColor(KauflandColors.black.swiftUI)
            
            Spacer()
            
            /**
             Streak Milestones
             */
            Text("Streak Meilensteine")
                .font(Font(UIFont.title2))
                .padding(.bottom, 1)
                .foregroundColor(KauflandColors.black.swiftUI)
            
            Text("Erhalte an den folgenden Meilensteinen extra Treuepunkte geschenkt!")
                .font(Font(UIFont.body11))
                .multilineTextAlignment(.center)
                .foregroundColor(KauflandColors.black.swiftUI)
            
            // add the different milestones to a scroll view
            ScrollView (.horizontal) {
                HStack {
                    
                    StreakMilestoneView(points: streakMilestones.milestonesArr[0][0],
                                        days: streakMilestones.milestonesArr[1][0],
                                        number: 0,
                                        unlocked: checkIfMilestoneUnlocked(milestone: streakMilestones.milestonesArr[1][0]),
                                        
                                        activated: StreakState.shared.getState(tile: 0))
                    StreakMilestoneView(points: streakMilestones.milestonesArr[0][1],
                                        days: streakMilestones.milestonesArr[1][1],
                                        number: 1,
                                        unlocked: checkIfMilestoneUnlocked(milestone: streakMilestones.milestonesArr[1][1]),
                                        activated: StreakState.shared.getState(tile: 1))
                    StreakMilestoneView(points: streakMilestones.milestonesArr[0][2],
                                        days: streakMilestones.milestonesArr[1][2],
                                        number: 2,
                                        unlocked: checkIfMilestoneUnlocked(milestone: streakMilestones.milestonesArr[1][2]),
                                        activated: StreakState.shared.getState(tile: 2))
                    StreakMilestoneView(points: streakMilestones.milestonesArr[0][3],
                                        days: streakMilestones.milestonesArr[1][3],
                                        number: 3,
                                        unlocked: checkIfMilestoneUnlocked(milestone: streakMilestones.milestonesArr[1][3]),
                                        activated: StreakState.shared.getState(tile: 3))
                    StreakMilestoneView(points: streakMilestones.milestonesArr[0][4],
                                        days: streakMilestones.milestonesArr[1][4],
                                        number: 4,
                                        unlocked: checkIfMilestoneUnlocked(milestone: streakMilestones.milestonesArr[1][4]),
                                        activated: StreakState.shared.getState(tile: 4))
                    
                    Image(systemName: "arrowshape.right.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    // last/special milestone: can be activated every 10 days
                    StreakMilestoneView(points: streakMilestones.milestonesArr[0][5],
                                        days: streakMilestones.milestonesArr[1][5],
                                        number: 5,
                                        
                                        unlocked: streak > streakMilestones.milestonesArr[1][4] ? true : false,
                                        activated: StreakState.shared.getState(tile: 5))
                    
                }
            }
         //   .padding(10)
            
            
        }
        .padding(.horizontal, 40)
        
        
    }
    
    
    // check if the milestone has been reached and should be clickable
    func checkIfMilestoneUnlocked(milestone: Int) -> Bool {
        if(streak >= milestone){
            return true
        }else {
            return false
        }
        
    }
}

/**
 View that represents one single Streak Milestone
 */
struct StreakMilestoneView: View {
    
    var points: Int
    var days: Int
    
    @State var number: Int
    @State var unlocked: Bool
    @State var activated = false
    let successGreen : Color = Color(red: 0, green: 204/255, blue: 0, alpha: 1)
    
    var body: some View {
        
        ZStack {
            
            Button(action: {
                
                // activate the milestone and increase the loyalty points accordingly
                if (StreakState.shared.getState(tile: number) == false) {
                    
                    activated = true
                    if number<5{
                        StreakState.shared.setState(tile: number, bool: true)
                    }
                
                    StreakLPHandler.shared.updateLP(extraLP: points)
                    
                }
                
            }, label: {
                
                VStack {
                    
                    Text(String(points))
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                        .padding(.bottom, 1)
                    Text("Punkte")
                        .font(Font(UIFont.title2))
                        .foregroundColor(KauflandColors.white.swiftUI)
                        .padding(.bottom, 1)
                    
                    // regular milestones
                    if(days<=30){
                        
                        Text(String(days) + " Tage")
                            .font(Font(UIFont.title3))
                            .foregroundColor(KauflandColors.white.swiftUI)
                        
                    }
                    // last/special milestone
                    else {
                        
                        Text("Alle weiteren")
                            .font(Font(UIFont.caption3))
                            .foregroundColor(KauflandColors.white.swiftUI)
                        Text("10 Tage")
                            .font(Font(UIFont.caption3))
                            .foregroundColor(KauflandColors.white.swiftUI)
                        
                    }
                    
                }
                // interior padding
                .padding(10)
                .padding(.horizontal, 8)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 0))
                .background(activated ? RoundedRectangle(cornerRadius: 20).opacity(1).foregroundColor(.init(uiColor: successGreen)) : RoundedRectangle(cornerRadius: 20).opacity(0.5).foregroundColor(KauflandColors.black.swiftUI))
                .overlay(!unlocked ? RoundedRectangle(cornerRadius: 20).opacity(0.7).foregroundColor(KauflandColors.lightGray.swiftUI) : RoundedRectangle(cornerRadius: 20).opacity(0).foregroundColor(KauflandColors.gray.swiftUI))
                // exterior padding
                .padding(.horizontal, 7)
                .padding(.vertical, 3)
                
            })
            .foregroundColor(KauflandColors.black.swiftUI)
            .disabled(unlocked ? false : true)
            .disabled(activated ? true : false)
            
        }
        
    }

}

struct StreakPopupView_Previews: PreviewProvider {
    static var previews: some View {
        StreakPopupView(streak: 2)
        StreakMilestoneView(points: 5, days: 5,number: 0, unlocked: true)
    }
}

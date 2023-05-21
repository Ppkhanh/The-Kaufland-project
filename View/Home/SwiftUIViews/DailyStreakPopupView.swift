//
//  DailyStreakPopupView.swift
//  MarketplaceApp
//
//  Created by Linus Lange on 16.11.22.
//

import SwiftUI

/**
 View that represents a popup that comes up when opening the app for the first time on a new day.
 It displays the current streak and informs the user if a milestone has been reached and how many more days there are left until the next milestone.
 */
struct DailyStreakPopupView: View {
    
    @State var streak: Int
    var streakMilestones = StreakMilestones()
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            Spacer()
            Image("flame")
                .resizable().frame(width: 40, height: 50)
            Text(streak == 1 ? String(streak) + " Tag Streak" : String(streak) + " Tage Streak")
                .font(Font(UIFont.title1)).foregroundColor(KauflandColors.redRibbon.swiftUI)
            
            Text("Weiter so, besuche die App morgen wieder für tägliche Prämien!")
                .multilineTextAlignment(.center)
                .font(Font(UIFont.body12))
                .foregroundColor(KauflandColors.black.swiftUI)
                .padding(.horizontal, 40)
                .offset(y: 10)
            Spacer()
            
            if(streakMilestones.checkForMilestone(streak: streak) != 0){
                
                VStack{
                    Text("Meilenstein erreicht!")
                        .font(Font(UIFont.title2)).foregroundColor(KauflandColors.redRibbon.swiftUI)
                    
                    Text("Du erhälst " + String(streakMilestones.checkForMilestone(streak: streak)) + " Treuepunkte extra.")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.black.swiftUI)
                }
                
                
                Spacer()
                
            }
            
            Spacer()
            
            let daysTilMilestone = streakMilestones.daysUntilNextMilestone(streak: streak)
            ZStack{
                HStack{
                    Text("🔔")  .font(Font(UIFont.display3))
                        .foregroundColor(KauflandColors.black.swiftUI)
                        .shadow(color: KauflandColors.lightGray.swiftUI, radius: 3, x: 0, y: 0 )
                    Spacer()
                }.offset(y: -50)
                    .zIndex(1)
                
                HStack (alignment: .center){
                    Spacer()
                    Text("Nur noch ")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                    Spacer()
                    VStack{
                        Text(String(daysTilMilestone))
                            .font(Font(UIFont.display2))
                            .foregroundColor(KauflandColors.white.swiftUI)
                        Text( daysTilMilestone == 1 ?  "Tag": "Tage")
                            .font(Font(UIFont.body12).bold())
                            .foregroundColor(KauflandColors.white.swiftUI)
                            .offset(y: -4)
                    }
                    Spacer()
                    Text("bis zum nächsten Streak Meilenstein.")
                        .font(Font(UIFont.body12))
                        .foregroundColor(KauflandColors.white.swiftUI)
                    Spacer()
                    //                Text("Es sind nur noch " + String(daysTilMilestone) + " Tage bis zum nächsten Streak Meilenstein.")
                    //                    .font(Font(UIFont.body12))
                    //                    .foregroundColor(KauflandColors.black.swiftUI)
                    ////                    .multilineTextAlignment(.center)
                    //                HStack (alignment: .center){
                    //                    Text("Nur noch ")
                    //                        .font(Font(UIFont.body12))
                    //                        .foregroundColor(KauflandColors.black.swiftUI)
                    //
                    //                    Text(String(daysTilMilestone))
                    //                        .font(Font(UIFont.title1))
                    //                        .foregroundColor(KauflandColors.black.swiftUI)
                    //                    Text(" Tage bis zum nächsten Streak Meilenstein.")
                    //                        .font(Font(UIFont.body12))
                    //                        .foregroundColor(KauflandColors.black.swiftUI)
                    
                    
                }.background(RoundedRectangle(cornerRadius: 10)
                    .fill(KauflandColors.loyaltyPrimaryGradient.swiftUI)
                    .frame(width: 320, height: 100)   )
            }
            
            
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.horizontal, 5)
        
        
    }
    
}

struct DailyStreakPopupView_Previews: PreviewProvider {
    static var previews: some View {
        DailyStreakPopupView(streak: 5)
    }
}

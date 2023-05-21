//
//  StreakButtonView.swift
//  MarketplaceApp
//
//  Created by Linus Lange on 10.11.22.
//

import SwiftUI

/**
 View that displays the current streak in the top right corner on the home screen
 */
struct StreakButtonView: View {
    
    @State var showStreakPopup = false
    @State var showDailyPopup = true
    @ObservedObject var streakHD = StreakLPHandler.shared
    var streakMilestone = StreakMilestones()
    
    
    var streakInt: Int{
        return StreakLPHandler.shared.calStreak()
    }
    var StrkWasUpdated: Bool{
        return ((StreakLPHandler.shared.streakHistory?.StrkWasUpdated) != nil)
    }
    
    var wasReset: Bool{
        return ((StreakLPHandler.shared.streakHistory?.wasReset) != false)
    }
    
    var body: some View {
        
        Button(action: {

            showDailyPopup = false
            showStreakPopup.toggle()
          // StreakViewModel.setStreak(to: 80)
            streakMilestone.setStateafter30(streak: streakInt)
        
            
        }, label: {
            
            HStack {
                
                Image(systemName: "bolt.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.yellow)
                
                Text(streakHD.streaks)
                    .font(.headline)
                    .foregroundColor(KauflandColors.black.swiftUI)
                
                Spacer()
                
                Text(Int(streakHD.streaks) == 1 ? "Tag" : "Tage")
                    .font(Font(UIFont.caption3))
                    .font(.system(size: 10, design: .monospaced))
                    .foregroundColor(KauflandColors.black.swiftUI)
                
                Spacer()
                
            }
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(KauflandColors.white.swiftUI)
                    .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                    .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
            )
            
            
        })
        // streak popup sheet
        .sheet(isPresented: $showStreakPopup) {
            StreakPopupView(streak: streakInt )
                .presentationDetents([.fraction(0.7)])
        }
        // streak reset popup
        .sheet(isPresented: .constant(wasReset && showDailyPopup)){
            StreakResetPopupView() .presentationDetents([.fraction(0.3)])
        }
        // daily streak popup
        .sheet(isPresented: .constant(StrkWasUpdated && showDailyPopup)) {
            DailyStreakPopupView(streak: streakInt)
                .presentationDetents([.fraction(0.4)])
        }
    }
        

    }
    


struct StreakButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StreakButtonView()
    }
}


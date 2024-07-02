//
//  LevelsystemPopupView.swift
//  MarketplaceApp
//
//  Created by Linus Lange and Khanh Pham on 19.11.22.
//

import SwiftUI

/**
 View that displays the levelsystem. It shows how which levels exist, how many loyalty points are required and what are the benefits for each one.
 */
struct LevelsystemPopupView: View {
    
    var loyaltyPoints: Int
    var levelsystem: Levelsystem
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {

        VStack {
            Spacer()
            ZStack{
                HStack{
                    Spacer()
                    Text("Levelsystem")
                        .font(Font(UIFont.body12))
                    Spacer()
                }
                HStack{
                    Spacer()
                    Button(action: {
                        dismiss()
                        
                    }, label: {
                        Image(systemName: "xmark")
                            .font(Font(UIFont.body12))
                            .foregroundColor(KauflandColors.black.swiftUI)
                    }).padding(.trailing, 30)
                }
               
             
            }.padding()
            Spacer()
            VStack(alignment: .leading) {
          
                
                LevelView(loyaltyPoints: loyaltyPoints, points: 0, level: "Neuling", reward: "Du hast 2 Versuche in der Scroll-Challenge.", levelsystem: levelsystem)
                
                LevelView(loyaltyPoints: loyaltyPoints, points: 100, level: "Bronze", reward: "Du darst täglich 1x das Glücksrad drehen und hast 3 Versuche bei der Scroll-Challenge.", levelsystem: levelsystem)
                
                LevelView(loyaltyPoints: loyaltyPoints, points: 200, level: "Silber", reward: "Du darst täglich 2x das Glücksrad drehen und hast 4 Versuche bei der Scroll-Challenge.", levelsystem: levelsystem)
                
                LevelView(loyaltyPoints: loyaltyPoints, points: 500, level: "Gold", reward: "Du darst täglich 3x das Glücksrad drehen und hast 5 Versuche bei der Scroll-Challenge.", levelsystem: levelsystem)
                
                LevelView(loyaltyPoints: loyaltyPoints, points: 1000, level: "Diamant", reward: "Du darst täglich 4x das Glücksrad drehen und hast 6 Versuche bei der Scroll-Challenge.", levelsystem: levelsystem)
                
            }
            //.padding(.leading, 5)
            .font(Font(UIFont.body12))
            Spacer()

        }
    }
    
}

/**
 View that represents the section for a single Level in the whole levelsystem view
 */
struct LevelView: View {
    
    var loyaltyPoints: Int
    var points: Int
    var level: String
    var reward: String
    var levelsystem: Levelsystem
    
    var body: some View {
        
        VStack (alignment: .leading){
            let width = UIScreen.main.bounds.width-80
            // display level and amount of points required
            HStack {
                
                Text(level)
                    .font(.headline)
                
                Image(systemName: "trophy.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(level == "Neuling" ? KauflandColors.green.swiftUI : level == "Bronze" ? KauflandColors.orange.swiftUI : level == "Silber" ? KauflandColors.gray.swiftUI : level == "Gold" ? KauflandColors.yellow.swiftUI : KauflandColors.blue.swiftUI)
                
                Text(String(points) + " Punkte")
                    .font(Font(UIFont.body12))
                    .padding(.leading)
                
            }
            // display the opened/closed lock as well as the color beam
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(level == "Neuling" ? KauflandColors.green.swiftUI : level == "Bronze" ? KauflandColors.orange.swiftUI : level == "Silber" ? KauflandColors.gray.swiftUI : level == "Gold" ? KauflandColors.yellow.swiftUI : KauflandColors.blue.swiftUI)
                    .frame(width: width, height: 8)
                
                Image(systemName: calcLockType(level: level))
                    .padding(5)
                    .background(KauflandColors.white.swiftUI)
                    .overlay(Circle().stroke(level == "Neuling" ? KauflandColors.green.swiftUI : level == "Bronze" ? KauflandColors.orange.swiftUI : level == "Silber" ? KauflandColors.gray.swiftUI : level == "Gold" ? KauflandColors.yellow.swiftUI : KauflandColors.blue.swiftUI, lineWidth: 4))
                    .offset(x: -80)
                
            }
            
            Text(reward)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 20)
                .frame(width: width)
                .font(Font(UIFont.kauflandFont(ofSize: 14)))

            
        }
        .padding(.leading, 30)
        
    }
    
    /**
     Function that calculates whether the lock should be displayed as opened or closed
     */
    func calcLockType(level: String) -> String {
        
        var image = ""
        
        switch level {
        case "Neuling":
            image = "lock.open.fill"
        case "Bronze":
            if(loyaltyPoints < levelsystem.pointsBronze){
                image = "lock.fill"
            }else {
                image = "lock.open.fill"
            }
        case "Silber":
            if(loyaltyPoints < levelsystem.pointsSilver){
                image = "lock.fill"
            }else {
                image = "lock.open.fill"
            }
        case "Gold":
            if(loyaltyPoints < levelsystem.pointsGold){
                image = "lock.fill"
            }else {
                image = "lock.open.fill"
            }
        case "Diamant":
            if(loyaltyPoints < levelsystem.pointsDiamond){
                image = "lock.fill"
            }else {
                image = "lock.open.fill"
            }
        default:
            image = "lock.fill"
        }
        
        return image
        
    }
}

struct LevelsystemPopupView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsystemPopupView(loyaltyPoints: 300, levelsystem: Levelsystem(loyaltyPoints: 300))
        LevelView(loyaltyPoints: 250, points: 100, level: "Bronze", reward: "Du darfst täglich 1x das Glücksrad drehen", levelsystem: Levelsystem(loyaltyPoints: 250))
            .font(Font(UIFont.body12))
    }
}

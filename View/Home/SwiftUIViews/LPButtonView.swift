//
//  LPButtonView.swift
//  MarketplaceApp
//
//  Created by Khanh Pham on 10.11.22.
//

import SwiftUI

/**
 View that displays the amount of loyalty points in the top right corner on the home screen
 */
struct LPButtonView: View {
    @State var showLPPopup = false
    @State var updateLP = false
    
    @ObservedObject var streakHD = StreakLPHandler.shared
    
    
    private func loyaltyPoints() -> String{
        if(StreakLPHandler.shared.LPWasUpdated){
            return streakHD.loyaltyPoints
        }else{
            return String(StreakLPHandler.shared.calLP())
        }
    }
    
    
    var body: some View {
        
        Button(action: {
            
            showLPPopup.toggle()
            //StreakViewModel.setLP(to: 10)
           // loyaltyPoints = StreakViewModel.calLP() // refresh points (dummy)
                        
        }, label: {
            
            HStack {
                
                Image(systemName: "trophy.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.yellow)
                
                Text(loyaltyPoints())
                    .font(.headline)
                    .foregroundColor(KauflandColors.black.swiftUI)
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                
                Spacer()
                
                VStack {
                    
                    Text("Treue")
                        .font(Font(UIFont.caption3))
                        .font(.system(size: 10))
                        .foregroundColor(KauflandColors.black.swiftUI)
                    
                    Text(Int(streakHD.loyaltyPoints) == 1 ? "Punkt" : "Punkte")
                        .font(Font(UIFont.caption3))
                        .font(.system(size: 10))
                        .foregroundColor(KauflandColors.black.swiftUI)
                    
                }
                
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
        .sheet(isPresented: $showLPPopup) {
            LPPopupView()
                .presentationDetents([.fraction(0.4)])
        }
        
    }
    
    
    
    
}


struct LPButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LPButtonView()
    }
}


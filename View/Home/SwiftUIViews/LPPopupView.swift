//
//  LPPopupView.swift
//  MarketplaceApp
//
//  Created by Linus Lange on 10.11.22.
//

import SwiftUI

/**
 View that displays the the popup which comes up after clicking on the LP-Button. It shows the current amount of loyalty points and the corresponding level.
 */
struct LPPopupView: View {
    
    @State var showGameArea = false
    @State var showCouponView = false
    @Environment(\.dismiss) var dismiss
    
    var loyaltyPoints: Int{
        return StreakLPHandler.shared.calLP()
    }
    
    var levelsystem: Levelsystem{
        return Levelsystem( loyaltyPoints: loyaltyPoints)
    }
    var level: String {
        levelsystem.getLevel()
    }
    
    var body: some View {
        
            
           // Spacer()
        VStack {
            //Spacer()
            // display level
            HStack {
                Spacer()
                ZStack{
                    let trophyImg = Image(systemName: "trophy.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                    
                    switch level {
                    case "Neuling":
                        trophyImg.foregroundColor(KauflandColors.green.swiftUI)
                    case "Bronze":
                        trophyImg.foregroundColor(KauflandColors.orange.swiftUI)
                    case "Silber":
                        trophyImg.foregroundColor(KauflandColors.gray.swiftUI)
                    case "Gold":
                        trophyImg.foregroundColor(.yellow)
                    case "Diamant":
                        trophyImg.foregroundColor(KauflandColors.blue.swiftUI)
                    default:
                        trophyImg.foregroundColor(.yellow)
                    }
                    
                    Text(level)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 13)
                        .foregroundColor(KauflandColors.black.swiftUI)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(KauflandColors.white.swiftUI)
                                .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                                .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
                        )
                        .offset(y: 35)
                }
                Spacer()
                VStack{
                    Button ( action:{
                        dismiss()
                    } ,
                             label: {
                        Image(systemName: "xmark").font(Font(UIFont.body12))
                    })
                    Spacer()
                }

            }.padding()
            
            Spacer()
            // display amount of loyalty points
            VStack{
                Spacer()
            if (loyaltyPoints == 1) {
                Text("Du hast aktuell " + String(loyaltyPoints) + " Treuepunkt!")
                    .font(Font(UIFont.body11))
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .foregroundColor(KauflandColors.black.swiftUI)
            } else {
                Text("Du besitzt aktuell " + String(loyaltyPoints) + " Treuepunkte!")
                    .font(Font(UIFont.body11))
                    .multilineTextAlignment(.center)
                   // .padding(.bottom, 10)
                    .foregroundColor(KauflandColors.redRibbon.swiftUI)
            }
            Spacer()
            Text("🔔 Insgesamt hast du " + String(StreakLPHandler.shared.streakHistory!.allLP) + " Treuepunkte gesammelt.")
                    .font(Font(UIFont.kauflandFont(ofSize: 14)))
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
                .foregroundColor(KauflandColors.black.swiftUI)
                Spacer()
        }
                    // Buttons
                    HStack {
                        Spacer()
                        Button(action: {
                            
                            showGameArea.toggle()
                            
                        }, label: {
                            
                            Text("Mehr sammeln")
                                .font(Font(UIFont.label1))
                                .foregroundColor(KauflandColors.black.swiftUI)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(KauflandColors.white.swiftUI)
                                        .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                                        .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
                                )
                        })
                        .padding(.horizontal, 5)
                        .fullScreenCover(isPresented: $showGameArea, content: GameAreaView.init)
                        
                        Button(action: {
                            
                            showCouponView.toggle()
                            
                        }, label: {
                            
                            Text("Direkt einlösen")
                                .font(Font(UIFont.label1))
                                .foregroundColor(KauflandColors.white.swiftUI)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(KauflandColors.redRibbon.swiftUI)
                                        .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                                        .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
                                )
                        })
                        .sheet(isPresented: $showCouponView, content: CouponView.init)
                        Spacer()
                    }
                    Spacer()
                    
                
            }
            .padding(20)
            
        

    }
}

struct LPPopupView_Previews: PreviewProvider {
    static var previews: some View {
        LPPopupView()
    }
}

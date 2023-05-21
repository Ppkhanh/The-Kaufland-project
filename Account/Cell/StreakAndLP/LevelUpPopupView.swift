//
//  LevelUpPopupView.swift
//  MarketplaceApp
//
//  Created by Linus Lange on 26.11.22.
//

import SwiftUI

/**
 View that informs the user as a popup, that a new level has been reached
 */
struct LevelUpPopupView: View {
    
    var loyaltyPoints: Int
    var levelsystem: Levelsystem
    var level: String
    @State var showLevelsystem: Bool
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        Spacer()
        VStack {
//            HStack{
//                Spacer()
//                Button ( action:{
//                    dismiss()
//                } ,
//                         label: {
//                    Image(systemName: "xmark").font(Font(UIFont.body12))
//                })
//                .padding(.trailing, 10)
//                
//            }
            Spacer()
            Text("Neues Level!").font(Font(UIFont.title1)).foregroundColor(KauflandColors.redRibbon.swiftUI)
            
            Spacer()
            
            Text("Du hast das Level ") + Text(level).bold() + Text(" erreicht.")
                .font(Font(UIFont.body12))
                .foregroundColor(KauflandColors.black.swiftUI)
            
            HStack{
                
                Text("Sieh dir hier alle Vorteile im")
                    .foregroundColor(KauflandColors.black.swiftUI)
                    .font(Font(UIFont.body12))
                
                // button that opens up the Levelsystem popup
                Button(action: {
                    
                    showLevelsystem.toggle()
                    
                }, label: {
                    
                    Text("Levelsystem")
                        .font(Font(UIFont.body12))
                    
                    
                })
                .sheet(isPresented: $showLevelsystem) {
                    LevelsystemPopupView(loyaltyPoints: loyaltyPoints, levelsystem: levelsystem)
                        .presentationDetents([.fraction(0.9)])
                }
                
                Text("an.")
                    .foregroundColor(KauflandColors.black.swiftUI)
                    .font(Font(UIFont.body12))
                
            }
            
            
            Image("levelup").resizable().frame(width: 70, height: 70)
                .padding(.top, 10)
            Spacer()
            
            
            
        }
        .padding(.horizontal, 5)
        Spacer()
        
        
        
        
        //        VStack{
        //
        //            HStack {
        //
        //                Image("balloons")
        //                    .resizable()
        //                    .frame(width: 100, height: 100)
        //                    .padding(.leading, 10)
        //                    .padding(.trailing, 5)
        //
        //                VStack(alignment: .leading) {
        //                    HStack{
        //
        //                        Spacer()
        //
        //                        Button ( action:{
        //                            dismiss()
        //                        } ,
        //                                 label: {
        //                            Image(systemName: "xmark").font(Font(UIFont.body12))
        //                        })
        //                        .padding(.trailing, 10)
        //
        //                    }
        //
        //                    Text("Neues Level")
        //                        .foregroundColor(KauflandColors.white.swiftUI)
        //                        .font(Font(UIFont.body12))
        //                        .padding(.horizontal, 5)
        //                        .padding(.vertical, 2)
        //                        .bold()
        //                        .background(
        //                            Rectangle()
        //                                .fill(KauflandColors.redRibbon.swiftUI)
        //                                .cornerRadius(6)
        //                        )
        //
        //                    Text("Du hast das Level ") + Text(level).bold() + Text(" erreicht.")
        //                        .font(Font(UIFont.body11))
        //                        .foregroundColor(KauflandColors.black.swiftUI)
        //
        //
        //                        Text("Alle Vorteile findest du jetzt im ")
        //                            .foregroundColor(KauflandColors.black.swiftUI)
        //                            .font(Font(UIFont.body11))
        //
        //                        // button that opens up the Levelsystem popup
        //                        Button(action: {
        //
        //                            showLevelsystem.toggle()
        //
        //                        }, label: {
        //
        //                            Text("Levelsystem")
        //                                .font(Font(UIFont.body10))
        //
        //
        //                        })
        //                        .sheet(isPresented: $showLevelsystem) {
        //                            LevelsystemPopupView(loyaltyPoints: loyaltyPoints, levelsystem: levelsystem)
        //                                .presentationDetents([.fraction(0.9)])
        //                        }
        //
        //                }
        //                .padding(.horizontal, 5)
        //
        //            }
        //            .padding(.horizontal, 5)
        //
        //        }
        //        .ignoresSafeArea()
        
        
        
        
        
        
        //        Image("balloons")
        //                .resizable()
        //                .frame(width: 150, height: 150)
        //                .padding(.top, 20)
        //
        //
        //
        //
        //            VStack {
        //
        //                Text("Herzlichen Glückwunsch!")
        //                    .font(.system(size: 20))
        //                    .font(Font(UIFont.body12))
        //                    .fontWeight(.bold)
        //                    .foregroundColor(KauflandColors.white.swiftUI)
        //                    .padding(.bottom, 5)
        //
        //                // display which level has been reached
        //                Text("Du hast das Level " + level + " erreicht.")
        //                   .font(Font(UIFont.body11))
        //                   .foregroundColor(KauflandColors.white.swiftUI)
        //                    .padding(.bottom, 5)
        //
        //                HStack {
        //
        //                    Text("Sieh dir hier alle Vorteile im")
        //                        .foregroundColor(KauflandColors.white.swiftUI)
        //                        .font(Font(UIFont.body11))
        //
        //                    // button that opens up the Levelsystem popup
        //                    Button(action: {
        //
        //                        showLevelsystem.toggle()
        //
        //                    }, label: {
        //
        //                        Text("Levelsystem")
        //                            .font(Font(UIFont.body10))
        //
        //
        //                    })
        //                    .sheet(isPresented: $showLevelsystem) {
        //                        LevelsystemPopupView(loyaltyPoints: loyaltyPoints, levelsystem: levelsystem)
        //                            .presentationDetents([.fraction(0.9)])
        //                    }
        //
        //                    Text("an.")
        //                        .foregroundColor(KauflandColors.white.swiftUI)
        //                        .font(Font(UIFont.body11))
        //
        //                }
        //
        //            }
        //            .padding(10)
        //            .padding(.top, 20)
        //
        
        
    }
}

struct LevelUpPopupView_Previews: PreviewProvider {
    static var previews: some View {
        LevelUpPopupView(loyaltyPoints: 100, levelsystem: Levelsystem(loyaltyPoints: 100), level: "Bronze", showLevelsystem: false)
    }
}

//
//  GameAreaView.swift
//  MarketplaceApp
//
//  Created by Linus Lange on 21.11.22.
//

import SwiftUI

/**
 View that displays the game area. It shows the current amount of loyalty points, as well as the two challenges "Wheel of Fortune" and the "Scroll Challenge". There is also a button which leads to the CouponView(), to make use of the loyalty points.
 */
struct GameAreaView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack{
            NavigationView{
                VStack{
                    ZStack {
                        HStack{
                            Button(action: {
                                dismiss()
                             
                            }, label: {
                            Image(systemName: "chevron.backward")
                                    .font(Font(UIFont.body12))
                            .foregroundColor(KauflandColors.black.swiftUI)

                            }).offset(x:10)
                            Spacer()
                           
                        }.zIndex(1)
                        GameAreaHeader()
                    }
                    ScrollView{
                        Spacer()
                        CouponButtonView()
                        Spacer()
                        WheelOfFortuneButtonView()
                        Spacer()
                        ScrollChallengeButtonView()
                        Spacer()
                        TestAndPresentView()
                        Spacer()
                    }
                }
                
                
            }.accentColor(.red)
              
        }.transition(.move(edge: .trailing))
    }
}

/**
 View that represents the header in the Game Area. It displays the Kaufland logo and current amount of loyalty points
 */
struct GameAreaHeader: View {
    
    @ObservedObject var streakHD = StreakLPHandler.shared
    @State var showLPPopup = false
    
    
    private func loyaltyPoints() -> String{
        if(StreakLPHandler.shared.LPWasUpdated){
            return streakHD.loyaltyPoints
        }else{
            return String(StreakLPHandler.shared.calLP())
        }
    }
    
    
    var body: some View {
        
        ZStack {
            
            
            
            Rectangle()
                .fill(KauflandColors.white.swiftUI )
                .frame(width: UIScreen.main.bounds.width, height: 80)
            
            Image("kaufland_logo_noText")
                .resizable()
                .frame(width: 50, height: 50)
                .background(
                    Rectangle()
                        .fill(KauflandColors.white.swiftUI)
                )
            
            Button(action: {
                
                showLPPopup.toggle()
                
            }, label: {
                
                HStack {
                    Image(systemName: "trophy.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.yellow)
                    
                    Text(loyaltyPoints())
                        .font(.headline)
                        .foregroundColor(KauflandColors.black.swiftUI)
                        .animation(.default)
                    
                    
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
                    .padding(.horizontal, 5)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(KauflandColors.white.swiftUI)
                        .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                        .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
                    
                )
                .sheet(isPresented: $showLPPopup) {
                    LPPopupView()
                        .presentationDetents([.fraction(0.4)])
                }
                
            })
            .offset(x: 120)
            
        }
        
    }
}

/**
 View that represents the "wheel of fortune" section inside the game area
 */
struct WheelOfFortuneButtonView: View {
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(KauflandColors.white.swiftUI)
                .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                .shadow(color: KauflandColors.lightGray.swiftUI, radius: 5, x: 0, y: 3)
                .padding(10)
            
            HStack {
                
                Image("wheelOfFortune")
                    .resizable()
                    .frame(width: 120, height: 120)
                
                VStack(alignment: .leading) {
                    Text("Glücksrad")
                        .font(Font(UIFont.body12))
                        .bold()
                        .foregroundColor(KauflandColors.black.swiftUI)
                        .padding(.bottom, 0)
                    
                    VStack {
                        Text("Stelle dein Glück auf die Probe und gewinne tolle Preise!")
                    }
                    .font(.subheadline)
                    .foregroundColor(KauflandColors.black.swiftUI)
                    
                    HStack {
                        // go to the wheel of fortune after clicking the button
                        NavigationLink(destination: WheelOfFortuneView()){
                            Text("Drehen")
                                .font(Font(UIFont.label1))
                                .bold()
                                .foregroundColor(KauflandColors.white.swiftUI)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(KauflandColors.redRibbon.swiftUI)
                                )
                    }
                }
                }
                .padding(20)
            }.padding(.horizontal, 40)
                .padding(.vertical, 20)
        }
        
    }
}

/**
 View that represents the "Scroll Challenge" section inside the game area
 */
struct ScrollChallengeButtonView: View {
    
    var body: some View{
        
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(KauflandColors.white.swiftUI)
                .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                .shadow(color: KauflandColors.lightGray.swiftUI, radius: 5, x: 0, y: 3)
                .padding(10)
            
            HStack {
                
                Image("scroll")
                    .resizable().scaledToFit()
                    .frame(width: 120, height: 120)
                
                VStack(alignment: .leading) {
                    Text("Scroll Challenge")
                        .font(Font(UIFont.body12))
                        .bold()
                        .foregroundColor(KauflandColors.black.swiftUI)
                    
                    VStack {
                        Text("Einfach und schnell neue Treuepunkte sammeln. Scrollen und Punkten!")
                    }
                    .font(.subheadline)
                    .foregroundColor(KauflandColors.black.swiftUI)
                    
                    HStack {
                        // go to the wheel of fortune after clicking the button
                        NavigationLink(destination: ExampleScrollView()){
                            Text("Scrollen")
                                .font(Font(UIFont.label1))
                                .bold()
                                .foregroundColor(KauflandColors.white.swiftUI)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(KauflandColors.redRibbon.swiftUI)
                                )
                        }
                    }
                }
                .padding(20)
            }.padding(.horizontal, 40)
                .padding(.vertical, 20)
        }
    }
}

/**
 This view is just for testing and presenting this prototype and can be removed for production
 */
struct TestAndPresentView: View {
    
    var body: some View{
        
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(KauflandColors.white.swiftUI)
                .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                .shadow(color: KauflandColors.lightGray.swiftUI, radius: 5, x: 0, y: 3)
                .padding(10)
            
            HStack {
                
                Image("computer_settings")
                    .resizable()
                    .frame(width: 120, height: 120)
                
                VStack(alignment: .leading) {
                    Text("Test and Present")
                        .font(Font(UIFont.body12))
                        .bold()
                        .foregroundColor(KauflandColors.black.swiftUI)
                    
                    VStack {
                        Text("Diese Seite ist zum Testen und Präsentieren dieses Prototypen.")
                    }
                    .font(.subheadline)
                    .foregroundColor(KauflandColors.black.swiftUI)
                    
                    HStack {
                        // go to the wheel of fortune after clicking the button
                        NavigationLink(destination: TestAndPresent()){
                            Text("Testen")
                                .font(Font(UIFont.label1))
                                .bold()
                                .foregroundColor(KauflandColors.white.swiftUI)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(KauflandColors.redRibbon.swiftUI)
                                )
                        }
                    }
                }
                .padding(20)
            }.padding(.horizontal, 40)
                .padding(.vertical, 20)
        }
    }
}

/**
 View that displays a button, that  leads to the CouponView()
 */
struct CouponButtonView: View {
    
    var body: some View{
        
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(KauflandColors.white.swiftUI)
                        .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                        .shadow(color: KauflandColors.lightGray.swiftUI, radius: 5, x: 0, y: 3)
                        .padding(10)
                    
                    VStack{
                        HStack{
                            Text("Punkte einlösen")
                                .font(Font(UIFont.body12))
                                .foregroundColor(KauflandColors.black.swiftUI)
                                .bold()
                                .zIndex(2)
                            Image("discount")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        Text("Tausche deine Treuepunkte gegen Coupons ein und spare bei deinem nächsten Einkauf.")
                            .foregroundColor(KauflandColors.black.swiftUI)
                            .zIndex(2)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                        
                        NavigationLink(destination: CouponView()){
                            HStack {
                                Text("Einlösen")
                                    .font(Font(UIFont.label1))
                                    .bold()
                                    .foregroundColor(KauflandColors.white.swiftUI)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(KauflandColors.redRibbon.swiftUI)
                                    ).offset(x: 0, y: 0)
                            }
                    }.padding(.horizontal, 50)
                    
                }.padding(.vertical, 30)
            }
        
    }
}



struct GameAreaView_Previews: PreviewProvider {
    static var previews: some View {
        GameAreaView()
    }
}

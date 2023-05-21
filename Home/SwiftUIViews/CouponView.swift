//
//  CouponView.swift
//  MarketplaceApp
//
//  Created by Linus Lange on 30.11.22.
//

import SwiftUI

/**
 View that displays all the availible coupons. Users can exchange their loyalty points here for these coupons.
 */
struct CouponView: View {
    
    var streakInt: Int{
        return StreakLPHandler.shared.calStreak()
    }
    
    
    var body: some View {
        VStack {
            
            GameAreaHeader()
            
            
            HStack{
                
                
                Text("Coupons")
                    .font(Font(UIFont.display3))
                    .fontWeight(.bold)
                    .foregroundColor(KauflandColors.redRibbon.swiftUI)
                
                
                
            }
                        
            SingleCouponView(price: 100, discount: 10, text: "auf deinen nächsten Einkauf")
                        
            SingleCouponView(price: 250, discount: 25, text: "auf bereits reduzierte Artikel")
                        
            SingleCouponView(price: 500, discount: 50, text: "auf deinen nächsten Einkauf")
            
            SingleCouponView(price: 1000, discount: 100, text: "auf ein beliebiges Produkt unter 50€")
                        
            Spacer()

            HStack{
                
                
                Text("Komm bald wieder für neue Gutscheine")
                    .font(Font(UIFont.title2))
                    .fontWeight(.bold)
                    .foregroundColor(KauflandColors.gray216.swiftUI)
                    .multilineTextAlignment(.center)
                
                Image("rabattcode")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.horizontal, 10)
                
            }
            .padding(.horizontal,10)

            Spacer()

            
//            Text("Aktuell sind keine Rabattcodes verfügbar")
//                .font(Font(UIFont.display3))
//                .fontWeight(.bold)
//                .foregroundColor(KauflandColors.gray216.swiftUI)
//                .multilineTextAlignment(.center)


            
        }
    }
}

struct SingleCouponView: View {
    
    var price: Int
    var discount: Int
    var text: String
    @State var disableButton = false;

    
    
    var body: some View{
        
        Button(action: {
            
            if(StreakLPHandler.shared.calLP() >= price){
                StreakLPHandler.shared.updateLP(extraLP: -price)
                disableButton.toggle()
            }
            
        }, label: {
            
            ZStack{
                
                
                
                HStack{
                    
                    VStack(alignment: .leading){
                        Text(String(discount) + "%")
                            .foregroundColor(KauflandColors.white.swiftUI)
                            .font(Font(UIFont.display3))
                        Text(text)
                            .foregroundColor(KauflandColors.white.swiftUI)
                            .font(Font(UIFont.body12))
                            .multilineTextAlignment(.leading)
                        
                    }
                    .frame(width: 150)
                    
                    VStack(alignment: .leading){
                        
                        
                        
                        Image("shopping")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding(.top, 30)
                        
                        
                    }
                    .frame(width: 130)
                    
                    
                }
                .background(
                    
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(disableButton ? KauflandColors.gray.swiftUI : KauflandColors.redRibbon.swiftUI)
                            .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                            .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
                            .frame(width: 300, height: 100)
                        
                        HStack{
                            
                            Spacer()
                            
                            VStack{
                                ZStack{
                                    
                                    Rectangle()
                                        .fill(KauflandColors.lightRed.swiftUI)
                                        .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                                        .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
                                        .frame(width: 80, height: 30)
                                        .cornerRadius(10, corners: [.bottomLeft, .topRight])
                                    
                                    Text(String(price) + "LP")
                                        .foregroundColor(KauflandColors.black.swiftUI)
                                        .font(Font(UIFont.body12))
                                        .bold()
                                    
                                }
                                
                                Spacer()
                                
                            }
                        }
                    }
                    
                )
                
            }
            
            
        })
        .padding(10)
        .disabled(disableButton)
        
        
    }
}

struct CouponView_Previews: PreviewProvider {
    static var previews: some View {
        CouponView()
    }
}

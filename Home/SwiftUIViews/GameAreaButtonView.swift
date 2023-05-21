//
//  GameAreaButtonView.swift
//  MarketplaceApp
//
//  Created by Linus Lange on 18.11.22.
//

import SwiftUI

/**
 View tha displays a button on the home page which leads to the game area.
 */
struct GameAreaButtonView: View {
    
    @State var showGameArea = false
    
    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [KauflandColors.loyaltyPrimary.swiftUI, KauflandColors.loyaltyPrimaryGradient.swiftUI]),
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(backgroundGradient)
                .shadow(color: KauflandColors.lightGray.swiftUI, radius: 5, x: 0, y: 0)
            VStack{
                
                HStack {
                    Image("wheelOfFortune")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .padding(.horizontal, 10)
                }.padding(10)
                
                    VStack {
                        HStack {
                            VStack {
                                Text("Challenges")
                                    .font(Font(UIFont.body12))
                                    .fontWeight(.bold)
                                    .foregroundColor(KauflandColors.black.swiftUI)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("Sammel spielerisch Treuepunkte")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(Font(UIFont.body12))
                                    .foregroundColor(KauflandColors.black.swiftUI)
                            }.padding(.top, 5)
                                .padding(.bottom, 5)
                            
                            Button(action: {
                                showGameArea.toggle()
                            }, label: {
                                VStack{
                                    Text(Image(systemName: "chevron.right"))
                                    //.font(Font(UIFont.display3))
                                        .font(.system(size: 20))
                                        .bold()
                                        .foregroundColor(KauflandColors.red.swiftUI)
                                }
                            })
                        }.padding(13)
                 
                    }.background(KauflandColors.white.swiftUI)
                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                   
                
            }
        }
        .fullScreenCover(isPresented: $showGameArea){
            GameAreaView()
        }
}
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct GameAreaButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GameAreaButtonView()
    }
}

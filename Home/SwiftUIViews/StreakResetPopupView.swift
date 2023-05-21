//
//  StreakResetView.swift
//  MarketplaceApp
//
//  Created by Pham Phuong Khanh on 24.11.22.
//

import Foundation
import SwiftUI

/**
 View that represents a popup that informs the user that his streak has been lost.
 */
struct StreakResetPopupView: View {
    
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
            Text("Streak verloren!").font(Font(UIFont.title1)).foregroundColor(KauflandColors.redRibbon.swiftUI)
            Spacer()
            Text("Schade! Deine Streak wurde zurückgesetzt, weil du dich gestern nicht eingeloggt hast. 😔")
                .multilineTextAlignment(.center)
                .font(Font(UIFont.body12))
                .foregroundColor(KauflandColors.black.swiftUI)
                .padding()
            
            Image("StreakReset").resizable().frame(width: 70, height: 70)
            Spacer()
          
            //                    .padding(.horizontal, 5)
            
        }
        .padding(.horizontal, 5)
        Spacer()
    }
}


struct StreakReset_Previews: PreviewProvider {
    static var previews: some View {
        StreakResetPopupView()
        
    }
}

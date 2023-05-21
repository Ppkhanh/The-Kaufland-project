//
//  ScrollManual.swift
//  MarketplaceApp
//
//  Created by Marlon Stehl on 20.01.23.
//

import SwiftUI

struct ScrollManual: View {
    var body: some View {
        NavigationView {
            
            
            VStack {
                Text("Wie wird gespielt?")
                    .font(Font(UIFont.display3))
                    .foregroundColor(KauflandColors.redRibbon.swiftUI)
                VStack(alignment: .leading, spacing: 20) {
                    Label("Auf 'Starten' klicken. Die Zahl in Klammern ist die Anzahl der Versuche.", systemImage: "1.circle")
                        .labelStyle(WhiteShadowLabelStyle())
                    Label("Durch Produktseite scrollen.", systemImage: "2.circle")
                        .labelStyle(WhiteShadowLabelStyle())
                    Label("Min. 30sek und max. 120sek scrollen, um Treuepunkte zu verdienen.", systemImage: "3.circle")
                        .labelStyle(WhiteShadowLabelStyle())
                }.padding(.vertical, 10)
                
                Text("Hinweise")
                    .font(Font(UIFont.display3))
                    .foregroundColor(KauflandColors.redRibbon.swiftUI)
                    .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    Label("Wenn für min. 5sek nicht gescrollt wird, ist die Challenge verloren.", systemImage: "clock.badge.xmark")
                        .labelStyle(WhiteShadowLabelStyle())
                    Label("Treuepunkte werden in 4 Etappen ausgegeben.", systemImage: "stopwatch")
                        .labelStyle(WhiteShadowLabelStyle())
                    Label("Die aktuelle Etappe kann in der Fortschrittsanzeige oben abgelesen werden.", systemImage: "hourglass")
                        .labelStyle(WhiteShadowLabelStyle())
                }.padding(.vertical, 10)
                
            }.padding(.horizontal, 30)
            
            
        }.navigationTitle("Anleitung")
    }
}

struct WhiteShadowLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .font(Font(UIFont.body12))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(KauflandColors.black.swiftUI)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(KauflandColors.white.swiftUI)
                    .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                    .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
                )
    }
}

struct ScrollManual_Previews: PreviewProvider {
    static var previews: some View {
        ScrollManual()
    }
}

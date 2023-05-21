//
//  WheelOfFortuneView.swift
//  MarketplaceApp
//
//  Created by Linus Lange on 25.11.22.
//

import SwiftUI
import SwiftUITooltip
/**
 View that displays the wheel of fortune, where users can win loyalty points.
 */
struct WheelOfFortuneView: View {
    
    /**
     Individual Colors for the Wheel of Fortune
     */
    let wofPink = UIColor(red: 242/255, green: 5/255, blue: 116/255, alpha: 1)
    let wofBlue = UIColor(red: 4/255, green: 217/255, blue: 217/255, alpha: 1)
    let wofGreen = UIColor(red: 171/255, green: 217/255, blue: 4/255, alpha: 1)
    let wofYellow = UIColor(red: 242/255, green: 183/255, blue: 5/255, alpha: 1)
    
    @State var degrees = 0.0
    @State var color = ""
    @State var reward = "Drehe das Rad und probiere dein Glück!"
    @State var showLPPopup = false
    @State var OutofSpin = false
    @State private var animate = false
    var levelSystem = Levelsystem(loyaltyPoints: StreakLPHandler.shared.streakHistory!.loyaltyPoints)
    
    var wheelVM = WheelViewModel()
    var spins: Int {
        return wheelVM.getNoOfSpin(level: levelSystem.getLevel())
    }
    @State var bounce1 = false
    @State var bounce2 = true
    @State var isSpining = false
    @State var disabled = false
    @State var showPrize = false
    var tooltipConfig = DefaultTooltipConfig()
    
    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [.white, KauflandColors.loyaltyPrimary.swiftUI, KauflandColors.loyaltyPrimaryGradient.swiftUI]),
        startPoint: .top, endPoint: .bottom)
    
    init() {
        self.tooltipConfig.enableAnimation = true
//        self.tooltipConfig.animationOffset = 10
        self.tooltipConfig.animationTime = 1
    }
    
    fileprivate func createTriangle(_ i: Int, c: Color) -> some View {
        return Triangle()
            .fill(c.swiftUI)
            .frame(width: 125, height: 150)
            .cornerRadius(10)
            .padding(.top, 150)
            .rotationEffect(Angle(degrees: Double(45*i)))
        
    }
    
    fileprivate func createTrianglewStroke(_ i: Int, c: Color) -> some View {
        return Triangle()
            .stroke(.white, lineWidth: 1)
            .frame(width: 125, height: 150)
            .cornerRadius(10)
            .padding(.top, 150)
            .rotationEffect(Angle(degrees: Double(45*i)))
        
    }
    
    fileprivate func ResultEmoji() -> some View {
        return  Image(reward == "Drehe das Rad und probiere dein Glück!" ? "" : reward == "Leider nichts gewonnen!" ? "sadEmoji" : "partyPopper").resizable()
            .frame(width: 40, height: 40).clipped()
            //hier evtl. opacity und Farbe anpassen
            .background(Circle() .fill(KauflandColors.white.swiftUI.opacity(0))  .frame(width: 60, height: 60))
            .offset(y: bounce2 ? -6 : 0)
            .animation(reward == "Drehe das Rad und probiere dein Glück!" ? nil : Animation.linear(duration: 0.2).repeatForever())
            .onAppear(){
                bounce2.toggle()
            }
    }
    
    var body: some View {
        NavigationView {
        VStack {

            VStack{
                HStack{
                    Spacer()
                    Text("Verfügbare Spins: " + String(spins))
                        .animation(.default)
                        .font(Font(UIFont.body12))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(KauflandColors.white.swiftUI)
                                .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                                .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
                            )
                        .foregroundColor(KauflandColors.black.swiftUI)
                    
                    Spacer()
                    
                    Button {
                        showPrize = true
                    } label: {
                        HStack {
                            Image(systemName: "gift.fill")
                                .tint(KauflandColors.white.swiftUI)
                                .frame(width: 50, height: 50)
                        
                            Text("Preise")
                                .font(Font(UIFont.body12))
                                .bold()
                                .foregroundColor(KauflandColors.white.swiftUI)
                                .padding(.vertical, 0)
                                .padding(.trailing, 30)
                                .frame(alignment: .leading)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(KauflandColors.red.swiftUI)
                        )
                    }.padding(.horizontal, 0)
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 0)
                .zIndex(1)
                .sheet(isPresented: $showPrize, content: {
                    PrizeListView()   .presentationDetents([.fraction(0.4)])
                } )

                /**
                 Wheel of Fortune
                 */
                ZStack {
                    //KauflandColors.white.swiftUI.ignoresSafeArea()
                    VStack{
                        Spacer()
                        ZStack{
                            if isSpining  {
                                Image("question").resizable()
                                    .frame(width: 50, height: 50).clipped()
                                    .background(Circle() .fill(KauflandColors.red.swiftUI.opacity(0))  .frame(width: 100, height: 60))
                                    .foregroundColor(KauflandColors.yellow.swiftUI)
                                    .offset(y: bounce1 ? -6 : 0)
                                    .animation(reward == "Drehe das Rad und probiere dein Glück!" ? nil : Animation.linear(duration: 0.2).repeatForever())
                                        .onAppear(){
                                             bounce1 = false
                                        }
                            }
                            else {
                                HStack{
                                    ResultEmoji()
                                    ResultEmoji()
                                    ResultEmoji()
                                }
                            
                            }
                           
                                
                        }
                        
                        Spacer()
                        ZStack {
                            
                            ZStack{
                            
                                // yellow section
                                ForEach(5...5, id:\.self) { i in
                                    createTriangle(i, c: wofYellow)
                                    createTrianglewStroke(i, c: wofYellow)
                                }
                                ForEach(1...1, id:\.self) { i in
                                    createTriangle(i, c: wofYellow)
                                    createTrianglewStroke(i, c: wofYellow)
                                }
                                
                                // blue section
                                ForEach(2...2, id:\.self) { i in
                                    createTriangle(i, c: wofBlue)
                                    createTrianglewStroke(i, c: wofBlue)
                                }
                                ForEach(7...7, id:\.self) { i in
                                    createTriangle(i, c: wofBlue)
                                    createTrianglewStroke(i, c: wofBlue)
                                }
                                
                                // orange section
                                ForEach(0...0, id:\.self) { i in
                                    createTriangle(i, c: wofPink)
                                    createTrianglewStroke(i, c: wofPink)
                                }
                                
                                ForEach(6...6, id:\.self) { i in
                                    createTriangle(i, c: wofPink)
                                    createTrianglewStroke(i, c: wofPink)
                                }
                                
                                ForEach(3...3, id:\.self) { i in
                                    createTriangle(i, c: wofPink)
                                    createTrianglewStroke(i, c: wofPink)
                                }
                                
                                //green section
                                ForEach(4...4, id:\.self){ i in
                                    createTriangle(i, c: wofGreen)
                                    createTrianglewStroke(i, c: wofGreen)
                                }
                                
                            }
                            // add rotation animation
                            .rotationEffect(Angle(degrees: degrees))
                            .animation(animate ? .easeInOut(duration: 3) : nil)
                            
                            // circle outline
                            Circle()
                                .stroke(lineWidth: 20)
                                .fill(KauflandColors.black.swiftUI)
                                .frame(width: 320)
                            
                            // middle dot
                            Button{
                                disabled = true
                                reward = "..."
                                bounce1.toggle()
                                isSpining = true
                                
                                // spin the wheel
                                // spins-=1
                                if(spins <= 0){
                                    animate = false
                                    OutofSpin = true
                                } else if (spins == 1){
                                    animate = true
                                    spinWheel()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                        calcReward()
                                        isSpining = false
                                        if(spins>0){
                                            disabled = false
                                        }
                                    }
                                    wheelVM.haveSpinned()
                                } else {
                                    // re-enable button after spin
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                        disabled = false
                                        calcReward()
                                        isSpining = false
                                    }
                                    
                                    animate = true
                                    spinWheel()
                                    wheelVM.haveSpinned()
                                }
                            } label:{
                                Image(systemName: "hand.tap")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .background(Circle() .fill(spins <= 0 || disabled ? .secondary : KauflandColors.black.swiftUI).frame(width: 60, height: 60) )
                                
                            } .disabled(spins <= 0 || disabled)
                            
                            //                    Circle()
                            //                        .fill(KauflandColors.black.swiftUI)
                            //                        .frame(width: 70)
                            
                            // tiny black triangle at the top: determines on which section the wheel of fortune landed on
                            Triangle()
                                .fill(KauflandColors.black.swiftUI)
                                .frame(width: 20, height: 20)
                                .padding(.top, 280)
                                .rotationEffect(Angle(degrees: 180))
                            
                        }
                        Spacer()
                    }
                    
                }
                
                Spacer()
                
                         //   Text("Farbe: " + color)
                         //       .font(Font(UIFont.body11))
                
                Text(reward)
                    .animation(.default)
                    .font(Font(UIFont.body11))
                    .padding(18)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(KauflandColors.white.swiftUI)
                            .frame(width: 350, height: 50)
                            .shadow(color: disabled ? KauflandColors.gray.swiftUI : color == "grün" ? wofGreen.swiftUI : color == "gelb" ? wofYellow.swiftUI : color == "blau" ? wofBlue.swiftUI : color == "lila" ? wofPink.swiftUI : KauflandColors.lightGray.swiftUI, radius: 4, x: 0, y: 1)
                    )
                    .padding(.bottom, 50)
                
            }
            
            Spacer()
            
        }.background(backgroundGradient)
        }
    }
    
    
    
    /**
     Function that increases the degrees-variable on which the animation is based
     */
    func spinWheel() {
        
        // amount of full
        for _ in 1...5 {
            
            // one spin
            for _ in 1...360 {
                
                degrees+=1
                
            }
            
        }
        
        // calculate random value to land on a random section
        let randomInt = Int.random(in: 1...8)
        var x = randomInt * 45
        for _ in 1...x  {
            
            degrees+=1
            
        }
        
        
        
    }
    
    func calcReward() {
        
        // determine the reward
        color = calcColor()
        switch color {
        case "blau":
            reward = "+1 Spin. Dreh nochmal!"
            wheelVM.winSpin()
        case "gelb":
            reward = "5 Treuepunkte gewonnen!"
            StreakLPHandler.shared.updateLP(extraLP: 5)
        case "lila":
            reward = "Leider nichts gewonnen!"
        case "grün":
            reward = "10 Treuepunkte gewonnen!"
            StreakLPHandler.shared.updateLP(extraLP: 10)
        default:
            reward = "ERROR"
        }
    }
    
    /**
     Function that calculates on which section the wheel of fortune has landed on
     */
    func calcColor() -> String {
        
        var color = ""
        
        // triangle 1
        if(degrees.truncatingRemainder(dividingBy: 360.0) == 45.truncatingRemainder(dividingBy: 360.0)){
            color = "lila"
        }
        // triangle 2
        else if(degrees.truncatingRemainder(dividingBy: 360.0) == 90.truncatingRemainder(dividingBy: 360.0)){
            color = "blau"
        }
        // triangle 3
        else if(degrees.truncatingRemainder(dividingBy: 360.0) == 135.truncatingRemainder(dividingBy: 360.0)){
            color = "gelb"
        }
        // triangle 4
        else if(degrees.truncatingRemainder(dividingBy: 360.0) == 180.truncatingRemainder(dividingBy: 360.0)){
            color = "lila"
        }
        // triangle 5
        else if(degrees.truncatingRemainder(dividingBy: 360.0) == 225.truncatingRemainder(dividingBy: 360.0)){
            color = "blau"
        }
        // triangle 6
        else if(degrees.truncatingRemainder(dividingBy: 360.0) == 270.truncatingRemainder(dividingBy: 360.0)){
            color = "lila"
        }
        // triangle 7
        else if(degrees.truncatingRemainder(dividingBy: 360.0) == 315.truncatingRemainder(dividingBy: 360.0)){
            color = "gelb"
        }
        // triangle 8 (start triangle)
        else {
            color = "grün"
        }
        
        return color
        
    }
    
    // draws a triangle shape, src: https://www.hackingwithswift.com/books/ios-swiftui/paths-vs-shapes-in-swiftui
    struct Triangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            
            return path
        }
    }
    
    struct OutofSpinPopUp: View {
        var body: some View{
            Text("Du hast leider kein Spin mehr.")
                .foregroundColor(KauflandColors.black.swiftUI)
        }
    }
    
    
    struct WheelOfFortuneView_Previews: PreviewProvider {
        static var previews: some View {
            WheelOfFortuneView()
        }
    }
    
}
struct PrizeListView: View {
    
    /**
     Individual Colors for the Wheel of Fortune
     */
    let wofPink = UIColor(red: 242/255, green: 5/255, blue: 116/255, alpha: 1)
    let wofBlue = UIColor(red: 4/255, green: 217/255, blue: 217/255, alpha: 1)
    let wofGreen = UIColor(red: 171/255, green: 217/255, blue: 4/255, alpha: 1)
    let wofYellow = UIColor(red: 242/255, green: 183/255, blue: 5/255, alpha: 1)
     
     //create prize Text
     func prize_w_color(t: String, c: Color) -> HStack<TupleView<(some View, Text)>> {
         return HStack{
             Circle().fill(c.swiftUI).frame(width: 30, height: 30)
             Text(t)
                 .foregroundColor(c.swiftUI)
                 .font(Font(UIFont.boldKauflandFont(ofSize: 18.0)))
         }
     }
     
     var body: some View {
         ZStack{
             VStack (alignment: .leading) {
                 prize_w_color(t: "+1 Spin", c: wofBlue)
                 prize_w_color(t: "+5 Treuepunkte", c: wofYellow )
                 prize_w_color(t: "+10 Treuepunkte", c: wofGreen )
                 prize_w_color(t: "Nichts gewonnen", c: wofPink )
             }
         }
     }
     
 }

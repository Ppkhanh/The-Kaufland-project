//
//  ScrollingChallengeView.swift
//  MarketplaceApp
//
//  Created by Pham Phuong Khanh on 05.01.23.
//

import Foundation
import Combine
import SwiftUI

struct ExampleScrollView: View {
    let detector: CurrentValueSubject<CGFloat, Never>
    let publisher: AnyPublisher<CGFloat, Never>
    
    @State var stopped: Bool = false
    @State var started: Bool = false
    @State var still: Int = 0
    @State var timeRemaining = 120
    @State private var timeRemaining2 = 5
    @State var alertString1 = ""
    @State var alertString2 = ""
    @State var timer1 = Timer.publish(every: 1, on: .main, in: .common)
    @State var timer2 = Timer.publish(every: 1, on: .main, in: .common)
    @State var scrollDisabled: Bool = true
    @State var startDisabled: Bool = false
    @State var scrollLP = 0
    
    var prods = ScrollProduct().prodArr
    
    var levelSystem = Levelsystem(loyaltyPoints: StreakLPHandler.shared.streakHistory!.loyaltyPoints)
    var challengeVM = ChallengeViewModel()
    var tries: Int {
        return challengeVM.getNoOfTries(level: levelSystem.getLevel())
    }
    
    /**
        Increase Progressbar
     */
    private func increaseStepValue(timeRemaining: Int) -> Int {
        var value = 0
        if(timeRemaining <= 0) {
            value = 4
        }else if(timeRemaining > 0 && timeRemaining <= 30) {
            value = 3
        }else if(timeRemaining > 30 && timeRemaining <= 60) {
            value = 2
        }else if(timeRemaining > 60 && timeRemaining <= 90) {
            value = 1
        }
        return value
    }
    
    /* Calculate Scroll Loyalty Points based on the time scrolled and the current Level*/
    private func calculateScrollLP(timeRemaining: Int) -> Int {
        var level = levelSystem.getLevel()
        var scrollLoyaltyPoints = 0
        if(timeRemaining <= 0) {
            if(level == "Neuling") {
                scrollLoyaltyPoints = 8
            }else if(level == "Bronze") {
                scrollLoyaltyPoints = 12
            }else if(level == "Silber") {
                scrollLoyaltyPoints = 16
            }else if(level == "Gold") {
                scrollLoyaltyPoints = 24
            }else if(level == "Diamant") {
                scrollLoyaltyPoints = 32
            }
        }else if(timeRemaining > 0 && timeRemaining <= 30) {
            if(level == "Neuling") {
                scrollLoyaltyPoints = 6
            }else if(level == "Bronze") {
                scrollLoyaltyPoints = 9
            }else if(level == "Silber") {
                scrollLoyaltyPoints = 12
            }else if(level == "Gold") {
                scrollLoyaltyPoints = 18
            }else if(level == "Diamant") {
                scrollLoyaltyPoints = 24
            }
        }else if(timeRemaining > 30 && timeRemaining <= 60) {
            if(level == "Neuling") {
                scrollLoyaltyPoints = 4
            }else if(level == "Bronze") {
                scrollLoyaltyPoints = 6
            }else if(level == "Silber") {
                scrollLoyaltyPoints = 8
            }else if(level == "Gold") {
                scrollLoyaltyPoints = 12
            }else if(level == "Diamant") {
                scrollLoyaltyPoints = 16
            }
        }else if(timeRemaining > 60 && timeRemaining <= 90) {
            if(level == "Neuling") {
                scrollLoyaltyPoints = 2
            }else if(level == "Bronze") {
                scrollLoyaltyPoints = 3
            }else if(level == "Silber") {
                scrollLoyaltyPoints = 4
            }else if(level == "Gold") {
                scrollLoyaltyPoints = 6
            }else if(level == "Diamant") {
                scrollLoyaltyPoints = 8
            }
        }else {
            scrollLoyaltyPoints = 0
        }
        
        StreakLPHandler.shared.updateLP(extraLP: scrollLoyaltyPoints)
        
        return scrollLoyaltyPoints
    }
    
    func secondsToMinutesSeconds(seconds: Int) -> String {
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        
        if(seconds < 10) {
            return "\(minutes):0\(seconds)"
        }else {
            return "\(minutes):\(seconds)"
        }
        
    }
    
    private func instantiateTimer1() {
        self.timer1 = Timer.publish(every: 1, on: .main, in: .common)
        self.timer1.connect()
        return
    }
    
    // timer 2 will only be triggered when this method is called
    private func instantiateTimer2() {
        self.timer2 = Timer.publish(every: 1, on: .main, in: .common)
        self.timer2.connect()
        return
    }
    
    private func scrollEnable() -> Bool {
        if timeRemaining < 1 || timeRemaining2 < 1{
            return true
        }
        return false
        
    }
    //if time's up while the user stop scrolling, they lost
    private func lost() -> Bool{
        if timeRemaining2 < 1 {
            return true
        } else{
            return false
        }
    }
    
    //otherwise, they passed when time's up
    private func passed() -> Bool {
        if timeRemaining < 1 && timeRemaining2 != 0 && started {
            return true
        } else{
            return false
        }
    }
    
    init() {
        let detector = CurrentValueSubject<CGFloat, Never>(0)
        self.publisher = detector
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .dropFirst()
            .eraseToAnyPublisher()
        self.detector = detector
        prods.shuffle()
    }
    
    var body: some View {
        VStack(alignment: .center){
            
            VStack(alignment: .center){
                Text("Treuepunkte: +\(calculateScrollLP(timeRemaining: timeRemaining))")
                    .font(Font(UIFont.body12))
                    .foregroundColor(KauflandColors.white.swiftUI)
                    .animation(.default)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                           // .fill((startDisabled || tries <= 0) ? KauflandColors.redRibbon.swiftUI : KauflandColors.lightGray.swiftUI)
                            .fill(KauflandColors.redRibbon.swiftUI)
                        
                    )
                
                HStack {
                    HStack(spacing: 3) {
                        ForEach(0 ..< 4) { i in
                            VStack {
                                Text("\((i+1)*30)sek")
                                    .font(Font(UIFont.body12))
                                    
                                Rectangle().foregroundColor(i < increaseStepValue(timeRemaining: timeRemaining) ? KauflandColors.red.swiftUI :KauflandColors.lightGray.swiftUI.opacity(0.6))
                                    .frame(minHeight: 5)
                                    .clipShape(Capsule())
                            }
                        }
                      }
                      .padding(.horizontal, 13)
                }
                .padding(13)
                .bold()
                
                HStack{
                    
                    Spacer()
                    Spacer()
                    
                    NavigationLink(destination: ScrollManual()) {
                        Text("Anleitung")
                            .font(Font(UIFont.body12))
                            .foregroundColor(KauflandColors.black.swiftUI)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(KauflandColors.white.swiftUI)
                                    .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                                    .shadow(color: KauflandColors.lightGray.swiftUI, radius: 2, x: 0, y: 0)
                                )
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        //user can only scroll when they press start
                        if (challengeVM.challengeHistory!.tries>0){
                            scrollDisabled = false
                            startDisabled = true
                            //self.timer1.connect()
                            instantiateTimer1()
                            challengeVM.haveTried()
                            timeRemaining = 120
                            timeRemaining2 = 5
                        }
                        else if (tries <= 0) {
                            // when you want to add a message for no more tries left this day, this is the space for it
                            startDisabled = true
                        }
                        
                    }){
                        Text("Starten (\(String(tries)))")
                            .font(Font(UIFont.body12))
                            .foregroundColor(KauflandColors.white.swiftUI)
                            .animation(.default)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill((startDisabled || tries <= 0) ? KauflandColors.lightGray.swiftUI : KauflandColors.redRibbon.swiftUI)
                                
                            )
                    }   .disabled(startDisabled)
                        .onReceive(timer1){  time in
                            if timeRemaining > 0 {
                                if stopped == false {
                                    timeRemaining -= 1
                                    still += 1
                                }
                                //timeRemaining = timeRemaining
                                
                            } else {
                                print("Time's up!")
                                self.timer1.connect().cancel()
                                self.timer2.connect().cancel()
                                //Any other code that should happen after countdown
                                scrollDisabled = true
                                startDisabled = false
                                stopped = false
                                started = false
                            }
                        }
                    Spacer()
                    Spacer()
                    
                }
                
                Spacer()
                Text((stopped && timeRemaining > 0 && timeRemaining2 > 0) ? alertString1 : (still >= 5 && !started) ?
                     "Fang an zu scrollen! :)"   : "")
                //timer 2 only appears when user stops scrolling
                Text(stopped && timeRemaining > 0 ? "Zeit übrig: \(timeRemaining2)sek." : "").onReceive(timer2) { time in
                    if timeRemaining2 > 0 {
                        //self.timer.connect()
                        timeRemaining2 -= 1
                        
                    } else {
                        // This happens after Game Over/Loosing scroll challenge
                        timeRemaining2 = 0
                        print("Time out!")
                        self.timer2.connect().cancel()
                        self.timer1.connect().cancel()
                        //Any other code that should happen after countdown
                        
                        //Reset for next Scroll Challenge
                        scrollDisabled = true
                        startDisabled = false
                        stopped = false
                        started = false
                    }
                }
            }.frame(height: 200)
            
            Spacer()
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(1...20, id: \.self){ _ in
                    ForEach(prods,  id: \.self)  { prod in
                          
                        AsyncImage(url: URL(string: prod))  { image in
                            image.resizable()
                            .scaledToFill()
                          
                            
                        } placeholder: {
                            ProgressView()
                                .frame(width: 44, height: 44)
                                .background(Circle().fill(.white))
                        }
                        .frame(width: 300, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                        .shadow(color: KauflandColors.almostWhite.swiftUI, radius: 2, x: 0, y: 0)
                        .shadow(color: KauflandColors.lightGray.swiftUI, radius: 5, x: 0, y: 3)
                        
                    }
                    }
                    
                    .frame(maxWidth: .infinity)
                    .background(GeometryReader {
                        Color.clear.swiftUI.preference(key: ViewOffsetKey.self,
                                                       value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) {
                        detector.send($0)
                        stopped = false
                        //only when view's position changes means users has started scrolling
                        if $0 != 0 {
                            started = true
                            self.timer2.connect().cancel()
                        }
                        
                    }

            }
            }.overlay(
                    ZStack {
                        Label("\(secondsToMinutesSeconds(seconds: timeRemaining))min", systemImage: "clock")
                            .font(Font(UIFont.body12))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 15)
                            .foregroundColor(.white)
                    }.background(KauflandColors.redRibbon.swiftUI)
                        .cornerRadius(10)
                        .padding(10), alignment: .bottomLeading
                )
                .scrollDisabled(scrollDisabled || scrollEnable())
                .padding(.horizontal, 13)
                .coordinateSpace(name: "scroll")
                //publisher announces the scrollview when the user is scrolling or has stopped scrolling
                .onReceive(publisher) {
                    //these lines are performed once the user stops scrolling
                    if(startDisabled) {
                        stopped = true
                        alertString1 = "Weiter scrollen, um die Challenge zu meistern"
                        alertString2 = "Zeit: \(timeRemaining2)"
                        timeRemaining2 = 5
                        instantiateTimer2()
                        print("Stopped on: \($0)")
                    }
                }
                Spacer()
                
            }
            .sheet(isPresented: .constant(passed())  , content: {
                Text("Du hast die Challenge und \(calculateScrollLP(timeRemaining: timeRemaining)) Treuepunkte gewonnen! :)")  .presentationDetents([.fraction(0.4)])
            } )
            .sheet(isPresented: .constant(lost() && !passed()), content: {
                Text("Du hast zu lange aufgehört zu scrollen und \(calculateScrollLP(timeRemaining: timeRemaining)) Treuepunkte verdient.")  .presentationDetents([.fraction(0.4)])
            } )
            .sheet(isPresented: .constant(timeRemaining == 0 && !passed()), content: {
                Text("Du hast gar nicht gescrollt und damit 0 Treuepunkte verdient :(")  .presentationDetents([.fraction(0.4)])
            } )
            
        }
        
    }
    
    struct ViewOffsetKey: PreferenceKey {
        typealias Value = CGFloat
        static var defaultValue = CGFloat.zero
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value += nextValue()
        }
    }
    
    struct ScrollViewPreview: PreviewProvider {
        static var previews: some View {
            ExampleScrollView()
        }
    }

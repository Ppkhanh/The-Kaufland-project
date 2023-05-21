//
//  WheelViewModel.swift
//  MarketplaceApp
//
//  Created by Pham Phuong Khanh on 07.12.22.
//

import Foundation

struct SpinHistory: Codable {
    var spin: Int
    var haveSpinned: Bool
    var lastSpin: Date
}


class WheelViewModel{
    
    static let shared = WheelViewModel()
    @JSONDefaults<SpinHistory>(key: "spinHistory")  var spinHistory: SpinHistory?
    
//    init(){
//
//    }
//
    var calendar = Calendar(identifier: .gregorian)
    func getNoOfSpin(level: String) -> Int{
        if spinHistory == nil {
            spinHistory = SpinHistory(spin: 0, haveSpinned: false, lastSpin: .now)
        }
        if spinHistory!.haveSpinned == false || !calendar.isDateInToday( spinHistory!.lastSpin) {
                if level == "Neuling"{
                    spinHistory!.spin = 0
                }
                else if level ==  "Bronze" {
                    spinHistory!.spin = 1}
                else  if level ==  "Silber" {
                    spinHistory!.spin = 2}
                else  if level ==  "Gold" {
                    spinHistory!.spin = 3}
                else {
                    spinHistory!.spin = 4
                }
            return spinHistory!.spin
            } else{
                return spinHistory!.spin
            }
    }
    
    
    func haveSpinned(){
        WheelViewModel.shared.spinHistory!.lastSpin = .now
        spinHistory!.haveSpinned = true
        spinHistory!.spin -= 1
    }
    
    func winSpin(){
        spinHistory!.spin += 1
    }
    
    func addTestSpins() {
        spinHistory!.spin += 10
    }
}

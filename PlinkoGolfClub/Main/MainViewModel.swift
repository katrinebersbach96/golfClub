//
//  MainViewModel.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 29.08.2024.
//

import SwiftUI


class MainViewModel: ObservableObject {
    
    @Published var isMailShown = false
    
    
    func makeReservMessage(name: String, email: String, date: String, time: String, players: String, id: String, notion: String) -> String {
        let message = """
Type: "Tee Time"
Date: \(date)
Time: \(time)
Email: \(email)
Name: \(name)
Players: \(players)
MemberID: \(id)
Notion: \(notion)
"""
        return message
    }
    
    func makeSecondReservMessage(name: String, email: String, date: String, time: String, players: String, id: String, notion: String) -> String {
        let message = """
Type: "Range Training"
Date: \(date)
Time: \(time)
Email: \(email)
Name: \(name)
Players: \(players)
MemberID: \(id)
Notion: \(notion)
"""
        return message
    }

    
    func makeThirdReservMessage(name: String, email: String, date: String, id: String, notion: String) -> String {
        let message = """
Type: "Individual Lesson"
Date: \(date)
Email: \(email)
Name: \(name)
MemberID: \(id)
Notion: \(notion)
"""
        return message
    }
}


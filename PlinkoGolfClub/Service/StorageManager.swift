//
//  StorageManager.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 29.08.2024.
//

import Foundation
import RealmSwift


class StorageManager {
    static let shared = StorageManager()
    
    private init(){}
    
    let realm = try! Realm()
    @ObservedResults(RealmReservation.self) var reservations
    
    func addNewReservation(type: String, date: String, time: String?, players: String?, gameType: String?, playerID: String?, notion: String, selectedFormat: String?, isInstructorNeeded: Bool?, selectedTraining: String?, qrData: Data) {
        let reservation = RealmReservation()
        
        reservation.reservationType = type
        reservation.date = date
        reservation.time = time
        reservation.players = players
        reservation.gameType = gameType
        reservation.playerID = playerID
        reservation.notion = notion
        reservation.selectedFormat = selectedFormat
        reservation.isInstructorNeeded = isInstructorNeeded
        reservation.selectedFormat = selectedFormat
        reservation.qrData = qrData
        
        do {
            try realm.write {
                realm.add(reservation)
            }
        } catch {
            
        }
    }
}

//
//  RealmReservation.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 29.08.2024.
//

import Foundation
import RealmSwift


class RealmReservation: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var reservationType: String = ""
    @Persisted var date: String = ""
    @Persisted var time: String?
    @Persisted var players: String?
    @Persisted var gameType: String?
    @Persisted var playerID: String?
    @Persisted var notion = ""
    
    @Persisted var selectedFormat: String?
    @Persisted var isInstructorNeeded: Bool?
    @Persisted var selectedTraining: String?
    
    @Persisted var qrData: Data?
}




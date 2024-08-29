//
//  ReservationsView.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 27.08.2024.
//

import SwiftUI

struct ReservationsView: View {
    
    @State var reservations: [RealmReservation] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackView()
                
                VStack {
                    Text("Reservations")
                        .foregroundStyle(.white)
                        .font(.system(size: 38, weight: .bold, design: .serif))
                        .frame(width: size().width - 40, alignment: .leading)
                        .padding(.top, 60)
                    if reservations.isEmpty {
                        ScrollView {
                            Text("You don't have any reservations yet. \nYou can do this on the Home screen.")
                                .font(.system(size: 24, weight: .bold, design: .serif))
                                .foregroundStyle(.gray)
                                .padding(.horizontal, 60)
                                .multilineTextAlignment(.center)
                                .padding(.top, 40)
                            
                            Image(systemName: "figure.golf")
                                .font(.system(size: 132, weight: .bold, design: .serif))
                                .foregroundStyle(.gray.opacity(0.6))
                                .padding(.top, 40)
                                .padding(.bottom, 100)
                        }
                        .scrollIndicators(.hidden)
                    } else {
                        ScrollView {
                            ForEach(reservations.reversed(), id: \.id) { element in
                                ReservatiomnCell(item: element)
                            }
                            .padding(.bottom, 100)
                        }
                        .scrollIndicators(.hidden)
                        .padding(.top)
                    }
                 
                }
            }
            .onAppear {
                reservations = Array(StorageManager.shared.reservations)
            }
        }
    }
}

#Preview {
    ReservationsView()
}

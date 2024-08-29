//
//  ReservatiomnCell.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 29.08.2024.
//

import SwiftUI

struct ReservatiomnCell: View {
    
    var item: RealmReservation?
    @State var isDetailedShown = false
    
    var body: some View {
        ZStack {
            HStack {
                if let imageData = item?.qrData, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .interpolation(.none)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                
               
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(item?.reservationType ?? "")
                        .font(.system(size: 22, weight: .bold, design: .serif))
                    
                    Text(item?.date ?? "")
                        .font(.system(size: 18, weight: .light, design: .serif))
                    
                    if let time = item?.time {
                        Text(time)
                            .font(.system(size: 18, weight: .light, design: .serif))
                            
                    }
                    
                    if let gameType = item?.gameType {
                        Text(gameType)
                            .font(.system(size: 18, weight: .light, design: .serif))
                    }
                    
                    if let isInstructorNeeded = item?.isInstructorNeeded {
                        Text("Instructor: \(isInstructorNeeded ? "YES" : "NO")")
                            .font(.system(size: 18, weight: .light, design: .serif))
                    }
                    
                    if let selected = item?.selectedTraining {
                        Text(selected)
                            .font(.system(size: 18, weight: .light, design: .serif))
                    }
                }
                .foregroundColor(.white)
                .padding(.leading, 10)
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
            .frame(width: size().width - 85)
        }
        .onTapGesture {
            isDetailedShown.toggle()
        }
        .padding()
        .background {
            Color.darkPurple.opacity(0.8)
        }
        .cornerRadius(12)
        .sheet(isPresented: $isDetailedShown) {
            ZStack {
                VStack {
                    Text("Please show the QR to the manager.")
                        .foregroundColor(.gray)
                        .font(.system(size: 22, weight: .bold, design: .serif))
                        .padding(.bottom)
                    
                    if let imageData = item?.qrData, let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .interpolation(.none)
                            .resizable()
                            .frame(width: 350, height: 350)
                    }
                }
              
            }
            .presentationDetents([.height(500)])
        }
        .onAppear {
            
        }
    }
}

#Preview {
    ReservatiomnCell()
}

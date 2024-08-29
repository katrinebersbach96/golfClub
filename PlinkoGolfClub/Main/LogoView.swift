//
//  LogoView.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 27.08.2024.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Circle()
            .frame(width: size().width / 2, height: size().height / 4)
            .foregroundColor(.white)
            .shadow(color: .purple,radius: 10)
            .overlay {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size().width / 2, height: size().height / 5)
                    .offset(x: 3, y: 10)
            }
            
    }
}

#Preview {
    MainView(){}
}

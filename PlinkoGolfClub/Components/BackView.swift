//
//  BackView.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 27.08.2024.
//

import SwiftUI

struct BackView: View {
    var body: some View {
        Image("blurBG")
            .resizable()
            .scaledToFill()
            .frame(width: size().width, height: size().height)
            .ignoresSafeArea()
    }
}

#Preview {
    BackView()
}

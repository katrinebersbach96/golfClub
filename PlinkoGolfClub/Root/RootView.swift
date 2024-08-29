//
//  RootView.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 29.08.2024.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabMainView()
                    .environmentObject(viewModel)
            } else {
                LoginView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    RootView()
}

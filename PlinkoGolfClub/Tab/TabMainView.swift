//
//  TabMainView.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 27.08.2024.
//

import SwiftUI


struct TabMainView: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var current = "Home"
    @State private var isTabBarShown = true
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Rectangle()
                .foregroundColor(.black)
                .ignoresSafeArea()
            
            TabView(selection: $current) {
                
                MainView() {
                    isTabBarShown.toggle()
                }
                .environmentObject(authViewModel)
                    .tag("Home")
                
                ReservationsView()
                    .tag("Reservs")
                
                NewsView()
                    .tag("News")
                
                ProfileView()
                    .environmentObject(authViewModel)
                    .tag("Profile")
            }
            
            if isTabBarShown {
                
                HStack(spacing: 0) {
                    TabButton(title: "Home", image: "house", selected: $current)
                    
                    Spacer(minLength: 0)
                    
                    TabButton(title: "Reservs", image: "figure.golf", selected: $current)
                    
                    Spacer(minLength: 0)
                    
                    TabButton(title: "News", image: "newspaper", selected: $current)
                    
                    Spacer(minLength: 0)
                    
                    TabButton(title: "Profile", image: "person", selected: $current)
                }
                .padding(.bottom, size().height > 736 ? 0 : 10)
                .padding(.vertical)
                .padding(.horizontal)
                .background {
                    Rectangle()
                        .frame(width: size().width - 15, height: 80)
                        .cornerRadius(20)
                        .foregroundColor(.darkPurple)
                }
                .padding(.horizontal, 10)
                
            }
        }
        .onAppear {
            DataManager.shared.setInitailData()
        }
        .tint(.white)
    }
}

#Preview {
    TabMainView()
        .environmentObject(AuthViewModel())
}


struct TabButton: View {
    var title: String
    var image: String
    
    @Binding var selected: String
    
    var body: some View {
        Button {
            withAnimation(.spring) {
                selected = title
            }
        } label: {
            HStack(spacing: 10) {
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 27, height: 27)
                
                if selected == title {
                    Text(title)
                        .font(.system(size: 18))
                }
            }
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.white.opacity(selected == title ? 0.08 : 0))
            .clipShape(Capsule())
        }
    }
}


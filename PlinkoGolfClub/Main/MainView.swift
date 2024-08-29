//
//  MainView.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 27.08.2024.
//

import SwiftUI

struct MainView: View {
    
    var completion: () -> ()
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150, maximum: 250))
    ]
    private let selection = ["Book Tee Time", "Book The Range", "Individual Lessons"]
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var vm = MainViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                BackView()
                
                VStack {
                   LogoView()
                        .padding(.top, 50)
                    
                    ScrollView {
                        
                        LazyVGrid(columns: adaptiveColumn, spacing: 15) {
                            ForEach(selection, id:\.self) { type in
                                NavigationLink {
                                    switch type {
                                    case "Book Tee Time": 
                                        TeeTimeReservation(viewModel: vm) { completion() }
                                            .environmentObject(authViewModel)
                                            .onAppear {
                                                completion()
                                            }
                                            .navigationBarBackButtonHidden()
                                    case "Book The Range":
                                        RangeReservation(viewModel: vm) { completion() }
                                            .environmentObject(authViewModel)
                                            .onAppear {
                                                completion()
                                            }
                                            .navigationBarBackButtonHidden()
                                    case "Individual Lessons":
                                        LessonReservationView(viewModel: vm) { completion() }
                                            .environmentObject(authViewModel)
                                            .onAppear {
                                                completion()
                                            }
                                            .navigationBarBackButtonHidden()
                                    default:
                                        TeeTimeReservation(viewModel: vm) { completion() }
                                            .environmentObject(authViewModel)
                                            .navigationBarBackButtonHidden()
                                    }
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(.darkPurple)
                                            .frame(width: size().width / 2.3, height: size().height / 5)
                                           // .frame(width: 190, height: 150)
                                            .cornerRadius(12)
                                            .overlay {
                                                VStack {
                                                    Text(String(describing: type).uppercased())
                                                        .foregroundStyle(Color.white)
                                                        .font(.system(size: 20, weight: .light, design: .serif))
                                                        .frame(width: 150)
                                                    
                                                    Image(String(describing: type))
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 40, height: 40)
                                                        .colorInvert()
                                                }
                                            }
                                        
                                        
                                            
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    
                }
            }
        }
    }
}

//#Preview {
//    MainView(){}
//        .environmentObject(authViewModel)
//}

//
//  LoginView.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 29.08.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var isAlertShown = false
    @State private var switcher = false
    
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackView()
                VStack {
                    
                    LogoView()
                        .padding(.top, 20)
                    
                    VStack(spacing: 18) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: size().width - 40, height: 60)
                                .cornerRadius(12)
                                .overlay {
                                    HStack {
                                        Text("Email")
                                            .font(.system(size: 24, weight: .light, design: .serif))
                                            .foregroundStyle(.black)
                                        
                                        Spacer()
                                        
                                        TextField("your email", text: $email)
                                            .textInputAutocapitalization(.never)
                                            .autocorrectionDisabled()
                                            .frame(width: 165, alignment: .leading)
                                            .tint(.purple)
                                            .foregroundColor(.black)
                                            .padding(.trailing, 10)
                                            .textInputAutocapitalization(.none)

                                    }
                                    .padding(.leading, 20)
                                }
                        }
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: size().width - 40, height: 60)
                                .cornerRadius(12)
                                .overlay {
                                    HStack {
                                        Text("Password")
                                            .foregroundStyle(.black)
                                            .font(.system(size: 24, weight: .light, design: .serif))
                                        
                                        Spacer()
                                        
                                        SecureField("******", text: $password)
                                            .textInputAutocapitalization(.never)
                                            .autocorrectionDisabled()
                                            .frame(width: 165)
                                            .tint(.purple)
                                            .foregroundColor(.black)
                                            .colorMultiply(.black)
                                            .padding(.trailing, 10)
                                            .textInputAutocapitalization(.none)

                                    }
                                    .padding(.leading, 20)
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    Button {
                        viewModel.email = email
                        Task {
                            try await viewModel.signIn(email: email, password: password)
                        }
                        withAnimation {
                            isAlertShown.toggle()
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: size().width - 40, height: 70)
                                .cornerRadius(12)
                            
                            Text("LOG IN")
                                .foregroundStyle(.black)
                                .font(.system(size: 34, weight: .heavy, design: .serif))
                        }
                    }
                    .disabled(!isFormValid)
                    .opacity(isFormValid ? 1 : 0.5 )
                    .padding(.top, 24)
                    
                    Button {
                        Task {
                             await viewModel.signInAnonymously()
                        }
                        withAnimation {
                            isAlertShown.toggle()
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: size().width - 140, height: 45)
                                .cornerRadius(12)
                            
                            Text("ANONYMOUS LOG IN")
                                .foregroundStyle(.black)
                                .font(.system(size: 16, weight: .heavy, design: .serif))
                        }
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                    NavigationLink {
                        RegistrationView(viewModel: viewModel)
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("YOU DON’T HAVE AN ACCOUNT YET? SIGN UP NOW")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 16, weight: .light, design: .serif))
                            .frame(width: 300)
                    }
                    .padding(.top)
                    .padding(.bottom, 70)

                }
            }
        }
        .overlay {
            if isAlertShown {
                LottieEmptyStateView(fileName: "loading")
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        isAlertShown = false
                        switcher = true
                    }
                }
            }
        }
        .alert("Incorrect email or password.", isPresented: $switcher) {
            Button {
                switcher = false
            } label: {
                Text("Ok")
            }
        } message: {
            Text("")
        }

    }
}

extension LoginView: AuthViewModelProtocol {
    var isFormValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: AuthViewModel())
    }
}

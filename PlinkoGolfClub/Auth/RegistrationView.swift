//
//  RegistrationView.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 29.08.2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var confirmPassword = ""
    
    @State private var isAlertShown = false
    @State private var isNotificationShown = false
    @State private var switcher = false
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            BackView()
            
            ScrollView {
                VStack {
                    Text("Registration")
                        .foregroundStyle(.white)
                        .font(.system(size: 32, weight: .bold, design: .serif))
                        .padding(.top, 22)
                    
                    VStack(spacing: 24) {
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
                                        
                                        TextField("", text: $email)
                                            .textInputAutocapitalization(.never)
                                            .autocorrectionDisabled()
                                            .frame(width: 165, alignment: .leading)
                                            .tint(.purple)
                                            .foregroundColor(.black)
                                            .colorMultiply(.black)
                                            .padding(.trailing, 10)
                                            .textInputAutocapitalization(.never)

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
                                        Text("Full Name")
                                            .font(.system(size: 24, weight: .light, design: .serif))
                                            .foregroundStyle(.black)
                                        
                                        Spacer()
                                        
                                        TextField("", text: $fullname)
                                            .textInputAutocapitalization(.never)
                                            .autocorrectionDisabled()
                                            .frame(width: 165, alignment: .leading)
                                            .tint(.purple)
                                            .foregroundColor(.black)
                                            .colorMultiply(.black)
                                            .padding(.trailing, 10)
                                            .textInputAutocapitalization(.never)

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
                                        
                                        SecureField("", text: $password)
                                            .textInputAutocapitalization(.never)
                                            .autocorrectionDisabled()
                                            .frame(width: 165)
                                            .tint(.purple)
                                            .foregroundColor(.black)
                                            .colorMultiply(.black)
                                            .padding(.trailing, 10)
                                            .textInputAutocapitalization(.never)
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
                                        Text("Confirm Password")
                                            .foregroundStyle(.black)
                                            .font(.system(size: 24, weight: .light, design: .serif))
                                        
                                        Spacer()
                                        
                                        SecureField("", text: $confirmPassword)
                                            .textInputAutocapitalization(.never)
                                            .autocorrectionDisabled()
                                            .frame(width: 165)
                                            .tint(.purple)
                                            .foregroundColor(.black)
                                            .colorMultiply(.black)
                                            .padding(.trailing, 10)
                                            .textInputAutocapitalization(.never)
                                    }
                                    .padding(.leading, 20)
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    Button {
                        if isFormValid {
                            viewModel.fullName = fullname
                            viewModel.email = email
                            Task {
                                try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                            }
                            withAnimation {
                                isAlertShown.toggle()
                            }
                        } else {
                            isNotificationShown.toggle()
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: size().width - 40, height: 90)
                                .cornerRadius(12)
                            
                            Text("SIGN UP")
                                .foregroundStyle(.black)
                                .font(.system(size: 34, weight: .heavy, design: .serif))
                        }
                    }
                    .padding(.top, 40)
                    .alert("Incorrect Data Entered", isPresented: $isNotificationShown) {
                        Button {
                            isNotificationShown.toggle()
                        } label: {
                            Text("Ok")
                        }
                    } message: {
                        Text("Please enter valid information. \nEmail: Must include «‎@» and end with a valid domain, such as «‎.com». \nPassword: Must be longer than 6 characters.")
                    }

                    
                    Button {
                        dismiss()
                    } label: {
                        Text("ALREADY HAVE AN ACCOUNT?")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 16, weight: .light, design: .serif))
                            .frame(width: 300)
                    }
                    .padding(.top, 40)
                    
                    

                }
                .padding(.bottom, 100)
            }
            .scrollIndicators(.hidden)
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
        .alert("Incorrect data or a user with this email already exists.", isPresented: $switcher) {
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

extension RegistrationView: AuthViewModelProtocol {
    var isFormValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
        
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView( viewModel: AuthViewModel())
    }
}

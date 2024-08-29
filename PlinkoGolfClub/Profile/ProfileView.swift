//
//  ProfileView.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 29.08.2024.
//

import SwiftUI
import MessageUI


struct MailComposeView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let subject: String
    let recipientEmail: String
    let textBody: String
    var onComplete: ((MFMailComposeResult, Error?) -> Void)?
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject(subject)
        mailComposer.setToRecipients([recipientEmail])
        mailComposer.setMessageBody(textBody, isHTML: false)
        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposeView
        
        init(_ parent: MailComposeView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
            parent.onComplete?(result, error)
        }
    }
}

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var userCode = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackView()
                
                VStack {
                    HStack {
                        Text("PROFILE")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 34, weight: .heavy, design: .serif))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    
                    ScrollView {
                        
                        if authViewModel.currentuser != nil {
                            Rectangle()
                                .frame(width: size().width - 40, height: 70)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .padding(.top)
                                .overlay {
                                    HStack {
                                        Text("Name:")
                                            .foregroundStyle(.black.opacity(0.75))
                                            .font(.system(size: 22, weight: .semibold, design: .monospaced))
                                            .padding(.top)
                                            .frame(width: 85)
                                        
                                        Text("\(authViewModel.currentuser?.fullname ?? "")")
                                            .foregroundStyle(.black.opacity(0.75))
                                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                                            .padding(.top)
                                        
                                        Spacer()
                                    }
                                    .padding(.leading, 10)
                                }
                            
                            Rectangle()
                                .frame(width: size().width - 40, height: 70)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .padding(.top)
                                .overlay {
                                    HStack {
                                        Text("Email:")
                                            .foregroundStyle(.black.opacity(0.75))
                                            .font(.system(size: 22, weight: .regular, design: .monospaced))
                                            .padding(.top)
                                            .frame(width: 85)
                                        
                                        Text("\(authViewModel.currentuser?.email ?? "")")
                                            .foregroundStyle(.black.opacity(0.75))
                                            .font(.system(size: 16, weight: .light, design: .monospaced))
                                            .padding(.top)
                                        
                                        Spacer()
                                    }
                                    .padding(.leading, 10)
                                }
                            
                            Rectangle()
                                .frame(width: size().width - 40, height: 70)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .padding(.top)
                                .overlay {
                                    HStack {
                                        Text("Member ID:")
                                            .foregroundStyle(.black.opacity(0.75))
                                            .font(.system(size: 22, weight: .regular, design: .monospaced))
                                            .padding(.top)
                                            .frame(width: 155)
                                        
                                        Text("\(userCode)")
                                            .foregroundStyle(.black.opacity(0.75))
                                            .font(.system(size: 16, weight: .light, design: .monospaced))
                                            .padding(.top)
                                        
                                        Spacer()
                                    }
                                    .padding(.leading, 10)
                                }
                        }
                        
                        
                        Button {
                            if MFMailComposeViewController.canSendMail() {
                                viewModel.isSuggestionShown.toggle()
                            } else {
                                viewModel.isAlertShown.toggle()
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(.white)
                                    .frame(width: size().width - 40, height: 70)
                                    .cornerRadius(12)
                                
                                Text("Suggest an improvement")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 22, weight: .semibold, design: .serif))
                            }
                        }
                        .padding(.top, 40)
                        .sheet(isPresented: $viewModel.isSuggestionShown) {
                            MailComposeView(isShowing: $viewModel.isSuggestionShown, subject: "Improvement suggestion", recipientEmail: "katrinebersbach96@gmail.com", textBody: "")
                        }

                        Button {
                            if MFMailComposeViewController.canSendMail() {
                                viewModel.isErrorShown.toggle()
                            } else {
                                viewModel.isAlertShown.toggle()
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(.white)
                                    .frame(width: size().width - 40, height: 70)
                                    .cornerRadius(12)
                                
                                Text("Report a bug")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 22, weight: .semibold, design: .serif))
                            }
                        }
                        .sheet(isPresented: $viewModel.isErrorShown) {
                            MailComposeView(isShowing: $viewModel.isErrorShown, subject: "Error message", recipientEmail: "katrinebersbach96@gmail.com", textBody: "")
                        }
                        
                        Button {
                            viewModel.openPrivacyPolicy()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(.white)
                                    .frame(width: size().width - 40, height: 70)
                                    .cornerRadius(12)
                                
                                Text("Privacy Policy")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 22, weight: .semibold, design: .serif))
                            }
                        }
                        
                        Button {
                            authViewModel.signOut()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(.white)
                                    .frame(width: size().width - 80, height: 70)
                                    .cornerRadius(12)
                                
                                Text("Sign Out")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 22, weight: .semibold, design: .serif))
                            }
                        }
                        .padding(.bottom, authViewModel.currentuser == nil ? 120 : 0)
                        .padding(.top, 40)
                        
                        if authViewModel.currentuser != nil {
                            Button {
                                viewModel.isDeleteAlertShown.toggle()
                                
                            } label: {
                                Text("Delete Account")
                                    .foregroundStyle(.red)
                                    .font(.system(size: 18, weight: .semibold, design: .serif))
                            }
                            .padding(.top, 40)
                            .padding(.bottom, 120)
                        }
                       
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .onAppear {
                userCode = UserDefaults.standard.string(forKey: "code") ?? "18 22 04 02"
            }
        }
        .alert("Are you sure you want to delete your account?", isPresented: $viewModel.isDeleteAlertShown) {
            Button {
                authViewModel.deleteUserAccount { result in
                    switch result {
                    case .success():
                        print("Account deleted successfully.")
                        authViewModel.userSession = nil
                        authViewModel.currentuser = nil
                    case .failure(let error):
                        print("ERROR DELELETING: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Yes")
            }
            
            Button {
                viewModel.isDeleteAlertShown.toggle()
            } label: {
                Text("No")
            }
        } message: {
            Text("To access your reserves you will need to create a new account.")
        }
        .alert("Unable to send email", isPresented: $viewModel.isAlertShown) {
            Button {
                viewModel.isAlertShown.toggle()
            } label: {
                Text("Ok")
            }
        } message: {
            Text("Your device does not have a mail client configured. Please configure your mail or contact support on our website.")
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}

class ProfileViewModel: ObservableObject {
    
    @Published var isErrorShown = false
    @Published var isSuggestionShown = false
    @Published var isAlertShown = false
    @Published var isDeleteAlertShown = false
    
    func openPrivacyPolicy() {
        if let url = URL(string: "https://PGolfClub.shop/com.PGolfClub/Katrine_Bersbach/privacy") {
            UIApplication.shared.open(url)
        }
    }
}

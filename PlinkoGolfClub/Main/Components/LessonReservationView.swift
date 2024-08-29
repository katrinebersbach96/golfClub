//
//  LessonReservationView.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 29.08.2024.
//

import SwiftUI
import MessageUI

struct LessonReservationView: View {
    @ObservedObject var viewModel: MainViewModel
    var completion: () -> ()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var userID = ""
    
    @State var fullName = ""
    @State var number = ""
    @State var email = ""
    @State var date = Date()
    
    @State var playerID = ""
    @State var notion = ""
    
    @State var selectedTraining = "Mastering the Golf Swing"
    var trainings = ["Mastering the Golf Swing", "Putting Techniques and Precision", "Short Game Mastery", "Driving for Distance and Accuracy", "Course Management and Strategy", "Iron Play and Approach Shots", "Overcoming Common Swing Faults", "Mental Game and Focus", "Fitness and Flexibility for Golf", "Advanced Shot Shaping"]
    
    @State var messageAlert = false
@State var someAlert = false
    
    var body: some View {
        ZStack {
            BackView()
            
            VStack {
                
                Text("Reservation")
                    .font(.system(size: 32, weight: .bold, design: .serif))
                    .foregroundStyle(.white)
                    .padding(.top, 40)
                
                ScrollView {
                    
                    Rectangle()
                        .frame(width: size().width - 40, height: 1)
                        .foregroundColor(.purple.opacity(0.5))
                    
                    HStack {
                        Text("Full Name")
                            .foregroundColor(.white)
                        Spacer()
                        
                        TextField("", text: $fullName)
                            .multilineTextAlignment(.trailing)
                            .placeholder(when: fullName.isEmpty) {
                                Text("Your name")
                                    .frame(width: 200, alignment: .trailing)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 200, alignment: .trailing)
                            .foregroundColor(.white)
                            .tint(.white)
                        
                    }
                    .padding()
                    .background {
                        Color.darkPurple.opacity(0.75)
                    }
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    Rectangle()
                        .frame(width: size().width - 40, height: 1)
                        .foregroundColor(.purple.opacity(0.5))
                    
                    HStack {
                        Text("Email")
                            .foregroundColor(.white)
                        Spacer()
                        
                        TextField("", text: $email)
                            .multilineTextAlignment(.trailing)
                            .placeholder(when: email.isEmpty) {
                                Text("Your email")
                                    .frame(width: 200, alignment: .trailing)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 200, alignment: .trailing)
                            .foregroundColor(.white)
                            .tint(.white)
                        
                    }
                    .padding()
                    .background {
                        Color.darkPurple.opacity(0.75)
                    }
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    Rectangle()
                        .frame(width: size().width - 40, height: 1)
                        .foregroundColor(.purple.opacity(0.5))
                    
                    HStack {
                        Text("Phone")
                            .foregroundColor(.white)
                        Spacer()
                        
                        TextField("", text: $number)
                            .multilineTextAlignment(.trailing)
                            .placeholder(when: number.isEmpty) {
                                Text("Your phone number")
                                    .frame(width: 200, alignment: .trailing)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 200, alignment: .trailing)
                            .foregroundColor(.white)
                            .tint(.white)
                        
                    }
                    .padding()
                    .background {
                        Color.darkPurple.opacity(0.75)
                    }
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    Rectangle()
                        .frame(width: size().width - 40, height: 1)
                        .foregroundColor(.purple.opacity(0.5))
                    
                                        
                    HStack {
                        Text("Lesson Type")
                            .foregroundColor(.white)
                        Spacer()
                        
                        Picker("", selection: $selectedTraining) {
                            ForEach(trainings, id: \.self) { element in
                                Text(element)
                                    .foregroundStyle(.white)
                            }
                        }
                        .accentColor(.white)
                    }
                    .padding()
                    .background {
                        Color.darkPurple.opacity(0.75)
                    }
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    
                    Rectangle()
                        .frame(width: size().width - 40, height: 1)
                        .foregroundColor(.purple.opacity(0.5))
                    
                    DatePicker("Date", selection: $date, in: Date()..., displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .accentColor(.white)
                        .colorScheme(.dark)
                        .padding()
                        .background {
                            Color.darkPurple.opacity(0.75)
                        }
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .padding(.vertical)
                    
                    Rectangle()
                        .frame(width: size().width - 40, height: 1)
                        .foregroundColor(.purple.opacity(0.5))
                    
                    HStack {
                        Text("Membership ID")
                            .foregroundColor(.white)
                        Spacer()
                        
                        TextField("", text: $userID)
                            .multilineTextAlignment(.trailing)
                            .placeholder(when: userID.isEmpty) {
                                Text("Individual ID")
                                    .frame(width: 180, alignment: .trailing)
                                    .foregroundColor(.gray)
                            }
                            .keyboardType(.numberPad)
                            .frame(width: 180, alignment: .trailing)
                            .foregroundColor(.white)
                            .tint(.white)
                        
                    }
                    .padding()
                    .background {
                        Color.darkPurple.opacity(0.75)
                    }
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    Rectangle()
                        .frame(width: size().width - 40, height: 1)
                        .foregroundColor(.purple.opacity(0.5))
                    
                    HStack {
                        Text("Addition Info")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    TextEditor(text: $notion)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.white)
                        .frame(height: 200)
                        .background(Color.darkPurple.cornerRadius(12))
                        .tint(.white)
                        .padding(.horizontal, 20)
                    
                    Button {
                        if authViewModel.currentuser != nil {
                            if MFMailComposeViewController.canSendMail() {
                                viewModel.isMailShown.toggle()
                            } else {
                                someAlert.toggle()
                            }
                        } else {
                            messageAlert.toggle()
                        }
                         
                        
                    } label: {
                        Text("Make a Reserve")
                            .foregroundColor(.darkPurple)
                            .frame(width: 200, height: 40)
                    }
                    .tint(.white)
                    .buttonStyle(.borderedProminent)
                    .padding(.vertical)
                    .padding(.bottom, 100)
                }
                .scrollIndicators(.hidden)
            }
            
            VStack {
                Button {
                    completion()
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                }
                .padding(.top, 50)
                .frame(width: size().width - 40, alignment: .leading)
                
                Spacer()
            }
        }
        
        //MARK: - Message Alert
        .alert("Unable to send email", isPresented: $someAlert) {
            Button {
                someAlert.toggle()
            } label: {
                Text("Ok")
            }
        } message: {
            Text("Your device does not have a mail client configured. Please configure your mail or contact support on our website.")
        }
        .alert("Forbidden", isPresented: $messageAlert) {
            Button {
                authViewModel.signOut()
            } label: {
                Text("Yes")
            }
            
            Button {
                messageAlert.toggle()
            } label: {
                Text("No")
            }
        } message: {
            Text("You must be registered. Do you want to Sign Up?")
        }
        .onAppear {
            userID = UserDefaults.standard.string(forKey: "code") ?? "00000000"
            fullName = authViewModel.currentuser?.fullname ?? ""
            email = authViewModel.currentuser?.email ?? ""
        }
        .sheet(isPresented: $viewModel.isMailShown) {
            MailComposeView(isShowing: $viewModel.isMailShown, subject: "Order message", recipientEmail: "katrinebersbach96@gmail.com", textBody: viewModel.makeThirdReservMessage(name: fullName, email: email, date: formatDate(date), id: userID, notion: notion)) { result, error in
                switch result {
                case .cancelled:
                    print("Mail cancelled")
                case .saved:
                    print("Mail saved")
                case .sent:
                    print("Mail sent")
                    
                    dismiss()
                case .failed:
                    print("Mail failed: \(error?.localizedDescription ?? "Unknown error")")
                @unknown default:
                    print("Unknown result")
                }
                
            }
            .onDisappear {
                let code = DataManager.shared.createUserCode(isJoinded: true)
                let qrImage = DataManager.shared.generateQRCode(from: code)
                guard let qrData = qrImage?.pngData() else { return }
                
                StorageManager.shared.addNewReservation(type: "Individual Lesson", date: formatDate(date), time: nil, players: nil, gameType: nil, playerID: userID, notion: notion, selectedFormat: nil, isInstructorNeeded: nil, selectedTraining: selectedTraining, qrData: qrData)
            }
        }
        
    }
}

//#Preview {
//    LessonReservationView(){}
//}

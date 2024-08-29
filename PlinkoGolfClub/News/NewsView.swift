//
//  NewsView.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 27.08.2024.
//

import SwiftUI

struct NewsView: View {
    
    init() {
        UISegmentedControl.appearance().backgroundColor = .white
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.purple)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    
    @State var news: [News] = []
    @State var clubsNews: [ClubNews] = []
    @State private var selectedTab = "Club News"
    var tabs = ["Club News", "Golf News"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackView()
                
                VStack {
                    Text("Golf News")
                        .foregroundStyle(.white)
                        .font(.system(size: 38, weight: .bold, design: .serif))
                        .frame(width: size().width - 40, alignment: .leading)
                        .padding(.top, 60)
                    
                    Picker("", selection: $selectedTab) {
                        ForEach(tabs, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 20)
                    
                    switch selectedTab {
                    case "Club News":
                        ScrollView {
                            VStack {
                                ForEach(clubsNews, id: \.description) { newsElement in
                                    ClubNewsCell(newsElement: newsElement)
                                }
                            }
                            .padding(.bottom, 100)
                        }
                        .padding(.bottom, 100)
                        .scrollIndicators(.hidden)
                        .padding(.top)
                    case "Golf News":
                        ScrollView {
                            VStack {
                                ForEach(news, id: \.description) { newsElement in
                                    NewsCell(newsElement: newsElement)
                                }
                            }
                            .padding(.bottom, 100)
                        }
                        .padding(.bottom, 100)
                        .scrollIndicators(.hidden)
                        .padding(.top)
                    default: ScrollView{}
                    }
                    
                }
            }
        }
        .onAppear {
            NetworkManager.shared.fetchClubNews(as: ClubNews.self) { result in
                switch result {
                case .success(let data):
                    self.clubsNews = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            NetworkManager.shared.fetchNews { data, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                
                if let data = data {
                    news = data
                }
            }
        }
    }
}
#Preview {
    NewsView()
}

//
//  ClubNewsCell.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 27.08.2024.
//

import SwiftUI

struct ClubNewsCell: View {
    
    @State var newsElement: ClubNews?
    
    var body: some View {
        VStack {
            if let url = URL(string: newsElement?.image ?? "") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: size().width - 50, height: 185)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                        .controlSize(.large)
                        .tint(.white)
                        .frame(width: size().width - 40, height: 185)
                }
                
                Spacer()

                if let text = newsElement?.header {
                    Text(text)
                        .font(.system(size: 24, weight: .bold, design: .serif))
                        .foregroundStyle(.white)
                        .frame(width: size().width - 80, alignment: .leading)
                }
                
                if let text = newsElement?.description {
                    Text(text)
                        .font(.system(size: 20, weight: .light, design: .serif))
                        .foregroundStyle(.white)
                        .frame(width: size().width - 80, alignment: .leading)
                        .padding(.top)
                }
            }
        }
        .padding(.bottom)
        .background {
            Color.darkPurple
                .cornerRadius(12)
        }
     
    }
    
}

#Preview {
    NewsView()
}

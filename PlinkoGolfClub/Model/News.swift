//
//  News.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 27.08.2024.
//

import Foundation


// MARK: - News
struct News: Codable {
    let description, headline: String?
    let images: [ImageElement]
    let link: String?
    let published: String?
    let dataSourceIdentifier, type: String?
    let premium: Bool?
    let lastModified: String?
}

// MARK: - Image
struct ImageElement: Codable {
    let name: String?
    let width: Int?
    let alt, caption: String?
    let url: String?
    let height: Int?
}




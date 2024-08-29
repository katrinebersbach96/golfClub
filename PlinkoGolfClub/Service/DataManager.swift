//
//  DataManager.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 27.08.2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins



class DataManager {
    static let shared = DataManager()
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    private init(){}
    
    func getFirstMOCK() -> RealmReservation {
        let MOCK = RealmReservation()
        MOCK.reservationType = "Tee Time"
        MOCK.date = "22 Septemer 2024"
        MOCK.time = "18:00"
        MOCK.players = "12"
        MOCK.gameType = "Some Game Type"
        MOCK.notion = "Some LONG notion notion otionnot ionnotion notion notionnot ionnotionn otion  notion notion notion "
        
        let code = "12312333"
        let qr = generateQRCode(from: code)
        let image = qr?.pngData()
        
        MOCK.qrData = image
        
        return MOCK
    }
    
    func setInitailData() {
        if !UserDefaults.standard.bool(forKey: "user") {
            UserDefaults.standard.setValue(true, forKey: "user")
            UserDefaults.standard.setValue(createUserCode(isJoinded: false), forKey: "code")
        }
    }
    
    func createUserCode(isJoinded: Bool) -> String {
        let numbers = (0..<4).map { _ in
            String(format: "%02d", Int.random(in: 0...99))
        }.joined(separator: isJoinded ? " " : "")
        
        return numbers
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let urlString = "http://pgolfclub.com/reservation/%q31234/14443_123/\(string)"
        guard let data = urlString.data(using: .utf8) else { return nil }
        
        filter.message = data
        
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        
        return UIImage(systemName: "xmark.circle")
    }

    
    func getMOCK() -> News {
        
        let image = ImageElement(
                    name: "SVP unveils his 'Bad Beats' of the summer",
                    width: 576,
                    alt: "",
                    caption: "Scott Van Pelt and Stanford Steve review the worst betting breaks from across the sports world over the summer.",
                    url: "https://a.espncdn.com/media/motion/2024/0827/dm_240827_bad_beats_of_summer/dm_240827_bad_beats_of_summer.jpg",
                    height: 324
        )
        
        let news = News(
            description: "Scott Van Pelt and Stanford Steve review the worst betting breaks from across the sports world over the summer.",
               headline: "SVP unveils his 'Bad Beats' of the summer",
               images: [image],
               link: "https://www.espn.com/video/clip?id=41009257",
               published: "2024-08-27T05:08:32Z",
               dataSourceIdentifier: "a3a76d97783f1",
               type: "Media",
               premium: false,
               lastModified: "2024-08-27T05:08:31Z"
        )
        
        return news
    }
}

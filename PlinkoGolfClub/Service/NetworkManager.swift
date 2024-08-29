//
//  NetworkManager.swift
//  PlinkoGolfClub
//
//  Created by Danylo Klymenko on 27.08.2024.
//

import Foundation

enum CustomError: Error {
    case urlERROR
    case dataERROR
    case responseERROR
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init(){}

    
    func fetchClubNews<T: Decodable>(as type: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
        
        guard let url = URL(string: "https://api.jsonserve.com/RHbsEz") else {
            completion(.failure(CustomError.urlERROR))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(CustomError.responseERROR))
                return
            }
            
            guard let data = data else {
                completion(.failure(CustomError.dataERROR))
                return
            }
            
            do {
                let activities = try JSONDecoder().decode([T].self, from: data)
                completion(.success(activities))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchNews(completion: @escaping ([News]?, Error?) -> Void) {
     
        let headers = [
            "x-rapidapi-key": "8e29c60fefmsh7f0c7dab7fa1e48p1e7f5ajsn5445edcc0322",
            "x-rapidapi-host": "live-golf-data1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://live-golf-data1.p.rapidapi.com/news")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let _ = response as? HTTPURLResponse else {
                completion(nil, NSError(domain: "HTTPError", code: -1, userInfo: nil))
                print("Response error")
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "NoData", code: -1, userInfo: nil))
                print("Data error")
                return
            }
            
            do {
                let news = try JSONDecoder().decode([News].self, from: data)
                completion(news, nil)
            } catch {
                print("Decoder error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
        
        dataTask.resume()
    }
    
}

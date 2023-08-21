//
//  NetworkRquest.swift
//  RandMorty
//
//  Created by Максим Сулим on 18.08.2023.
//

import Foundation


class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    private init() {}
    
    func request(stringUrl: String, complition: @escaping(Result<Data,Error>) -> Void){
        
        guard let url = URL(string: stringUrl) else {
            return
        }
        
        DispatchQueue.global().async {
            
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, responce, error in
                DispatchQueue.main.async {
                    if let error = error {
                        complition(.failure(error))
                        return
                    }
                    guard let data = data else {
                        return
                    }
                    complition(.success(data))
                }
            }.resume()
            
        }
    }
}

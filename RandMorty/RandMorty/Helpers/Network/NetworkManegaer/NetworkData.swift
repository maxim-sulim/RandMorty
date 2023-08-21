//
//  NetworkData.swift
//  RandMorty
//
//  Created by Максим Сулим on 18.08.2023.
//

import Foundation



class NetworkData {
    
    static let shared = NetworkData()
    
    private init() {}
    
    
    func workDataStartRequest(urlString: String, responce: @escaping(StartRequestModel?, Error?) -> Void) {
        
        NetworkRequest.shared.request(stringUrl: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let resultData = try JSONDecoder().decode(StartRequestModel.self, from: data)
                    responce(resultData,nil)
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                responce(nil, error)
            }
        }
        
    }
    
    func workDataCharacters(urlString: String, responce: @escaping(CharactersApi?, Error?) -> Void) {
        
        NetworkRequest.shared.request(stringUrl: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let resultData = try JSONDecoder().decode(CharactersApi.self, from: data)
                    responce(resultData,nil)
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                responce(nil, error)
            }
        }
        
    }
    
    func workDataEpisodeChar(urlString: String, responce: @escaping(EpisodesChar?, Error?) -> Void) {
        
        NetworkRequest.shared.request(stringUrl: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let resultData = try JSONDecoder().decode(EpisodesChar.self, from: data)
                    responce(resultData,nil)
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                responce(nil, error)
            }
        }
    }
    
    
}

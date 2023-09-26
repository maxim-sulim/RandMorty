//
//  NetworkModel.swift
//  RandMorty
//
//  Created by Максим Сулим on 18.08.2023.
//

import Foundation


enum StartApi: String {
    case startApi = "https://rickandmortyapi.com/api"
}

struct StartRequestModel: Codable {
    let characters, locations, episodes: String
}

// MARK: - Characters
struct CharactersApi: Codable {
    let info: Info
    let results: [ResultChar]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String
    let prev: String?
}

// MARK: - Result
struct ResultChar: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

// MARK: - EpisodesChar
struct EpisodesChar: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

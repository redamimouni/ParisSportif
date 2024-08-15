//
//  LeagueListDTO.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 21/12/2023.
//

import Foundation

// MARK: - LeagueListDTO
public struct LeagueListDTO: Decodable, Equatable {
    public let leagues: [LeagueDTO]
}

// MARK: - League
public struct LeagueDTO: Decodable, Equatable {
    public let idLeague, strLeague, strSport: String
    public let strLeagueAlternate: String?
}

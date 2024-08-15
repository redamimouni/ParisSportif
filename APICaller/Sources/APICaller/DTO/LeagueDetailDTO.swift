//
//  LeagueDetailDTO.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import Foundation

// MARK: - LeagueDetailDTO
public struct LeagueDetailDTO: Decodable, Equatable {
    public let teams: [TeamDTO]
}

// MARK: - TeamDTO
public struct TeamDTO: Decodable, Equatable {
    public let idTeam: String
    public let strTeam: String
    public let strBadge: String
    public let strDescriptionEN: String?
    public let strBanner: String?
    public let strCountry: String
    public let strLeague: String
}

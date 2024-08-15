//
//  LeagueDetailDTO.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import Foundation

// MARK: - LeagueDetailDTO
struct LeagueDetailDTO: Decodable, Equatable {
    let teams: [TeamDTO]
}

// MARK: - TeamDTO
struct TeamDTO: Decodable, Equatable {
    let idTeam: String
    let strTeam: String
    let strBadge: String
    let strDescriptionEN: String
    let strBanner: String
    let strCountry: String
    let strLeague: String
}

extension TeamDTO {
    func toEntity() throws -> TeamEntity {
        guard let teamBadge = URL(string: self.strBadge),
              let teamBanner = URL(string: self.strBanner),
              let id = Int(self.idTeam)
        else { throw PSError.typeConversionError }
        return .init(
            id: id,
            name: self.strTeam,
            badgeImageUrl: teamBadge,
            bannerImageUrl: teamBanner,
            country: self.strCountry,
            league: self.strLeague,
            descriptionEN: self.strDescriptionEN
        )
    }
}

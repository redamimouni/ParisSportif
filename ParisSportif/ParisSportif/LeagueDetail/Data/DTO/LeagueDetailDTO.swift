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
}

extension TeamDTO {
    func toEntity() throws -> TeamEntity {
        guard let teamBadge = URL(string: self.strBadge) else { throw PSError.typeConversionError }
        return .init(name: self.strTeam, imageUrl: teamBadge)
    }
}

//
//  LeagueListDTO.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 21/12/2023.
//

import Foundation

// MARK: - LeagueListDTO
struct LeagueListDTO: Decodable, Equatable {
    let leagues: [LeagueDTO]
}

// MARK: - League
struct LeagueDTO: Decodable, Equatable {
    let idLeague, strLeague, strSport: String
    let strLeagueAlternate: String?
}

extension LeagueDTO {
    func toEntity() throws -> LeagueEntity {
        guard let idLeagueInt = Int(idLeague) else {
            throw PSError.typeConversionError
        }
        return LeagueEntity(idLeague: Int(idLeagueInt), strLeague: strLeague)
    }
}

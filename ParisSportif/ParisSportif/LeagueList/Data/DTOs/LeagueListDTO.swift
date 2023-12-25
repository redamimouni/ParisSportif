//
//  LeagueListDTO.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 21/12/2023.
//

import Foundation

// MARK: - LeagueListDTO
struct LeagueListDTO: Decodable, Equatable {
    let leagues: [League]
}

// MARK: - League
struct League: Decodable, Equatable {
    let idLeague, strLeague, strSport: String
    let strLeagueAlternate: String?
}

extension League {
    func toEntity() throws -> LeagueEntity {
        guard let idLeagueInt = Int(idLeague) else {
            throw PSError.typeConversionError
        }
        return LeagueEntity(idLeague: Int(idLeagueInt), strLeague: strLeague)
    }
}

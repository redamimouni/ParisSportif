//
//  Mocks.swift
//  ParisSportif
//
//  Created by Reda MIMOUNI (P) on 11/08/2024.
//

import Foundation

// MARK: - TeamDTO
public extension TeamDTO {
    static func mock(
        idTeam: String = "1",
        strTeam: String = "PSG",
        strBadge: String = "https://www.thesportsdb.com/images/media/team/badge/rwqrrq1473504808.png",
        strDescriptionEN: String = "Lorem ipsum",
        strBanner: String = "https://www.thesportsdb.com/images/media/team/banner/wvaw7l1641382901.jpg",
        strCountry: String = "France",
        strLeague: String = "Ligue 1"
    ) -> TeamDTO {
        return .init(
            idTeam: idTeam,
            strTeam: strTeam,
            strBadge: strBadge,
            strDescriptionEN: strDescriptionEN,
            strBanner: strBanner,
            strCountry: strCountry,
            strLeague: strLeague
        )
    }

    static var psg: TeamDTO {
        TeamDTO(
            idTeam: "1",
            strTeam: "PSG",
            strBadge: "https://www.thesportsdb.com/images/media/team/badge/rwqrrq1473504808.png",
            strDescriptionEN: "Lorem ipsum",
            strBanner: "https://www.thesportsdb.com/images/media/team/banner/wvaw7l1641382901.jpg",
            strCountry: "France",
            strLeague: "Ligue 1"
        )
    }

    static var marseille: TeamDTO {
        TeamDTO(
            idTeam: "2",
            strTeam: "Olympique de Marseille",
            strBadge: "https://www.thesportsdb.com/images/media/team/badge/rwqrrq1473504808.png",
            strDescriptionEN: "Loram ipsum",
            strBanner: "https://www.thesportsdb.com/images/media/team/banner/rutppp1420732910.jpg",
            strCountry: "France",
            strLeague: "Ligue 1"
        )
    }

    static var arsenal: TeamDTO {
        TeamDTO(
            idTeam: "3",
            strTeam: "Arsenal",
            strBadge: "https://www.thesportsdb.com/images/media/team/badge/uyhbfe1612467038.png",
            strDescriptionEN: "Lorem ipsum",
            strBanner: "https://www.thesportsdb.com/images/media/team/banner/24sngv1718273065.jpg",
            strCountry: "England",
            strLeague: "English Premier League"
        )
    }

    static var monaco: TeamDTO {
        TeamDTO(
            idTeam: "4",
            strTeam: "AS Monaco",
            strBadge: "https://www.thesportsdb.com/images/media/team/badge/exjf5l1678808044.png",
            strDescriptionEN: "Lorem ipsum",
            strBanner: "https://www.thesportsdb.com/images/media/team/banner/tyryrv1420578445.jpg",
            strCountry: "France",
            strLeague: "Ligue 1"
        )
    }
}

public extension LeagueDTO {
    static var mock: LeagueDTO {
        .init(idLeague: "4328",
              strLeague: "English Premier League",
              strSport: "Soccer",
              strLeagueAlternate: "Premier League, EPL")
    }
}

public extension LeagueDetailDTO {
    static func mock(teams: [TeamDTO] = [.mock()]) -> LeagueDetailDTO {
        return .init(teams: teams)
    }
}

public extension LeagueListDTO {
    static func mock(idLeague: String = "4328") -> LeagueListDTO {
        return LeagueListDTO(leagues: [.init(idLeague: idLeague,
                                             strLeague: "English Premier League",
                                             strSport: "Soccer",
                                             strLeagueAlternate: "Premier League, EPL")])
    }
}

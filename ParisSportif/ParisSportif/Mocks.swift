//
//  Mocks.swift
//  ParisSportifTests
//
//  Created by Reda MIMOUNI (P) on 15/08/2024.
//

import Foundation

// MARK: - TeamEntity
extension TeamEntity {
    static func mock(
        id: Int = 1,
        name: String = "PSG",
        badgeImageUrl: URL? = URL(string: "https://www.thesportsdb.com/images/media/team/badge/rwqrrq1473504808.png"),
        bannerImageUrl: URL? = URL(string: "https://www.thesportsdb.com/images/media/team/banner/wvaw7l1641382901.jpg"),
        country: String = "France",
        league: String = "Ligue 1",
        descriptionEN: String = "Lorem ipsum"
    ) -> TeamEntity {
        return .init(
            id: id,
            name: name,
            badgeImageUrl: badgeImageUrl,
            bannerImageUrl: bannerImageUrl,
            country: country,
            league: league,
            descriptionEN: descriptionEN
        )
    }

    static var psg: TeamEntity {
        TeamEntity(
            id: 1,
            name: "PSG",
            badgeImageUrl: URL(string: "https://www.thesportsdb.com/images/media/team/badge/rwqrrq1473504808.png"),
            bannerImageUrl: URL(string: "https://www.thesportsdb.com/images/media/team/banner/wvaw7l1641382901.jpg"),
            country: "France",
            league: "Ligue 1",
            descriptionEN: "Lorem ipsum"
        )
    }

    static var marseille: TeamEntity {
        TeamEntity(
            id: 2,
            name: "Olympique de Marseille",
            badgeImageUrl: URL(string: "https://www.thesportsdb.com/images/media/team/badge/rwqrrq1473504808.png"),
            bannerImageUrl: URL(string: "https://www.thesportsdb.com/images/media/team/banner/rutppp1420732910.jpg"),
            country: "France",
            league: "Ligue 1",
            descriptionEN: "Lorem ipsum"
        )
    }

    static var monaco: TeamEntity {
        TeamEntity(
            id: 4,
            name: "AS Monaco",
            badgeImageUrl: URL(string: "https://www.thesportsdb.com/images/media/team/badge/exjf5l1678808044.png"),
            bannerImageUrl: URL(string: "https://www.thesportsdb.com/images/media/team/banner/tyryrv1420578445.jpg"),
            country: "France",
            league: "Ligue 1",
            descriptionEN: "Lorem ipsum"
        )
    }

    static var arsenal: TeamEntity {
        TeamEntity(
            id: 3,
            name: "Arsenal",
            badgeImageUrl: URL(string: "https://www.thesportsdb.com/images/media/team/badge/uyhbfe1612467038.png"),
            bannerImageUrl: URL(string: "https://www.thesportsdb.com/images/media/team/banner/24sngv1718273065.jpg"),
            country: "England",
            league: "English Premier League",
            descriptionEN: "Lorem ipsum"
        )
    }
}

extension LeagueEntity {
    static func mock(strLeague: String = "Ligue 1") -> LeagueEntity {
        .init(idLeague: 1, strLeague: strLeague)
    }
}

extension LeagueModel {
    static func mock(nameLeague: String = "Ligue 1") -> LeagueModel {
        .init(idLeague: 1, nameLeague: nameLeague)
    }
}

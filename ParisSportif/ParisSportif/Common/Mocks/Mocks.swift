//
//  Mocks.swift
//  ParisSportif
//
//  Created by Reda MIMOUNI (P) on 11/08/2024.
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

// MARK: - TeamDTO
extension TeamDTO {
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


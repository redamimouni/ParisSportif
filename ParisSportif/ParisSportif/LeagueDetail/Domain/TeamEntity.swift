//
//  TeamEntity.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import Foundation

struct TeamEntity: Identifiable {
    let id: Int
    let name: String
    let badgeImageUrl: URL?
    let bannerImageUrl: URL?
    let country: String?
    let league: String?
    let descriptionEN: String?
}

extension TeamEntity: Comparable {
    static func < (lhs: TeamEntity, rhs: TeamEntity) -> Bool {
        return lhs.name < rhs.name
    }
}

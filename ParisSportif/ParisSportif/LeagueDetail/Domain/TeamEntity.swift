//
//  TeamEntity.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import Foundation

struct TeamEntity {
    let name: String
    let imageUrl: URL
}

extension TeamEntity: Comparable {
    static func < (lhs: TeamEntity, rhs: TeamEntity) -> Bool {
        return lhs.name < rhs.name
    }
}

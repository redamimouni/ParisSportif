//
//  APIEndPoints.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 21/12/2023.
//

import Foundation

struct APIEndpoints {
    static let listing = "https://www.thesportsdb.com/api/v1/json/50130162/all_leagues.php"
    static func searchAllTeams(for strLeague: String) -> String {
        return "https://www.thesportsdb.com/api/v1/json/50130162/search_all_teams.php?l=\(strLeague)"
    }
}

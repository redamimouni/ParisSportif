//
//  APIEndPoints.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 21/12/2023.
//

import Foundation

struct APIEndpoints {
    static let listing = "\(APIConstants.baseURL.rawValue)/api/v1/json/\(APIConstants.token.rawValue)/all_leagues.php"
    static func searchAllTeams(for strLeague: String) -> String {
        return "\(APIConstants.baseURL.rawValue)/api/v1/json/\(APIConstants.token.rawValue)/search_all_teams.php?l=\(strLeague)"
    }
}

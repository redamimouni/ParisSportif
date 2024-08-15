//
//  APIEndPoints.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 21/12/2023.
//

import Foundation

public struct APIEndpoints {
    public static let listing = "\(APIConstants.baseURL.rawValue)/api/v1/json/\(APIConstants.token.rawValue)/all_leagues.php"
    public static func searchAllTeams(for strLeague: String) -> String {
        return "\(APIConstants.baseURL.rawValue)/api/v1/json/\(APIConstants.token.rawValue)/search_all_teams.php?l=\(strLeague)"
    }
}

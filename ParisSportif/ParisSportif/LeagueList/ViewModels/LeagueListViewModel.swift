//
//  LeagueListViewModel.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 20/12/2023.
//

import Foundation

protocol LeagueListViewModelProtocol: ObservableObject {
    var suggestions: [LeagueModel] { get }

    func fetchLeagueList()
    func filterLeagueList(with key: String)
}

final class LeagueListViewModel: LeagueListViewModelProtocol {
    @Published var suggestions: [LeagueModel] = []
    private var cachedLeague: [LeagueModel] = [
        .init(idLeague: "1", nameLeague: "English Premier League"),
        .init(idLeague: "2", nameLeague: "Scottish Premier League"),
        .init(idLeague: "3", nameLeague: "German Bundesliga"),
        .init(idLeague: "4", nameLeague: "Spanish La Liga")
    ]

    func fetchLeagueList() {
        self.suggestions = self.cachedLeague
    }

    func filterLeagueList(with key: String) {
        let lowercasedPrefix = key.lowercased()
        self.suggestions = self.cachedLeague.filter {
            $0.nameLeague.lowercased().hasPrefix(lowercasedPrefix)
        }
    }
}

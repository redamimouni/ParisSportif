//
//  LeagueListViewModel.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 20/12/2023.
//

import Foundation

@MainActor
final class LeagueListViewModel: ObservableObject {
    private let useCase: any LeagueListUseCaseProtocol

    @Published var suggestions: [LeagueModel] = []
    @Published var isLoading: Bool = true
    @Published var error: Error?
    @Published var searchText: String = "" {
        didSet {
            self.filterLeagueList(with: searchText)
        }
    }
    let navigationTitle: String = "Master league"
    let emptyListMessage: String = "No league found."
    let promptMessage: String = "Search for a league"

    private var cachedLeagues: [LeagueModel] = []

    init(useCase: some LeagueListUseCaseProtocol = LeagueListUseCase()) {
        self.useCase = useCase
    }

    func fetchLeagueList() async {
        do {
            let leagueList = try await self.useCase.execute()
            self.cachedLeagues = leagueList.map {
                LeagueModel(idLeague: $0.idLeague, nameLeague: $0.strLeague)
            }
            self.suggestions = self.cachedLeagues
            self.isLoading = false
        } catch {
            self.error = error
            self.isLoading = false
        }
    }

    private func filterLeagueList(with key: String) {
        let lowercasedPrefix = key.lowercased()
        self.suggestions = self.cachedLeagues.filter {
            $0.nameLeague.lowercased().hasPrefix(lowercasedPrefix)
        }
    }
}

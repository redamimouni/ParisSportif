//
//  LeagueListViewModel.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 20/12/2023.
//

import Foundation

protocol LeagueListViewModelProtocol: ObservableObject {
    var suggestions: [LeagueModel] { get }
    var isLoading: Bool { get }
    var error: Error? { get set }
    var searchText: String { get set }
    var navigationTitle: String { get }
    var emptyListMessage: String { get }

    func fetchLeagueList()
}

final class LeagueListViewModel: LeagueListViewModelProtocol {
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

    private var cachedLeague: [LeagueModel] = []

    init(useCase: any LeagueListUseCaseProtocol = LeagueListUseCase()) {
        self.useCase = useCase
    }

    func fetchLeagueList() {
        Task { @MainActor in
            do {
                let leagueList = try await self.useCase.fetchLeagueList()
                self.cachedLeague = leagueList.map {
                    LeagueModel(idLeague: $0.idLeague, nameLeague: $0.strLeague)
                }
                self.suggestions = self.cachedLeague
                self.isLoading = false
            } catch {
                self.error = error
                self.isLoading = false
            }
        }
    }

    private func filterLeagueList(with key: String) {
        let lowercasedPrefix = key.lowercased()
        self.suggestions = self.cachedLeague.filter {
            $0.nameLeague.lowercased().hasPrefix(lowercasedPrefix)
        }
    }
}

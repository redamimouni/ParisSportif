//
//  LeagueListViewModel.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 20/12/2023.
//

import Foundation

protocol LeagueListViewModelProtocol: ObservableObject {
    var suggestions: [LeagueModel] { get }
    var error: Error? { get set }
    func fetchLeagueList()
    func filterLeagueList(with key: String)
}

final class LeagueListViewModel: LeagueListViewModelProtocol {
    private let useCase: any LeagueListUseCaseProtocol
    @Published var suggestions: [LeagueModel] = []
    @Published var error: Error?
    private var cachedLeague: [LeagueModel] = []

    init(useCase: any LeagueListUseCaseProtocol = LeagueListUseCase()) {
        self.useCase = useCase
    }

    func fetchLeagueList() {
        Task.init {
            do {
                let leagueList = try await self.useCase.fetchLeagueList()
                await MainActor.run {
                    self.cachedLeague = leagueList.map {
                        LeagueModel(idLeague: $0.idLeague, nameLeague: $0.strLeague)
                    }
                    self.suggestions = cachedLeague
                }
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }
        }
    }

    func filterLeagueList(with key: String) {
        let lowercasedPrefix = key.lowercased()
        self.suggestions = self.cachedLeague.filter {
            $0.nameLeague.lowercased().hasPrefix(lowercasedPrefix)
        }
    }
}

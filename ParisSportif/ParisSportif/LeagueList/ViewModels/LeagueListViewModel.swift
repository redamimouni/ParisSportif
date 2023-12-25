//
//  LeagueListViewModel.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 20/12/2023.
//

import Foundation

internal enum LoadingState: Equatable {
    case loading
    case success(suggestions: [LeagueModel])
    case failure
    case empty(message: String)
}

protocol LeagueListViewModelProtocol: ObservableObject {
    var viewModelState: LoadingState { get }
    var error: Error? { get set }
    func fetchLeagueList()
    func filterLeagueList(with key: String)
}

final class LeagueListViewModel: LeagueListViewModelProtocol {
    private let useCase: any LeagueListUseCaseProtocol
    @Published var viewModelState: LoadingState = .loading
    @Published var error: Error?
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
                self.viewModelState = .success(suggestions: cachedLeague)
            } catch {
                self.error = error
                self.viewModelState = .failure
            }
        }
    }

    func filterLeagueList(with key: String) {
        let lowercasedPrefix = key.lowercased()
        let filtred = self.cachedLeague.filter {
            $0.nameLeague.lowercased().hasPrefix(lowercasedPrefix)
        }
        self.viewModelState = filtred.isEmpty ? 
            .empty(message: "0 results, try another key word") :
            .success(suggestions: filtred)
    }
}

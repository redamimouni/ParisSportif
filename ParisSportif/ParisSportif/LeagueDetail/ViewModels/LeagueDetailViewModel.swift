//
//  LeagueDetailViewModel.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import Foundation

@MainActor
final class LeagueDetailViewModel: ObservableObject {
    @Published var teams: [TeamEntity] = []
    @Published var isLoading: Bool = true
    @Published var error: Error?

    private(set) var selectedLeague: LeagueModel
    private let useCase: any LeagueDetailUseCaseProtocol

    init(
        league: LeagueModel,
        useCase: some LeagueDetailUseCaseProtocol = LeagueDetailUseCase()
    ) {
        self.selectedLeague = league
        self.useCase = useCase
    }

    func fetchTeams() async {
        do {
            self.teams = try await self.useCase.execute(league: self.selectedLeague.nameLeague)
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.error = error
        }
    }
}

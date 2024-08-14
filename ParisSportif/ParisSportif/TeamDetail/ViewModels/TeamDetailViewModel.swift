//
//  TeamDetailViewModel.swift
//  ParisSportif
//
//  Created by Reda MIMOUNI (P) on 11/08/2024.
//


import SwiftUI

final class TeamDetailViewModel: ObservableObject {

    @Published var team: TeamEntity

    init(team: TeamEntity) {
        self.team = team
    }
}

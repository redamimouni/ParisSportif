//
//  LeagueDetail.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 26/12/2023.
//

import SwiftUI

struct LeagueDetail: View {
    @StateObject var viewModel: LeagueDetailViewModel
    private let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(self.viewModel.teams, id: \.self) { team in
                    TeamView(team: team)
                }
            }
        }
        .errorAlert(error: self.$viewModel.error)
        .onAppear(perform: {
            self.viewModel.fetchTeams()
        })
        .overlay(content: {
            if self.viewModel.isLoading {
                ProgressView()
            }
        })
    }
}

#Preview {
    LeagueDetail(viewModel: LeagueDetailViewModel(league: LeagueModel(idLeague: 1, nameLeague: "Ligue 1")))
}

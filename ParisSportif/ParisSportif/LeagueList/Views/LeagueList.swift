//
//  LeagueList.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 20/12/2023.
//

import SwiftUI

struct LeagueList: View {
    @ObservedObject var viewModel: LeagueListViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(self.viewModel.suggestions, id: \.self) { suggestion in
                    NavigationLink {
                        LeagueDetail(viewModel: LeagueDetailViewModel(league: suggestion))
                    } label: {
                        Text(suggestion.nameLeague)
                    }
                }
            }
            .errorAlert(error: self.$viewModel.error)
            .navigationTitle(self.viewModel.navigationTitle)
        }
        .overlay(content: {
            if self.viewModel.isLoading {
                ProgressView()
            } else if self.viewModel.suggestions.isEmpty {
                Text(self.viewModel.emptyListMessage)
            }
        })
        .navigationViewStyle(.stack)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: self.$viewModel.searchText, prompt: self.viewModel.promptMessage)
    }
}

#Preview {
    LeagueList(viewModel: LeagueListViewModel())
}

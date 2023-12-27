//
//  LeagueList.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 20/12/2023.
//

import SwiftUI

struct LeagueList<T : LeagueListViewModelProtocol>: View {
    @State var input: String = ""
    @ObservedObject private var viewModel: T

    init(viewModel: T = LeagueListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(self.viewModel.suggestions, id: \.self) { suggestion in
                    NavigationLink {
                        LeagueDetail()
                    } label: {
                        Text(suggestion.nameLeague)
                    }
                }
            }
            .onAppear {
                self.viewModel.fetchLeagueList()
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
        .searchable(text: self.$viewModel.searchText, prompt: "Search for a league")
    }
}

#Preview {
    LeagueList()
}

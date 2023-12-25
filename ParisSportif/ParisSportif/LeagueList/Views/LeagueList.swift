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
    private let progressView = ProgressView()

    init(viewModel: T = LeagueListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            TextField("Search by league", text: $input)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onChange(of: input) { _, newValue in
                    self.viewModel.filterLeagueList(with: newValue)
                }
            List {
                let suggestions = self.viewModel.viewModelState
                switch suggestions {
                case .loading:
                    self.progressView
                case .success(let suggestions):
                    ForEach(suggestions, id: \.self) { suggestion in
                        Text(suggestion.nameLeague)
                    }
                case .failure:
                    self.progressView.hidden()
                case .empty(message: let message):
                    Text(message)
                }
            }
        }.onAppear {
            self.viewModel.fetchLeagueList()
        }.errorAlert(error: self.$viewModel.error)
    }
}

#Preview {
    LeagueList()
}

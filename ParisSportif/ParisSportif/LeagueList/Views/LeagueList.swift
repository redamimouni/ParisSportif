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
        VStack {
            TextField("Search by league", text: $input)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onChange(of: input) { _, newValue in
                    self.viewModel.filterLeagueList(with: newValue)
                }
        }.onAppear(perform: {
            self.viewModel.fetchLeagueList()
        })
        List(self.viewModel.suggestions, id: \.self) { suggestion in
            ZStack {
                Text(suggestion.nameLeague)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    LeagueList()
}

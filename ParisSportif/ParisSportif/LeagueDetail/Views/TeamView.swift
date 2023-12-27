//
//  TeamView.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import SwiftUI

struct TeamView: View {
    private let team: TeamModel

    init(team: TeamModel) {
        self.team = team
    }

    var body: some View {
        VStack {
            AsyncImage(url: team.imageUrl, transaction: .init(animation: .bouncy)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image("team-placeholder", bundle: nil)
                @unknown default:
                    Image("team-placeholder", bundle: nil)
                }
            }.padding()
            Text(team.name)
        }
    }
}

#Preview {
    TeamView(team: .init(name: "Man City", imageUrl: URL(string: "https://www.thesportsdb.com/images/media/team/badge/vwpvry1467462651.png")))
}

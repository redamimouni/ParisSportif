//
//  TeamView.swift
//  ParisSportif
//
//  Created by reda.mimouni.ext on 27/12/2023.
//

import SwiftUI

struct TeamView: View {
    private let team: TeamEntity

    init(team: TeamEntity) {
        self.team = team
    }

    var body: some View {
        VStack {
            AsyncImage(url: team.badgeImageUrl, transaction: .init(animation: .bouncy)) { phase in
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
    TeamView(team: .psg)
}

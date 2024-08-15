//
//  TeamDetailView.swift
//  ParisSportif
//
//  Created by Reda MIMOUNI (P) on 11/08/2024.
//

import SwiftUI

struct TeamDetailView: View {
    
    @ObservedObject var viewModel: TeamDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if let teamBannerURL = viewModel.team.bannerImageUrl {
                    AsyncImage(url: teamBannerURL) { image in
                        image
                            .resizable()
                            .aspectRatio(1000 / 185, contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }
                VStack(alignment: .leading, spacing: 10) {
                    if let teamCountry = viewModel.team.country {
                        Text(teamCountry)
                            .font(.body)
                    }
                    if let teamLeague = viewModel.team.league {
                        Text(teamLeague)
                            .font(.title3)
                            .bold()
                    }
                    if let teamDescription = viewModel.team.descriptionEN {
                        Text(teamDescription)
                            .multilineTextAlignment(.leading)
                            .font(.body)
                    }
                }
                .padding(8)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(viewModel.team.name)
                        .bold()
                }
            }
        }
    }
}

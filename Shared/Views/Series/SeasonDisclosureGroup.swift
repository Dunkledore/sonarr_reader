//
//  SeriesViewSeasonDisclosureGroup.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-27.
//

import SwiftUI

struct SeasonDisclosureGroup: View {
    @State var isEnlarged = false
    var episodes = [Episode]()
    var season: Season
    var body: some View {
        DisclosureGroup(isExpanded: $isEnlarged, content: {
            ScrollView {
                VStack {
                    ForEach(episodes, id: \.self.id) {episode in
                        Text("\(episode.episodeNumber) \(episode.title)")
                    }
                }
            }
        }, label: {
            ZStack {

                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                Text("Season \(season.seasonNumber!)")
            }
        })
    }
}



struct SeasonDisclosureGroup_Previews: PreviewProvider {
    static var previews: some View {
        
        ScrollView {
            VStack {
                SeasonDisclosureGroup(episodes: EpisodeModel(showId: SeriesModel.sample[0].id!).seasons[0].episodes, season: SeriesModel.sample[0].seasons![0])
                SeasonDisclosureGroup(episodes: EpisodeModel(showId: SeriesModel.sample[0].id!).seasons[1].episodes, season: SeriesModel.sample[0].seasons![1])
            }
        }
    }
}

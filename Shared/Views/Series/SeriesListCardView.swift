//
//  MovieCardView.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-24.
//

import Foundation
import SwiftUI

struct SeriesListCardView: View {
    @EnvironmentObject var profileModel: ProfileModel
    @EnvironmentObject var dataService: DataService
    @ObservedObject var series: Series
    var body : some View {
        HStack(alignment: .top) {
            VStack {
                ZStack {
                    let posterDataImage = UIImage(data: series.posterData ?? Data())
                    let image = posterDataImage ?? UIImage(named: "default_poster")
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 110)
                        .cornerRadius(5)
                    if !series.attemptedPosterData {
                        ProgressView()
                    }
                }
            }
            VStack(alignment: .leading) {
                Text(series.title!)
                    .multilineTextAlignment(.leading)
                VStack(alignment: .leading) {
                    if series.monitored! {
                        HStack {
                            Image(systemName: "bookmark.fill")
                            Text("Monitored")
                        }
                    } else {
                        HStack() {
                            Image(systemName: "bookmark")
                            Text("Unmonitored")
                            
                        }
                    }
                    HStack {
                        Image(systemName: "person.fill")
                        Text(profileModel.getProfileNameForId(id: series.profileId!)).multilineTextAlignment(.leading)
                    }
                    HStack {
                        Image(systemName: "circle.fill")
                        Text(String(series.seasonCount!) + " seasons")
                    }
                }
            }
            //            Spacer()
            //            VStack() {
            //                Spacer()
            //                Image(systemName: "chevron.right")
            //                Spacer()
            //            }
        }
    }
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLink  {
            SeriesView(series: SeriesModel.sample[0], episodeModel: EpisodeModel(showId: SeriesModel.sample[0].id!))
        } label: {
            SeriesListCardView(series: SeriesModel.sample[0]).accentColor(.black)
        }
        .padding()
    }
}

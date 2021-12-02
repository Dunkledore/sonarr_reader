//
//  ShowView.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-24.
//

import Foundation
import SwiftUI

struct SeriesView: View {
    
    @EnvironmentObject var dataService: DataService
    @ObservedObject var series: Series
    @ObservedObject var episodeModel: EpisodeModel
    
    @Environment(\.dismiss) var dismiss
    
    var backButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
            }
        })
    }
    
    var body : some View {
        GeometryReader { g in
            if series.attemptedFanartData {
                ScrollView {
                    let fanartDataImage = UIImage(data: series.fanartData ?? Data())
                    let image = fanartDataImage ?? UIImage(named: "ed_fanart")
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(Rectangle()
                                  .fill(Color.black)
                                    .opacity(0.4))
                        .frame(minWidth: g.size.width, idealWidth: g.size.width, maxWidth: g.size.width, minHeight: 200, idealHeight: g.size.height/2, maxHeight: g.size.height/2, alignment: .topLeading)
                        .clipped()
                        .overlay(SeriesFanartOverlayView(series: series), alignment: .topLeading)
                    VStack(alignment: .leading) {
                        ForEach(episodeModel.seasons, id: \.self.seasonNumber) { season in
                            SeasonDisclosureGroup(episodes: season.episodes, season: series.seasons!.first(where: {$0.seasonNumber == season.seasonNumber})!)
                        }
                    }.padding()
                }
            } else {
                ZStack {
                    ProgressView()
                }
            }
        }
        .navigationBarTitle(series.title!, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear {
            series.getImageData(dataService: dataService, imageType: .fanart)
        }
    }
}


struct ShowView_Previews : PreviewProvider {
    static var previews : some View {
        SeriesView(series: SeriesModel.sample[1], episodeModel: EpisodeModel(showId: SeriesModel.sample[1].id!))
    }
}

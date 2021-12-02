//
//  SwiftUIView.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-25.
//

import SwiftUI


struct SeriesFanartOverlayView: View {
    var series: Series
    @EnvironmentObject var profileModel: ProfileModel
    var body: some View {
            VStack (alignment: .leading) {
                HStack {
                    if series.monitored! {
                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(height: 35.0)
                    } else {
                        Image(systemName: "bookmark")
                    }
                    Text(series.title!)
                        .font(.title)
                        .foregroundColor(.white)
                }
                HStack(alignment: .top) {
                    Text(String(series.runtime!) + " Minutes" )
                        .foregroundColor(Color.white)
                    HStack(spacing: 1) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color.red)
                        Text(String(Int(series.ratings!.value! * 10)) + "%")
                            .foregroundColor(Color.white)
                    }
                    Text(String(series.year!))
                        .foregroundColor(.white)
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(SeriesModel.getSeriesFanartOverlayInfoPairs(series: series, profileModel: profileModel), id: \.self) { pair in
                            SeriesFanartOverlayInfoView(icon: pair.icon, text: pair.text)
                        }
                    }
                }

                
                if series.overview != nil {
                        ScrollView(showsIndicators: false) {
                            Text(series.overview!)
                                .foregroundColor(.white)
                    }
                }
            }
            .padding()

        }
    }

struct ShowFanartOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            SeriesFanartOverlayView(series: SeriesModel.sample[2])
                .background(Rectangle())
                .frame(height: g.size.height*0.5)
        }
.previewInterfaceOrientation(.portrait)
    }
}

//The Rectangles with quick info under the title.
struct SeriesFanartOverlayInfoView: View {
    var icon: String
    var text: String
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 12)
            Text(text).font(.caption)
        }
        .padding(5)
        .background(Color("SeriesFanArtOverlayViewInfoTextBackground"))
        .cornerRadius(3)
        .foregroundColor(.white)
    }
}

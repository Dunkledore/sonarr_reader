//
//  ContentView.swift
//  Shared
//
//  Created by "" on 2021-11-23.
//


import SwiftUI

struct SeriesListView: View {
  @EnvironmentObject var seriesModel: SeriesModel
  @EnvironmentObject var profileModel: ProfileModel
  @EnvironmentObject var dataService: DataService
  var body: some View {
    NavigationView {
      
      List {
        ForEach(seriesModel.series, id: \.self.id) {series in
          //List(model.shows) {movie in
          NavigationLink  {
            SeriesView(series: series, episodeModel: EpisodeModel(dataService: dataService, showId: series.id!)).navigationBarTitle("All Shows")
          } label: {
            SeriesListCardView(series: series)
            //   }
          }
          
          
        }
      }.listStyle(InsetListStyle())
        .refreshable {
          seriesModel.updateRemoteShowData()
          profileModel.updateRemoteProfileData()
          
        }
    }
    
    
    
  }
}


struct SeriesList_Previews: PreviewProvider {
  static var previews: some View {
    let dataService = DataService(host: "10.0.0.3:8989", ssl: "http", apiKey: "API-KEY")
    SeriesListView().environmentObject(ProfileModel(dataService: dataService)).environmentObject(SeriesModel(dataService: dataService))
      .environmentObject(dataService)
  }
}


//
//  EntryView.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-29.
//

import SwiftUI

struct EntryView: View {
  @EnvironmentObject var dataService: DataService
  
  
  var body: some View {
    TabView {
      SeriesListView().environmentObject(SeriesModel(dataService: dataService))
        .tabItem {
          VStack {
            Image(systemName: "tv")
            Text("Shows")
          }
        }
        SystemView(systemModel: SystemModel(dataService: dataService), diskSpaceModel: DiskSpaceModel(dataService: dataService))
        .tabItem {
        VStack {
          Image(systemName: "desktopcomputer")
          Text("System")
        }
      }
    }
  }
}


struct EntryView_Previews: PreviewProvider {
  static var previews: some View {
    EntryView().environmentObject(DataService(host: "10.0.0.3", ssl: "https", apiKey: "API-KEY"))
  }
}

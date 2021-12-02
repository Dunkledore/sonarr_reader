//
//  SettingsView.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-30.
//

import SwiftUI

struct SystemView: View {
  var systemModel: SystemModel
  var diskSpaceModel: DiskSpaceModel
  @State var isConnectionAlertPresented = false
  
  
  var body: some View {
    VStack {
      if systemModel.hasAttemptedLoading {
        if systemModel.system != nil {
          ScrollView {
            VStack(alignment: .leading, spacing: 10) {
              Text("Health")
                .font(.largeTitle)
              Divider()
              if 1 == 2 { //Implement checking for health messages
              } else {
                Text("All working as normal")
              }
              Text("Disk Space")
                .font(.largeTitle)
              Divider()
              if 1 == 1 {//Implement disk space4
                Text("implement me")
              } else {
                Text("Can't fetch any disks")
              }
              
              Text("About")
                .font(.largeTitle)
              Divider()
              VStack(alignment: .leading) {
                ForEach(SystemModel.getAboutPairs(system: systemModel.system!), id: (\.self.0)) { aboutPair in
                  HStack(alignment: .top) {
                    Text(aboutPair.0).bold()
                    if let markdown = SystemModel.getMarkdownText(for: aboutPair.1) {
                      Text(markdown)//TODO CONVERT TO TABLE
                    }
                  }
                }
              }.padding()
              Spacer()
            }.padding().navigationBarHidden(true)
          }
        } else {
          HStack {
            Text("Could not connect")
          }.onAppear {
            isConnectionAlertPresented = true
          }
          .alert("Could Not Connect to Server", isPresented: $isConnectionAlertPresented) {
            Button("OK", role: .cancel) { }
          }
        }
      } else {
        ProgressView()
        Text(String(systemModel.hasAttemptedLoading))
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SystemView(systemModel: SystemModel(dataService: DataService(host: "10.0.0.3:8989", ssl: "http", apiKey: "API-KEY")), diskSpaceModel: DiskSpaceModel(dataService: DataService(host: "10.0.0.3:8989", ssl: "http", apiKey: "API-KEY")))
  }
}

//
//  sonarr_readerApp.swift
//  Shared
//
//  Created by "" on 2021-11-23.
//

import SwiftUI

@main
struct sonarr_readerApp: App {
    
    var body: some Scene {
        WindowGroup {
            EntryView().environmentObject(DataService(host: "10.0.0.3", ssl: "https", apiKey: "API-KEY"))
            .environmentObject(ProfileModel(dataService: DataService(host: "10.0.0.3", ssl: "https", apiKey: "API-KEY")))
        }
    }
}

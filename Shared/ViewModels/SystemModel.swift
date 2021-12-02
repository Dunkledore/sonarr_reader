//
//  SystemModel.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-30.
//

import Foundation

class SystemModel: ObservableObject {
  @Published var system: System?
  @Published var hasAttemptedLoading = false
  var dataService: DataService
  
  
  init(dataService: DataService) {
    self.dataService = dataService
    self.updateRemoteSystemData()
  }
  
  func updateDataService(dataService: DataService) {
    self.dataService = dataService
  }
  
  func updateDataServiceAndReloadSeriesData(dataService: DataService) {
    updateDataService(dataService: dataService)
    updateRemoteSystemData()
  }
  
  static func getAboutPairs(system: System) -> [(String, String)] {
    var aboutPairs = [(String, String)]()
    aboutPairs.append(("Version", system.version ?? "Unknown"))
    aboutPairs.append(("Package Version", (system.packageVersion ?? "Unkown") + " by " + (system.packageAuthor ?? "Unkown")))
    aboutPairs.append(("Mono Version", system.mode ?? "Unknown"))
    aboutPairs.append(("App Data Directory", system.appData ?? "Unknown"))
    aboutPairs.append(("Startup Directory", system.startupPath ?? "Unknown"))
    aboutPairs.append(("Mode", system.mode ?? "Unknown"))
    aboutPairs.append(("Uptime", system.startTime ?? "Unknown")) //TODO IMPLEMENT TIME CALCULATION


    return aboutPairs
    
  }
  
  static func getMarkdownText(for markdown: String) -> AttributedString? {
    do {
      return try AttributedString(markdown: markdown)
    } catch {
      return nil
    }
  }
  
  func updateRemoteSystemData() {
    var urlComponents = URLComponents(string: "\(dataService.ssl)://\(dataService.host)/api/v3/system/status")
    urlComponents?.queryItems = [URLQueryItem(name: "apikey", value: dataService.apiKey)]
    let url = urlComponents?.url
    guard url != nil else {
      return
    }
    let request = URLRequest(url: url!)
    let session = URLSession.shared
    session.dataTask(with: request) { data, response, error in
      guard error == nil else {
        self.hasAttemptedLoading = true
        return
      }
      do {
        let decoder = JSONDecoder()
        let systemData = try decoder.decode(System.self, from: data!)
        DispatchQueue.main.async {
          self.system = systemData
          self.hasAttemptedLoading = true
        }
      } catch {
        print(error)
        self.hasAttemptedLoading = true
      }
    }
    .resume()
    return
  }
  
  
}

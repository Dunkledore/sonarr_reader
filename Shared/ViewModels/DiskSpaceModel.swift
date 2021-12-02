//
//  DiskSpaceModel.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-30.
//

import Foundation

class DiskSpaceModel: ObservableObject {
  @Published var disks = [DiskSpace]()
  private var dataService: DataService?
  
  init(dataService: DataService) {
    self.dataService = dataService
    self.updateRemoteDiskData()
  }
  
  func updateRemoteDiskData() {
    guard dataService != nil else {
        return
    }
    var urlComponents = URLComponents(string: "\(dataService!.ssl)://\(dataService!.host)/api/v3/diskSpace")
    urlComponents?.queryItems = [URLQueryItem(name: "apikey", value: dataService!.apiKey)]
    let url = urlComponents?.url
    guard url != nil else {
        return
    }
    let request = URLRequest(url: url!)
    let session = URLSession.shared
    session.dataTask(with: request) { data, response, error in
        guard error == nil else {
            return
        }
        do {
            let decoder = JSONDecoder()
            let disks = try decoder.decode([DiskSpace].self, from: data!)
            DispatchQueue.main.async {
                self.disks = disks
            }
        } catch {
            print(error)
        }
    }
    .resume()
    return
  }
  
  
}

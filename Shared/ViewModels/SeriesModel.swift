//
//  MovieModel.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-24.
//

import Foundation
import SwiftUI




class SeriesModel: ObservableObject {
    @Published var series = [Series]()
    private var dataService: DataService?
    
    init(dataService: DataService? = nil, from_local: Bool = false) {
        if from_local {
            updateLocalShowData()
        }   else {
            self.dataService = dataService!
            updateRemoteShowData()
        }
    }
    
    func updateDataService(dataService: DataService) {
        self.dataService = dataService
    }
    
    func updateDataServiceAndReloadSeriesData(dataService: DataService) {
        updateDataService(dataService: dataService)
        updateRemoteShowData()
    }
    
    func updateRemoteShowData() {
        guard dataService != nil else {
            return
        }
        var urlComponents = URLComponents(string: "\(dataService!.ssl)://\(dataService!.host)/api/series")
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
                let series = try decoder.decode([Series].self, from: data!)
                DispatchQueue.main.async {
                    self.series = series.sorted(by: { $0.sortTitle! < $1.sortTitle!})
                  for serie in self.series {
                    serie.getImageData(dataService: self.dataService!, imageType: .poster)
                  }
                }
            } catch {
                print(error)
            }
        }
        .resume()
        return
    }
    
    func updateLocalShowData() {
        let pathString = Bundle.main.path(forResource: "SeriesData", ofType: "json")
        
        guard pathString != nil else {
            self.series = [Series]()
            return
        }
        
        let url = URL(fileURLWithPath: pathString!)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let showData = try decoder.decode([Series].self, from: data)
            self.series = showData
            self.series = self.series.sorted(by: { $0.sortTitle! < $1.sortTitle!})
        } catch {
            print(error)
            self.series = [Series]()
        }
    }
    
    static func getFanartUrl(series: Series) -> String {
        return series.images!.first(where: {$0.coverType! == "fanart"})?.url! ?? "defaultFanart"
    }
    
    static func getSeriesFanartOverlayInfoPairs(series: Series, profileModel: ProfileModel) -> [InfoPair] {
        var infoPairs: [InfoPair] = []
        infoPairs.append(InfoPair(icon: series.monitored! ? "bookmark.fill" : "bookmark", text: series.monitored! ? "Monitored" : "Unmonitored"))
        if series.status != nil {
            let iconAndText = getStatusIconAndText(series: series)
            infoPairs.append(InfoPair(icon: iconAndText.0, text: iconAndText.1))
        }
        if series.sizeOnDisk != nil {
            let sizeOnDiskInGB = Double(series.sizeOnDisk!)/1000000000
            
            infoPairs.append(InfoPair(icon: "xserve", text: "\(Double(round(10*sizeOnDiskInGB)/10)) GB"))
        }
        if series.network != nil {
            infoPairs.append(InfoPair(icon: "tv", text: series.network!))
            infoPairs.append(InfoPair(icon: "folder.fill", text: series.path!))
            
        }
        infoPairs.append(InfoPair(icon:"person.fill", text: profileModel.getProfileNameForId(id: series.profileId!)))
        //TODO implement links
        //TODO implement profile
        return infoPairs
    }
    
    static func getStatusIconAndText(series: Series) -> (String, String) {
        switch series.status {
            case "continuing":
                return ("play.fill","Continuing")
            case "upcoming":
                return ("play.fill","Upcoming")
            case "ended":
                return ("square.fill","Ended")
            case "deleted":
                return ("trash.fill","Deleted")
            default:
                return ("questionmark", "Unknown Status")
        }
    }
    
}



extension SeriesModel {
    static var sample = SeriesModel(dataService: nil, from_local: true).series
    
    
}



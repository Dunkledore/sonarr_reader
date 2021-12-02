//
//  DataService.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-24.
//

import Foundation

class DataService: ObservableObject {
    var host: String
    var ssl: String
    var apiKey: String
    
    init(host: String, ssl: String, apiKey: String) {
        self.host = host
        self.ssl = ssl
        self.apiKey = apiKey
    }
    
    
//    static func getLocalShowData() -> [Series] {
//        let pathString = Bundle.main.path(forResource: "SeriesData", ofType: "json")
//        
//        guard pathString != nil else {
//            return [Series]()
//        }
//        
//        let url = URL(fileURLWithPath: pathString!)
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            let showData = try decoder.decode([Series].self, from: data)
//            //            for show in showData {
//            //                show.images.removeAll()
//            //                show.images.append(ImageWithMeta(coverType: "banner", url: "ed_banner", remoteUrl: "bleh"))
//            //                show.images.append(ImageWithMeta(coverType: "poster", url: "ed_poster", remoteUrl: "bleh"))
//            //                show.images.append(ImageWithMeta(coverType: "fanart", url: "ed_fanart", remoteUrl: "bleh"))
//            //            }
//            return showData
//        } catch {
//            print(error)
//            return [Series]()
//        }
//    }
    
//    static func getLocalEpisodeData(showId: Int) -> [Episode] {
//        let pathString = Bundle.main.path(forResource: "EpisodeData"+String(showId), ofType: "json")
//
//        guard pathString != nil else {
//            return [Episode]()
//        }
//
//        let url = URL(fileURLWithPath: pathString!)
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            let episodeData = try decoder.decode([Episode].self, from: data)
//            return episodeData
//        } catch {
//            print(error)
//            return [Episode]()
//        }
//    }
    
    static func getLocalProfileData() -> [Profile] {
        let pathString = Bundle.main.path(forResource: "ProfileData", ofType: "json")
        
        guard pathString != nil else {
            return [Profile]()
        }
        
        let url = URL(fileURLWithPath: pathString!)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let profileData = try decoder.decode([Profile].self, from: data)
            return profileData
        } catch {
            print(error)
            return [Profile]()
        }
    }
}

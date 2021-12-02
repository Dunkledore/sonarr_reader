//
//  MovieModel.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-24.
//

import Foundation

class SeasonWithEpisodeData {
    var seasonNumber: Int
    var episodes = [Episode]()
    
    init(seasonNumber: Int) {
        self.seasonNumber = seasonNumber
        
    }
}



class EpisodeModel: ObservableObject {
    @Published var seasons = [SeasonWithEpisodeData]()
    private var rawEpisodes = [Episode]()
    private var dataService: DataService?
    private var showId: Int
    
    init(dataService: DataService? = nil, from_local: Bool = false, showId: Int) {
        self.showId = showId
        if from_local {
            updateLocalEpisodeData()
        }   else {
            self.dataService = dataService!
            updateRemoteEpisodeData()
        }
    }
    
//    init(showId: Int) {
//        let rawDataDecoded = EpisodeModel.getLocalEpisodeData(showId: showId)
//        self.setSeasons(rawData: rawDataDecoded)
//        self.seasons = self.seasons.sorted(by: {$0.seasonNumber > $1.seasonNumber})
//    }
    
    func orderEpisodes() {
        var orderedSeasons = [SeasonWithEpisodeData]()
        for episode in self.rawEpisodes {
            var season = orderedSeasons.first(where: { episode.seasonNumber == $0.seasonNumber})
            if season == nil {
                season = SeasonWithEpisodeData(seasonNumber: episode.seasonNumber)
                orderedSeasons.append(season!)
            }
            season!.episodes.append(episode)
            season!.episodes = season!.episodes.sorted(by: {$0.episodeNumber > $1.episodeNumber})
        }
        self.seasons = orderedSeasons
    }
    
    func updateRemoteEpisodeData() {
        guard dataService != nil else {
            return
        }
        var urlComponents = URLComponents(string: "\(dataService!.ssl)://\(dataService!.host)/api/episode")
        urlComponents?.queryItems = [URLQueryItem(name: "apikey", value: dataService!.apiKey), URLQueryItem(name: "seriesId", value: String(showId))]
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
                let episodes = try decoder.decode([Episode].self, from: data!)
                DispatchQueue.main.async {
                    self.rawEpisodes = episodes
                    self.orderEpisodes()
                }
            } catch {
                print(error)
            }
        }
        .resume()
        return
    }
    
    func updateLocalEpisodeData() {
        let pathString = Bundle.main.path(forResource: "EpisodeData"+String(showId), ofType: "json")
        
        guard pathString != nil else {
            self.rawEpisodes = [Episode]()
            return
        }
        
        let url = URL(fileURLWithPath: pathString!)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let episodeData = try decoder.decode([Episode].self, from: data)
            self.rawEpisodes = episodeData
            orderEpisodes()
            
        } catch {
            print(error)
            self.rawEpisodes = [Episode]()
        }
    }
}



extension EpisodeModel {
    static var sample = EpisodeModel(dataService: nil, from_local: true, showId: 0)
}

   



struct ImageWithMeta: Decodable{
    var coverType: String?
    var url: String?
    var remoteUrl: String?
    var imageData: String?
    
    
}


struct Ratings: Decodable {
    let votes: Int?
    let value: Double?
}

struct Statistic: Decodable  {
    var previousAiring: String?
    var episodeCount: Int?
    var totalEpisodeCount: Int?
    var sizeOnDisk: Int?
    var percentOfEpisodes: Int?
    
}


struct Season: Decodable {
    var seasonNumber: Int?
    var monitored: Bool?
    var statistics: Statistic?
    
}

struct AlternativeTitles: Decodable {
    var title: String?
    var seasonNumber: Int?
}

struct InfoPair: Hashable {
    var icon: String
    var text: String
    var id = UUID()
}

enum imageType {
    case banner
    case fanart
    case poster
}



import Foundation

class Series: Decodable, Identifiable, ObservableObject {
    
    @Published var posterData: Data?
    @Published var fanartData: Data?
    @Published var bannerData: Data?
    @Published var attemptedPosterData: Bool = false
    @Published var attemptedFanartData: Bool = false
    @Published var attemptedBannerData: Bool = false
    
    var title: String?
    var alternateTitles: [AlternativeTitles]?
    var sortTitle: String?
    var seasonCount: Int?
    var totalEpisodeCount, episodeCountInt, episodeFileCount, sizeOnDisk: Int?
    var status, overview: String?
    var previousAiring: String?
    var network: String?
    var airtime: String?
    var images: [ImageWithMeta]?
    var seasons: [Season]?
    var year: Int?
    var path: String?
    var profileId: Int?
    var languageProfileId: Int?
    var seasonFolder: Bool?
    var monitored: Bool?
    var useSceneNumbering: Bool?
    var runtime: Int?
    var tvdbId: Int?
    var tvRageId: Int?
    var tvMazeId: Int?
    var firstAired: String?
    var lastInfoSync: String?
    var seriesType: String?
    var cleanTitle: String?
    var imdbId: String?
    var titleSlug: String?
    var genres: [String]?
    var tags: [String]?
    var added: String?
    var ratings: Ratings?
    var qualityProfileId: Int?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case alternateTitles
        case sortTitle
        case seasonCount
        case totalEpisodeCount, episodeCountInt, episodeFileCount, sizeOnDisk
        case status, overview
        case previousAiring
        case network
        case airtime
        case images
        case seasons
        case year
        case path
        case profileId
        case languageProfileId
        case seasonFolder
        case monitored
        case useSceneNumbering
        case runtime
        case tvdbId
        case tvRageId
        case tvMazeId
        case firstAired
        case lastInfoSync
        case seriesType
        case cleanTitle
        case imdbId
        case titleSlug
        case genres
        case tags
        case added
        case ratings
        case qualityProfileId
        case id
    }
    
    func getImageData(dataService: DataService, imageType: imageType) {
        let imageUrl = getPosterUrl()
        // Check that image url isn't nil
        guard imageUrl != nil else {
            return
        }
        
        // Download the data for the image
        if let url = URL(string: "\(dataService.ssl)://\(dataService.host)\(imageUrl!)") {
              
            // Get a session
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    let group = DispatchGroup()
                    group.enter()
                    
                    DispatchQueue.main.async {
                        // Set the image data
                        switch imageType {
                            case .banner:
                                self.bannerData = data!
                            case .fanart:
                                self.fanartData = data!
                            case .poster:
                                self.posterData = data!
                        }
                        group.leave()
                    }
                    group.wait()
                } else {
                }
                DispatchQueue.main.async {
                    switch imageType {
                        case .banner:
                            self.attemptedBannerData = true
                        case .fanart:
                            self.attemptedFanartData = true
                        case .poster:
                            self.attemptedPosterData = true
                    }
                }
               
                
                
            }
            dataTask.resume()
            
        }
    }
    
    
    func getPosterUrl() -> String? {
        return self.images!.first(where: {$0.coverType! == "poster"})?.url!
    }
    
}

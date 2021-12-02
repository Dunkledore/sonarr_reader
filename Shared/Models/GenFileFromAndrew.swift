//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
//
//import Foundation
//
//// MARK: - WelcomeElement
//struct WelcomeElement: Codable {
//    let title: String
//    let alternateTitles: [AlternateTitle]
//    let sortTitle: String
//    let seasonCount: Int
//    let totalEpisodeCount, episodeCount, episodeFileCount, sizeOnDisk: Int?
//    let status: Status
//    let overview: String?
//    let previousAiring: Date?
//    let network, airTime: String?
//    let images: [Image]
//    let seasons: [Season]
//    let year: Int
//    let path: String
//    let profileID, languageProfileID: Int
//    let seasonFolder, monitored, useSceneNumbering: Bool
//    let runtime, tvdbID, tvRageID, tvMazeID: Int
//    let firstAired: Date?
//    let lastInfoSync: String
//    let seriesType: SeriesType
//    let cleanTitle: String
//    let imdbID: String?
//    let titleSlug: String
//    let certification: Certification?
//    let genres: [Genre]
//    let tags: [JSONAny]
//    let added: String
//    let ratings: Ratings
//    let qualityProfileID, id: Int
//    let nextAiring: Date?
//
//    enum CodingKeys: String, CodingKey {
//        case title, alternateTitles, sortTitle, seasonCount, totalEpisodeCount, episodeCount, episodeFileCount, sizeOnDisk, status, overview, previousAiring, network, airTime, images, seasons, year, path
//        case profileID
//        case languageProfileID
//        case seasonFolder, monitored, useSceneNumbering, runtime
//        case tvdbID
//        case tvRageID
//        case tvMazeID
//        case firstAired, lastInfoSync, seriesType, cleanTitle
//        case imdbID
//        case titleSlug, certification, genres, tags, added, ratings
//        case qualityProfileID
//        case id, nextAiring
//    }
//}
//
//// MARK: - AlternateTitle
//struct AlternateTitle: Codable {
//    let title: String
//    let seasonNumber, sceneSeasonNumber: Int?
//    let sceneOrigin, comment: String?
//}
//
//enum Certification: String, Codable {
//    case tv14 = "TV-14"
//    case tvG = "TV-G"
//    case tvMa = "TV-MA"
//    case tvPG = "TV-PG"
//    case tvY = "TV-Y"
//    case tvY7 = "TV-Y7"
//}
//
//enum Genre: String, Codable {
//    case action = "Action"
//    case adventure = "Adventure"
//    case animation = "Animation"
//    case anime = "Anime"
//    case children = "Children"
//    case comedy = "Comedy"
//    case crime = "Crime"
//    case documentary = "Documentary"
//    case drama = "Drama"
//    case family = "Family"
//    case fantasy = "Fantasy"
//    case gameShow = "Game Show"
//    case history = "History"
//    case homeAndGarden = "Home and Garden"
//    case horror = "Horror"
//    case martialArts = "Martial Arts"
//    case miniSeries = "Mini-Series"
//    case musical = "Musical"
//    case mystery = "Mystery"
//    case news = "News"
//    case reality = "Reality"
//    case romance = "Romance"
//    case scienceFiction = "Science Fiction"
//    case sport = "Sport"
//    case suspense = "Suspense"
//    case talkShow = "Talk Show"
//    case thriller = "Thriller"
//    case travel = "Travel"
//    case war = "War"
//    case western = "Western"
//}
//
//// MARK: - Image
//struct Image: Codable {
//    let coverType: CoverType
//    let url: String
//    let remoteURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case coverType, url
//        case remoteURL
//    }
//}
//
//enum CoverType: String, Codable {
//    case banner = "banner"
//    case fanart = "fanart"
//    case poster = "poster"
//}
//
//// MARK: - Ratings
//struct Ratings: Codable {
//    let votes: Int
//    let value: Double
//}
//
//// MARK: - Season
//struct Season: Codable {
//    let seasonNumber: Int
//    let monitored: Bool
//    let statistics: Statistics
//}
//
//// MARK: - Statistics
//struct Statistics: Codable {
//    let episodeFileCount, episodeCount, totalEpisodeCount, sizeOnDisk: Int
//    let percentOfEpisodes: Int
//    let previousAiring, nextAiring: Date?
//}
//
//enum SeriesType: String, Codable {
//    case anime = "anime"
//    case standard = "standard"
//}
//
//enum Status: String, Codable {
//    case continuing = "continuing"
//    case deleted = "deleted"
//    case ended = "ended"
//    case upcoming = "upcoming"
//}
//
//typealias Welcome = [WelcomeElement]
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
//
//class JSONCodingKey: CodingKey {
//    let key: String
//
//    required init?(intValue: Int) {
//        return nil
//    }
//
//    required init?(stringValue: String) {
//        key = stringValue
//    }
//
//    var intValue: Int? {
//        return nil
//    }
//
//    var stringValue: String {
//        return key
//    }
//}
//
//class JSONAny: Codable {
//
//    let value: Any
//
//    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
//        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
//        return DecodingError.typeMismatch(JSONAny.self, context)
//    }
//
//    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
//        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
//        return EncodingError.invalidValue(value, context)
//    }
//
//    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
//        if let value = try? container.decode(Bool.self) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self) {
//            return value
//        }
//        if let value = try? container.decode(Double.self) {
//            return value
//        }
//        if let value = try? container.decode(String.self) {
//            return value
//        }
//        if container.decodeNil() {
//            return JSONNull()
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
//        if let value = try? container.decode(Bool.self) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self) {
//            return value
//        }
//        if let value = try? container.decode(Double.self) {
//            return value
//        }
//        if let value = try? container.decode(String.self) {
//            return value
//        }
//        if let value = try? container.decodeNil() {
//            if value {
//                return JSONNull()
//            }
//        }
//        if var container = try? container.nestedUnkeyedContainer() {
//            return try decodeArray(from: &container)
//        }
//        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
//            return try decodeDictionary(from: &container)
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
//        if let value = try? container.decode(Bool.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(Double.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(String.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decodeNil(forKey: key) {
//            if value {
//                return JSONNull()
//            }
//        }
//        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
//            return try decodeArray(from: &container)
//        }
//        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
//            return try decodeDictionary(from: &container)
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
//        var arr: [Any] = []
//        while !container.isAtEnd {
//            let value = try decode(from: &container)
//            arr.append(value)
//        }
//        return arr
//    }
//
//    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
//        var dict = [String: Any]()
//        for key in container.allKeys {
//            let value = try decode(from: &container, forKey: key)
//            dict[key.stringValue] = value
//        }
//        return dict
//    }
//
//    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
//        for value in array {
//            if let value = value as? Bool {
//                try container.encode(value)
//            } else if let value = value as? Int64 {
//                try container.encode(value)
//            } else if let value = value as? Double {
//                try container.encode(value)
//            } else if let value = value as? String {
//                try container.encode(value)
//            } else if value is JSONNull {
//                try container.encodeNil()
//            } else if let value = value as? [Any] {
//                var container = container.nestedUnkeyedContainer()
//                try encode(to: &container, array: value)
//            } else if let value = value as? [String: Any] {
//                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
//                try encode(to: &container, dictionary: value)
//            } else {
//                throw encodingError(forValue: value, codingPath: container.codingPath)
//            }
//        }
//    }
//
//    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
//        for (key, value) in dictionary {
//            let key = JSONCodingKey(stringValue: key)!
//            if let value = value as? Bool {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? Int64 {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? Double {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? String {
//                try container.encode(value, forKey: key)
//            } else if value is JSONNull {
//                try container.encodeNil(forKey: key)
//            } else if let value = value as? [Any] {
//                var container = container.nestedUnkeyedContainer(forKey: key)
//                try encode(to: &container, array: value)
//            } else if let value = value as? [String: Any] {
//                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
//                try encode(to: &container, dictionary: value)
//            } else {
//                throw encodingError(forValue: value, codingPath: container.codingPath)
//            }
//        }
//    }
//
//    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
//        if let value = value as? Bool {
//            try container.encode(value)
//        } else if let value = value as? Int64 {
//            try container.encode(value)
//        } else if let value = value as? Double {
//            try container.encode(value)
//        } else if let value = value as? String {
//            try container.encode(value)
//        } else if value is JSONNull {
//            try container.encodeNil()
//        } else {
//            throw encodingError(forValue: value, codingPath: container.codingPath)
//        }
//    }
//
//    public required init(from decoder: Decoder) throws {
//        if var arrayContainer = try? decoder.unkeyedContainer() {
//            self.value = try JSONAny.decodeArray(from: &arrayContainer)
//        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
//            self.value = try JSONAny.decodeDictionary(from: &container)
//        } else {
//            let container = try decoder.singleValueContainer()
//            self.value = try JSONAny.decode(from: container)
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        if let arr = self.value as? [Any] {
//            var container = encoder.unkeyedContainer()
//            try JSONAny.encode(to: &container, array: arr)
//        } else if let dict = self.value as? [String: Any] {
//            var container = encoder.container(keyedBy: JSONCodingKey.self)
//            try JSONAny.encode(to: &container, dictionary: dict)
//        } else {
//            var container = encoder.singleValueContainer()
//            try JSONAny.encode(to: &container, value: self.value)
//        }
//    }
//}

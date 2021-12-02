//
//  Detailedshow.swift
//  sonarr_reader (iOS)
//
//  Created by "" on 2021-11-24.
//

import Foundation

struct Episode: Identifiable, Decodable {
    var seriesId = Int()
    var episodeFileId = Int()
    var seasonNumber = Int()
    var episodeNumber = Int()
    var airDate: String?
    var airDateUtc: String?
    var overview: String?
    var tvDbEpisodeId: Int?
    var title = String()
    var hasFile = Bool()
    var monitored = Bool()
    var sceneEpisodeNumber: Int?
    var sceneSeasonNumber:Int?
    var unverifiedSceneNumbering = Bool()
    var absoluteEpisodeNimber: Bool?
    var id = Int()
}

//
//  Show.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 1.07.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//

import Foundation

struct ShowApiResponse {
  let page: Int
  let numberOfResults: Int
  let numberOfPages: Int
  let shows: [Show]
}

extension ShowApiResponse: Decodable {
  
  private enum ShowApiResponseCodingKeys: String, CodingKey {
    case page
    case numberOfResults = "total_results"
    case numberOfPages = "total_pages"
    case shows = "results"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: ShowApiResponseCodingKeys.self)
    
    page = try container.decode(Int.self, forKey: .page)
    numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
    numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
    shows = try container.decode([Show].self, forKey: .shows)
    
  }
}


struct Show {
  let originalName: String
  let genreIDS: [Int]
  let name: String
  let popularity: Double
  let originCountry: [String]
  let voteCount: Int
  let firstAirDate, backdropPath, originalLanguage: String
  let id: Int
  let voteAverage: Double
  let overview, posterPath: String
}

extension Show: Decodable {
  enum CodingKeys: String, CodingKey {
    case originalName = "original_name"
    case genreIDS = "genre_ids"
    case name, popularity
    case originCountry = "origin_country"
    case voteCount = "vote_count"
    case firstAirDate = "first_air_date"
    case backdropPath = "backdrop_path"
    case originalLanguage = "original_language"
    case id
    case voteAverage = "vote_average"
    case overview
    case posterPath = "poster_path"
  }
  init(from decoder: Decoder) throws {
    let showContainer = try decoder.container(keyedBy: CodingKeys.self)
    id = try showContainer.decode(Int.self, forKey: .id)
    backdropPath = try showContainer.decode(String.self, forKey: .backdropPath)
    voteCount = try showContainer.decode(Int.self, forKey: .voteCount)
    name = try showContainer.decode(String.self, forKey: .name)
    voteAverage = try showContainer.decode(Double.self, forKey: .voteAverage)
    originCountry = try showContainer.decode([String].self, forKey: .originCountry)
    popularity = try showContainer.decode(Double.self, forKey: .popularity)
    posterPath = try showContainer.decode(String.self, forKey: .posterPath)
    originalLanguage = try showContainer.decode(String.self, forKey: .originalLanguage)
    genreIDS = try showContainer.decode([Int].self, forKey: .genreIDS)
    overview = try showContainer.decode(String.self, forKey: .overview)
    firstAirDate = try showContainer.decode(String.self, forKey: .firstAirDate)
    originalName = try showContainer.decode(String.self, forKey: .originalName)
    
    
    
  }
}

struct ShowDetail{
  let backdropPath: String?
  let firstAirDate: String?
  let genres: [Genre]
  let homepage: String
  let id: Int
  let lastAirDate, name: String
  let overview: String
  let popularity: Double
  let posterPath: String
  let status, type: String
  let voteAverage, voteCount: Int
}

extension ShowDetail : Decodable {
  enum CodingKeys: String, CodingKey {
    case backdropPath = "backdrop_path"
    case firstAirDate = "first_air_date"
    case genres, homepage, id
    case lastAirDate = "last_air_date"
    case name
    case overview, popularity
    case posterPath = "poster_path"
    case status, type
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
  init(from decoder: Decoder) throws {
    let showContainer = try decoder.container(keyedBy: CodingKeys.self)
    id = try showContainer.decode(Int.self, forKey: .id)
    backdropPath = try showContainer.decode(String.self, forKey: .backdropPath)
    voteCount = try showContainer.decode(Int.self, forKey: .voteCount)
    name = try showContainer.decode(String.self, forKey: .name)
    voteAverage = Int(try showContainer.decode(Double.self, forKey: .voteAverage))
    popularity = try showContainer.decode(Double.self, forKey: .popularity)
    posterPath = try showContainer.decode(String.self, forKey: .posterPath)
    genres = (try showContainer.decodeIfPresent([Genre].self, forKey: .genres))!
    overview = try showContainer.decode(String.self, forKey: .overview)
    firstAirDate = try showContainer.decode(String.self, forKey: .firstAirDate)
    homepage = try showContainer.decode(String.self, forKey: .homepage)
    lastAirDate = try showContainer.decode(String.self, forKey: .lastAirDate)
    status = try showContainer.decode(String.self, forKey: .status)
    type = try showContainer.decode(String.self, forKey: .type)
  }
}

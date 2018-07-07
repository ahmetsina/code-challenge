//
//  Movie.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 1.07.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//

import Foundation

struct MovieApiResponse {
  let page: Int
  let numberOfResults: Int
  let numberOfPages: Int
  let movies: [Movie]
}

extension MovieApiResponse: Decodable {
  
  private enum MovieApiResponseCodingKeys: String, CodingKey {
    case page
    case numberOfResults = "total_results"
    case numberOfPages = "total_pages"
    case movies = "results"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
    
    page = try container.decode(Int.self, forKey: .page)
    numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
    numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
    movies = try container.decode([Movie].self, forKey: .movies)
    
  }
}


struct Movie {
  let id: Int
  let posterPath: String
  let backdrop: String
  let title: String
  let releaseDate: String
  let rating: Double
  let overview: String
}

extension Movie: Decodable {
  
  enum MovieCodingKeys: String, CodingKey {
    case id
    case posterPath = "poster_path"
    case backdrop = "backdrop_path"
    case title
    case releaseDate = "release_date"
    case rating = "vote_average"
    case overview
  }
  
  
  init(from decoder: Decoder) throws {
    let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
    
    id = try movieContainer.decode(Int.self, forKey: .id)
    posterPath = try movieContainer.decode(String.self, forKey: .posterPath)
    backdrop = try movieContainer.decode(String.self, forKey: .backdrop)
    title = try movieContainer.decode(String.self, forKey: .title)
    releaseDate = try movieContainer.decode(String.self, forKey: .releaseDate)
    rating = try movieContainer.decode(Double.self, forKey: .rating)
    overview = try movieContainer.decode(String.self, forKey: .overview)
  }
}



struct MovieDetail {
  let backdropPath: String
  let genres: [Genre]
  let id: Int
  let popularity: Double
  let posterPath: String
  let releaseDate: String
  let title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
  let overview : String
}

extension MovieDetail : Decodable{
  enum CodingKeys: String, CodingKey {
    case backdropPath = "backdrop_path"
    case genres, id
    case popularity
    case posterPath = "poster_path"
    case title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    case releaseDate = "release_date"
    case overview
  }
  init(from decoder: Decoder) throws {
    let movieDetailContainer = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try movieDetailContainer.decode(Int.self, forKey: .id)
    posterPath = try movieDetailContainer.decode(String.self, forKey: .posterPath)
    backdropPath = try movieDetailContainer.decode(String.self, forKey: .backdropPath)
    title = try movieDetailContainer.decode(String.self, forKey: .title)
    genres = try movieDetailContainer.decode([Genre].self, forKey: .genres)
    popularity = try movieDetailContainer.decode(Double.self, forKey: .popularity)
    video = try movieDetailContainer.decode(Bool.self, forKey: .video)
    voteAverage = try movieDetailContainer.decode(Double.self, forKey: .voteAverage)
    voteCount = try movieDetailContainer.decode(Int.self, forKey: .voteCount)
    releaseDate = try movieDetailContainer.decode(String.self, forKey: .releaseDate)
    overview = try movieDetailContainer.decode(String.self, forKey: .overview)
  }
}
struct Genre : Decodable {
  let id: Int
  let name: String
}



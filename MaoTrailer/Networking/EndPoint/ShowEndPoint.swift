//
//  ShowEndPoint.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 1.07.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//


import Foundation

public enum ShowApi {
  case popular
  case top_rated
  case getCredits(id:Int)
  case getDetails(id:Int)
}

extension ShowApi: EndPointType {
  
  var environmentBaseURL : String {
    switch NetworkManager.environment {
    case .production: return "https://api.themoviedb.org/3/tv/"
    case .qa: return "https://qa.themoviedb.org/3/tv/"
    case .staging: return "https://staging.themoviedb.org/3/tv/"
    }
  }
  
  var baseURL: URL {
    guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
    return url
  }
  
  var path: String {
    switch self {
    case .top_rated:
      return "top_rated"
    case .popular:
      return "popular"
    case .getCredits(let id):
      return "\(id)/credits"
    case .getDetails(let id):
      return "\(id)"
    }
  }
  
  var httpMethod: HTTPMethod {
    return .get
  }
  
  var task: HTTPTask {
    switch self {
    case .top_rated:
      return .requestParameters(bodyParameters: nil,
                                bodyEncoding: .urlEncoding,
                                urlParameters: ["api_key":NetworkManager.MovieAPIKey])
      
    case .popular:
      return .requestParameters(bodyParameters: nil,
                                bodyEncoding: .urlEncoding,
                                urlParameters: ["api_key":NetworkManager.MovieAPIKey])
    case .getCredits( _):
      return .requestParameters(bodyParameters: nil,
                                bodyEncoding: .urlEncoding,
                                urlParameters: [
                                  "api_key":NetworkManager.MovieAPIKey])
    case .getDetails(_):
      return .requestParameters(bodyParameters: nil,
                                bodyEncoding: .urlEncoding,
                                urlParameters: [
                                  "api_key":NetworkManager.MovieAPIKey])
    }
  }
  
  var headers: HTTPHeaders? {
    return nil
  }
}

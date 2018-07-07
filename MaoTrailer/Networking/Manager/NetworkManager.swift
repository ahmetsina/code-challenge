//
//  NetworkManager.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 1.07.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//

import Foundation

enum NetworkResponse:String {
  case success
  case authenticationError = "You need to be authenticated first."
  case badRequest = "Bad request"
  case outdated = "The url you requested is outdated."
  case failed = "Network request failed."
  case noData = "Response returned with no data to decode."
  case unableToDecode = "We could not decode the response."
}

enum Result<String>{
  case success
  case failure(String)
}

struct NetworkManager {
  static let environment : NetworkEnvironment = .production
  static let MovieAPIKey = "d4e5dd7a6e359786b14d86ac30fee300"
  let router = Router<MovieApi>()
  let routerShow = Router<ShowApi>()
  
  func getNewMovies(page: Int, completion: @escaping (_ movie: [Movie]?,_ error: String?)->()){
    router.request(.newMovies(page: page)) { data, response, error in
      
      if error != nil {
        completion(nil, "Please check your network connection.")
      }
      
      if let response = response as? HTTPURLResponse {
        let result = self.handleNetworkResponse(response)
        switch result {
        case .success:
          guard let responseData = data else {
            completion(nil, NetworkResponse.noData.rawValue)
            return
          }
          do {
            print(responseData)
            //let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
            completion(apiResponse.movies,nil)
          }catch {
            print(error)
            completion(nil, NetworkResponse.unableToDecode.rawValue)
          }
        case .failure(let networkFailureError):
          completion(nil, networkFailureError)
        }
      }
    }
  }
  func getPopularMovies(page: Int, completion: @escaping (_ movie: [Movie]?,_ error: String?)->()){
    router.request(.popular()) { data, response, error in
      
      if error != nil {
        completion(nil, "Please check your network connection.")
      }
      
      if let response = response as? HTTPURLResponse {
        let result = self.handleNetworkResponse(response)
        switch result {
        case .success:
          guard let responseData = data else {
            completion(nil, NetworkResponse.noData.rawValue)
            return
          }
          do {
            //let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            //print(jsonData)

            let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
            completion(apiResponse.movies,nil)
          }catch {
            print(error)
            completion(nil, NetworkResponse.unableToDecode.rawValue)
          }
        case .failure(let networkFailureError):
          completion(nil, networkFailureError)
        }
      }
    }
  }
  func getCreditsOfMovie(movieID: Int, completion: @escaping (_ credit: Credit?,_ error: String?)->()){
    router.request(.getCredits(id: movieID)) { data, response, error in
      
      if error != nil {
        completion(nil, "Please check your network connection.")
      }
      
      if let response = response as? HTTPURLResponse {
        let result = self.handleNetworkResponse(response)
        switch result {
        case .success:
          guard let responseData = data else {
            completion(nil, NetworkResponse.noData.rawValue)
            return
          }
          do {
            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            print(jsonData)
            
            let apiResponse = try JSONDecoder().decode(Credit.self, from: responseData)
            completion(apiResponse,nil)
          }catch {
            print(error)
            completion(nil, NetworkResponse.unableToDecode.rawValue)
          }
        case .failure(let networkFailureError):
          completion(nil, networkFailureError)
        }
      }
    }
  }
  func getMovieDetails(movieID: Int, completion: @escaping (_ movieDetail: MovieDetail?,_ error: String?)->()){
    router.request(.getMovieDetails(id: movieID)) { data, response, error in
      
      if error != nil {
        completion(nil, "Please check your network connection.")
      }
      
      if let response = response as? HTTPURLResponse {
        let result = self.handleNetworkResponse(response)
        switch result {
        case .success:
          guard let responseData = data else {
            completion(nil, NetworkResponse.noData.rawValue)
            return
          }
          do {
            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            print(jsonData)
            
            let apiResponse = try JSONDecoder().decode(MovieDetail.self, from: responseData)
            completion(apiResponse,nil)
          }catch {
            print(error)
            completion(nil, NetworkResponse.unableToDecode.rawValue)
          }
        case .failure(let networkFailureError):
          completion(nil, networkFailureError)
        }
      }
    }
  }
  func getPopularShows(page: Int, completion: @escaping (_ show: [Show]?,_ error: String?)->()){
    routerShow.request(.popular) { data, response, error in
      
      if error != nil {
        completion(nil, "Please check your network connection.")
      }
      
      if let response = response as? HTTPURLResponse {
        let result = self.handleNetworkResponse(response)
        switch result {
        case .success:
          guard let responseData = data else {
            completion(nil, NetworkResponse.noData.rawValue)
            return
          }
          do {
            print(responseData)
            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            print(jsonData)
            let apiResponse = try JSONDecoder().decode(ShowApiResponse.self, from: responseData)
            completion(apiResponse.shows,nil)
          }catch {
            print(error)
            completion(nil, NetworkResponse.unableToDecode.rawValue)
          }
        case .failure(let networkFailureError):
          completion(nil, networkFailureError)
        }
      }
    }
  }
  func getTopRatedShows(page: Int, completion: @escaping (_ show: [Show]?,_ error: String?)->()){
    routerShow.request(.top_rated) { data, response, error in
      
      if error != nil {
        completion(nil, "Please check your network connection.")
      }
      
      if let response = response as? HTTPURLResponse {
        let result = self.handleNetworkResponse(response)
        switch result {
        case .success:
          guard let responseData = data else {
            completion(nil, NetworkResponse.noData.rawValue)
            return
          }
          do {
            print(responseData)
            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            print(jsonData)
            let apiResponse = try JSONDecoder().decode(ShowApiResponse.self, from: responseData)
            completion(apiResponse.shows,nil)
          }catch {
            print(error)
            completion(nil, NetworkResponse.unableToDecode.rawValue)
          }
        case .failure(let networkFailureError):
          completion(nil, networkFailureError)
        }
      }
    }
  }
  func getCreditsOfShow(showID: Int, completion: @escaping (_ credit: Credit?,_ error: String?)->()){
    routerShow.request(.getCredits(id: showID)) { data, response, error in
      
      if error != nil {
        completion(nil, "Please check your network connection.")
      }
      
      if let response = response as? HTTPURLResponse {
        let result = self.handleNetworkResponse(response)
        switch result {
        case .success:
          guard let responseData = data else {
            completion(nil, NetworkResponse.noData.rawValue)
            return
          }
          do {
            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            print(jsonData)
            
            let apiResponse = try JSONDecoder().decode(Credit.self, from: responseData)
            completion(apiResponse,nil)
          }catch {
            print(error)
            completion(nil, NetworkResponse.unableToDecode.rawValue)
          }
        case .failure(let networkFailureError):
          completion(nil, networkFailureError)
        }
      }
    }
  }
  func getShowDetails(showID: Int, completion: @escaping (_ credit: ShowDetail?,_ error: String?)->()){
    routerShow.request(.getDetails(id: showID)) { data, response, error in
      
      if error != nil {
        completion(nil, "Please check your network connection.")
      }
      
      if let response = response as? HTTPURLResponse {
        let result = self.handleNetworkResponse(response)
        switch result {
        case .success:
          guard let responseData = data else {
            completion(nil, NetworkResponse.noData.rawValue)
            return
          }
          do {
            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            print(jsonData)
            
            let apiResponse = try JSONDecoder().decode(ShowDetail.self, from: responseData)
            completion(apiResponse,nil)
          }catch {
            print(error)
            completion(nil, NetworkResponse.unableToDecode.rawValue)
          }
        case .failure(let networkFailureError):
          completion(nil, networkFailureError)
        }
      }
    }
  }
  
  fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
    switch response.statusCode {
    case 200...299: return .success
    case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
    case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
    case 600: return .failure(NetworkResponse.outdated.rawValue)
    default: return .failure(NetworkResponse.failed.rawValue)
    }
  }
}

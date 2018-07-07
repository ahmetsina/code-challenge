//
//  Credit.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 6.07.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//

import Foundation

struct Credit {
  let id: Int
  var cast: [Cast]
  var crew: [Crew]
}

struct Cast {
  let castID: Int
  let character, creditID: String
  let id: Int
  let name: String
  let order: Int
  var profilePath: String?
}
extension Cast : Decodable {
  enum CodingKeys: String, CodingKey {
    case castID = "cast_id"
    case character
    case creditID = "credit_id"
    case id, name, order
    case profilePath = "profile_path"
  }
  init(from decoder: Decoder) throws {
    let castContainer = try decoder.container(keyedBy: CodingKeys.self)
    castID = try castContainer.decode(Int.self, forKey: .id)
    creditID = try castContainer.decode(String.self, forKey: .creditID)
    character = try castContainer.decode(String.self, forKey: .character)
    id = try castContainer.decode(Int.self, forKey: .id)
    name = try castContainer.decode(String.self, forKey: .name)
    order = try castContainer.decode(Int.self, forKey: .order)
    profilePath = try castContainer.decodeIfPresent(String.self, forKey: .profilePath)
   
  }
}
struct Crew {
  let creditID, department: String  
  let id: Int
  let job, name: String
  let profilePath: String?
  
}
extension Crew :Decodable {
  enum CodingKeys: String, CodingKey {
    case creditID = "credit_id"
    case department, id, job, name
    case profilePath = "profile_path"
  }
  init(from decoder: Decoder) throws {
    let crewContainer = try decoder.container(keyedBy: CodingKeys.self)
    creditID = try crewContainer.decode(String.self, forKey: .creditID)
    id = try crewContainer.decode(Int.self, forKey: .id)
    name = try crewContainer.decode(String.self, forKey: .name)
    job = try crewContainer.decode(String.self, forKey: .job)
    department = try crewContainer.decode(String.self, forKey: .department)
    profilePath = try crewContainer.decodeIfPresent(String.self, forKey: .profilePath)
  }
}
extension Credit: Decodable {
  enum CodingKeys: String, CodingKey {
    case id
    case cast
    case crew
  }

  init(from decoder: Decoder) throws {
    let creditContainer = try decoder.container(keyedBy: CodingKeys.self)
    id = try creditContainer.decode(Int.self, forKey: .id)
    cast = try creditContainer.decode([Cast].self, forKey: .cast)
    crew = try creditContainer.decode([Crew].self, forKey: .crew)
  }
  
}



//
//  ResponseModel.swift
//  Code Challenge
//
//  Created by Rahul Patil on 21/10/20.
//

import Foundation
import RealmSwift

/// Structure of the Realm table.
class ResponseModel: Object, Codable {
  @objc dynamic var id: String?
  @objc dynamic var type: String?
  @objc dynamic var date: String?
  @objc dynamic var data: String?
  
  /// JSON keys
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case type = "type"
    case date = "date"
    case data = "data"
  }
  
  /// Realm primary key
  override static func primaryKey() -> String? {
      return "id"
  }
  
  /// Parsing the value from the JSON
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decodeIfPresent(String.self, forKey: .id)
    type = try values.decodeIfPresent(String.self, forKey: .type)
    date = try values.decodeIfPresent(String.self, forKey: .date)
    data = try values.decodeIfPresent(String.self, forKey: .data)
  }
  
  required init() {
  }
}

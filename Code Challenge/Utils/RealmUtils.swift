//
//  RealmUtils.swift
//  Code Challenge
//
//  Created by Rahul Patil on 22/10/20.
//

import Foundation
import RealmSwift

class RealmUtils {
  //MARK: Variables
  
  ///Instance of singleton class.
  static var shared = RealmUtils()
  private var realm = try! Realm()
  
  /// Add / Update data in Realm database.
  /// - Parameter data: [ResponseModel]
  func update(data: [ResponseModel]) {
    try! realm.write {
      for item in data {
        realm.create(ResponseModel.self, value: item, update: .modified)
      }
    }
  }
  
  /// It returns all the data available in Realm storage in form of array.
  /// - Returns: [ResponseModel]
  func getAllRecords() -> [ResponseModel] {
    let result = Array(realm.objects(ResponseModel.self))
    return result
  }
  
  /// It deletes all available data in the Realm storage.
  func deleteAll() {
    try! realm.write {
      realm.deleteAll()
    }
  }
}

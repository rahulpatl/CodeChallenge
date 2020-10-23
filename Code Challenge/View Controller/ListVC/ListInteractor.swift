//
//  ListInteractor.swift
//  Code Challenge
//
//  Created by Rahul Patil on 21/10/20.
//

import Foundation
import Alamofire

class ListInteractor {
  
  /// First try to fetch data from the Realm storage. If data is available in the storage, the handler captures the response.
  /// If data is not available in realm storage. It fetch from the API and stores in the Realm storage. Also capturs the response.
  /// - Parameter compilation: [ResponseModel]?
  func fetchData(compilation: @escaping ([ResponseModel]?) -> Void) {
    let records = RealmUtils.shared.getAllRecords()
    if records.isEmpty {
      let request = AF.request("https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json")
      request.responseJSON { (data) in
        do {
          if let data = data.data {
            let responseModels = try JSONDecoder().decode([ResponseModel].self, from: data)
            RealmUtils.shared.update(data: responseModels)
            compilation(responseModels)
          } else {
            compilation(nil)
          }
        } catch {
          compilation(nil)
        }
      }
    } else {
      compilation(records)
    }
  }
}



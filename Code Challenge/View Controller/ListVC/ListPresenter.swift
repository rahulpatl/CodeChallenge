//
//  ListPresenter.swift
//  Code Challenge
//
//  Created by Rahul Patil on 21/10/20.
//

import Foundation

protocol ListDelegate: class {
  
  /// It update data on details VC on iPad with SplitVC.
  /// - Parameter model: ResponseModel
  func selected(model: ResponseModel)
}

protocol ListViewProtocol: class {
  
  /// It saves data to Realm storage and updates CollectionView
  /// - Parameter data: [ResponseModel]
  func update(data: [ResponseModel])
  
  
  /// To show Alert with message.
  /// - Parameters:
  ///   - title: String
  ///   - message: String
  func showAlert(title: String, message: String)
}

protocol ListPresenterProtocol: class {
  
  /// It requests interactor to fetch data from API or Realm database (If data is available in the database.)
  func getAPIData()
}

/// It acts as medium between View and Interactor.
/// 
class ListPresenter {
  // MARK: Variables.
  weak var view: ListViewProtocol?
  var interactor: ListInteractor?
  
  // MARK: Init.
  /// Initialize view and interactor object.
  /// - Parameter _view: ListViewProtocol
  init(_view: ListViewProtocol) {
    view = _view
    interactor = ListInteractor()
  }
}

// MARK: Presenter Protocol
extension ListPresenter: ListPresenterProtocol {
  func getAPIData() {
    print("getList")
    interactor?.fetchData(compilation: { [weak self] (response) in
      if let data = response {
        print(data)
        self?.view?.update(data: data)
      } else {
        self?.view?.showAlert(title: "Alert", message: "No data found.")
        //Show Error
      }
    })
    
  }
}

//
//  SplitVC.swift
//  Code Challenge
//
//  Created by Rahul Patil on 22/10/20.
//

import Foundation
import UIKit

/// Represent with split view(shows multiple screens.) for iPad.
class SplitVC: UISplitViewController {
  //MARK: Variables
  private var detailsVC = DetailsVC()
  
  //MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareControllers()
  }
  
  //MARK: Custom methods

  /// It prepares controllers for split view.
  private func prepareControllers() {
    let mainVC = ListVC(_listDelegate: self)
    detailsVC = DetailsVC()
    preferredDisplayMode = .allVisible
    let mainNC = UINavigationController(rootViewController: mainVC)
    let detailsNC = UINavigationController(rootViewController: detailsVC)
    viewControllers = [mainNC, detailsNC]
  }
}

//MARK: ListDelegate
extension SplitVC: ListDelegate {
  func selected(model: ResponseModel) {
    detailsVC.update(data: model)
  }
}

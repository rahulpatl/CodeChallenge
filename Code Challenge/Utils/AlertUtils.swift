//
//  AlertUtils.swift
//  Code Challenge
//
//  Created by Rahul Patil on 24/10/20.
//

import Foundation
import UIKit

/// A singleton class to show Alert on desired VC.
class AlertUtils {
  
  /// Object of AlertUtils singleton class.
  static var shared = AlertUtils()
  
  
  /// Present the Alert on desired ViewController with title and message.
  /// - Parameters:
  ///   - title: String
  ///   - message: String
  ///   - target: UIViewController
  func showAlert(with title: String, message: String, target: UIViewController) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
    target.present(alertController, animated: true)
  }
  
}

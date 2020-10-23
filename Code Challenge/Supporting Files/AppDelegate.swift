//
//  AppDelegate.swift
//  Code Challenge
//
//  Created by Rahul Patil on 20/10/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  //MARK: Variables
  var window: UIWindow?

  //MARK: Lifecycle Methods
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    setupNavigation()
    setRootController(_window: window)
    return true
  }

  // MARK: UISceneSession Lifecycle
  @available(iOS 13.0, *)
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  @available(iOS 13.0, *)
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
  //MARK: Custom methods
  /// It prepares the UI for the navigation bar.
  func setupNavigation() {
    UINavigationBar.appearance().barTintColor = .lightGray
    UINavigationBar.appearance().backgroundColor = .lightGray
    UINavigationBar.appearance().tintColor = .darkGray
    UINavigationBar.appearance().isTranslucent = false
  }
  
  /// Set initial root controller
  /// - Parameter _window: UIWindow
  func setRootController(_window: UIWindow?) {
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
      // Set root controller for iPhone interface
      let viewController = ListVC()
      let nc = UINavigationController(rootViewController: viewController)
      _window?.rootViewController = nc
      _window?.makeKeyAndVisible()
      
    case .pad:
      // Set root controller for iPad interface
      let viewController = SplitVC()
      _window?.rootViewController = viewController
      _window?.makeKeyAndVisible()
      
    default: break
    }
  }
}


//
//  MainNavigationController.swift
//  AudibleLogin
//
//  Created by Emmanuoel Haroutunian on 2/21/17.
//  Copyright © 2017 Emmanuoel Haroutunian. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
  
  fileprivate func isLoggedIn() -> Bool {
    return UserDefaults.standard.bool(forKey: "isLoggedIn")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    if isLoggedIn() {
      let homeController = HomeController()
      viewControllers = [homeController]
    } else {
      // Delay to give app time to create Window
      perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
    }
  }
  
  func showLoginController() {
    let loginController = LoginViewController()
    present(loginController, animated: true, completion: {
      // Perhaps do something later
    })
  }
}

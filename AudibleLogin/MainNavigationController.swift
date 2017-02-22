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
    return false
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

class HomeController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "We're logged in"
    
    let imageView = UIImageView(image: UIImage(named: "home"))
    view.addSubview(imageView)
    _ = imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
  }
}

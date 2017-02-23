//
//  HomeController.swift
//  AudibleLogin
//
//  Created by Emmanuoel Haroutunian on 2/22/17.
//  Copyright © 2017 Emmanuoel Haroutunian. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "We're logged in"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
    
    let imageView = UIImageView(image: UIImage(named: "home"))
    view.addSubview(imageView)
    _ = imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
  }
  
  // MARK: Methods
  
  func handleSignOut() {
    UserDefaults.standard.setIsLoggedIn(value: false)
    
    let loginController = LoginViewController()
    present(loginController, animated: true, completion: nil)
  }
}

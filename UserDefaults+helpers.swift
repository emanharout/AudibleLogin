//
//  UserDefaults+helpers.swift
//  AudibleLogin
//
//  Created by Emmanuoel Haroutunian on 2/23/17.
//  Copyright © 2017 Emmanuoel Haroutunian. All rights reserved.
//

import Foundation

extension UserDefaults {
  
  enum UserDefaultsKeys: String {
    case isLoggedIn
  }
  
  func setIsLoggedIn(value: Bool) {
    set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    synchronize()
  }
  
  func isLoggedIn() -> Bool {
    return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
  }
}

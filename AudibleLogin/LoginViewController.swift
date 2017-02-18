//
//  ViewController.swift
//  AudibleLogin
//
//  Created by Emmanuoel Haroutunian on 2/17/17.
//  Copyright © 2017 Emmanuoel Haroutunian. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  let cellId = "cellId"
  
  // Must be lazy var instead of let in order to pass self into cv delegate
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.delegate = self
    cv.dataSource = self
    return cv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
  }

  func setupViews() {
    view.addSubview(collectionView)
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    
    collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    collectionView.backgroundColor = .red
  }
}

extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // # of items
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  // Create Cell
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    cell.backgroundColor = .blue
    return cell
  }
  
  // Cell Size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height)
  }
  
}

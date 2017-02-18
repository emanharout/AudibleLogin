//
//  ViewController.swift
//  AudibleLogin
//
//  Created by Emmanuoel Haroutunian on 2/17/17.
//  Copyright © 2017 Emmanuoel Haroutunian. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  let pageCellId = "pageId"
  let pages: [Page] = {
    let firstPage = Page(title: "Share a great listen", message: "It's free to send books to people in your life. Every receipient's first book is on us.", imageName: "page1")
    let secondPage = Page(title: "Send from your library", message: "Tap the More menu next to any book. Choose \"Send this book.\"", imageName: "page2")
    let thirdPage = Page(title: "Send from the player", message: "Tap the More menu in the upper corner. Choose \"Send this book.\"", imageName: "page3")
    return [firstPage, secondPage, thirdPage]
  }()
  
  // Must be lazy var instead of let in order to pass self into cv delegate
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.delegate = self
    cv.dataSource = self
    
    // Setup Pagination
    cv.isPagingEnabled = true
    layout.minimumLineSpacing = 0
    
    return cv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
  }

  func setupViews() {
    view.addSubview(collectionView)
    collectionView.register(PageCell.self, forCellWithReuseIdentifier: pageCellId)
    
    collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    collectionView.backgroundColor = .red
  }
}

extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // # of items
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pages.count
  }
  
  // Create Cell
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageCellId, for: indexPath) as! PageCell
    let page = pages[indexPath.item]
    cell.page = page
    
    return cell
  }
  
  // Cell Size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height)
  }
  
}

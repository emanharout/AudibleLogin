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
  
  let pageControl: UIPageControl = {
    let pc = UIPageControl()
    pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
    pc.pageIndicatorTintColor = .lightGray
    pc.numberOfPages = 3
    return pc
  }()
  
  let skipButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Skip", for: .normal)
    button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
    return button
  }()
  
  let nextButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Next", for: .normal)
    button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
    return button
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

  // MARK: Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
  }

  func setupViews() {
    view.addSubview(collectionView)
    view.addSubview(pageControl)
    view.addSubview(skipButton)
    view.addSubview(nextButton)
    
    collectionView.register(PageCell.self, forCellWithReuseIdentifier: pageCellId)
    collectionView.backgroundColor = .white
    
    // Layout
    collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    
    _ = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
    
    _ = skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)
    
    _ = nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)
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

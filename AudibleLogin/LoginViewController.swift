//
//  ViewController.swift
//  AudibleLogin
//
//  Created by Emmanuoel Haroutunian on 2/17/17.
//  Copyright © 2017 Emmanuoel Haroutunian. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginViewControllerDelegate {
  
  let pageCellId = "pageId"
  let loginCellId = "loginCellId"
  let pages: [Page] = {
    let firstPage = Page(title: "Share a great listen", message: "It's free to send books to people in your life. Every receipient's first book is on us.", imageName: "page1")
    let secondPage = Page(title: "Send from your library", message: "Tap the More menu next to any book. Choose \"Send this book.\"", imageName: "page2")
    let thirdPage = Page(title: "Send from the player", message: "Tap the More menu in the upper corner. Choose \"Send this book.\"", imageName: "page3")
    return [firstPage, secondPage, thirdPage]
  }()
  
  var pageControlBottomAnchor: NSLayoutConstraint?
  var skipButtonTopAnchor: NSLayoutConstraint?
  var nextButtonTopAnchor: NSLayoutConstraint?
  
  lazy var pageControl: UIPageControl = {
    let pc = UIPageControl()
    pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
    pc.pageIndicatorTintColor = .lightGray
    pc.numberOfPages = self.pages.count + 1
    return pc
  }()
  
  let skipButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Skip", for: .normal)
    button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
    button.addTarget(self, action: #selector(skip), for: .touchUpInside)
    return button
  }()
  
  let nextButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Next", for: .normal)
    button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
    button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
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
    
    observeKeyboardNotifications()
    setupViews()
  }

  func setupViews() {
    view.addSubview(collectionView)
    view.addSubview(pageControl)
    view.addSubview(skipButton)
    view.addSubview(nextButton)
    
    registerCells()
    collectionView.backgroundColor = .white
    
    // Layout
    collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    
    pageControlBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
    
    skipButtonTopAnchor = skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
    
    nextButtonTopAnchor = nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    // Hookup UIPageControl to current page
    let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
    print(pageNumber)
    pageControl.currentPage = pageNumber
    
    // Hide UIPageControl upon viewing Login screen
    if pageNumber == pages.count {
      moveControlConstraintsOffScreen()
    } else {
      pageControlBottomAnchor?.constant = 0
      skipButtonTopAnchor?.constant = 16
      nextButtonTopAnchor?.constant = 16
    }
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    // Whenever we scroll again, editting ends (keyboard resigns from login vc)
    view.endEditing(true)
  }
  
  fileprivate func observeKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
  }
  
  func keyboardShow() {
    
    let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
      self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
    }, completion: nil)
  }
  
  func keyboardHide() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }, completion: nil)
  }
  
  func nextPage() {
    if pageControl.currentPage == pages.count {
      return
    }
    
    // Control won't move off screen when pressing next to view login vc, fix:
    if pageControl.currentPage == pages.count - 1 {
      moveControlConstraintsOffScreen()
    }
    
    let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    pageControl.currentPage += 1
  }
  
  func skip() {
    pageControl.currentPage = pages.count - 1
    nextPage()
  }
  
  fileprivate func moveControlConstraintsOffScreen() {
    pageControlBottomAnchor?.constant = 40
    skipButtonTopAnchor?.constant = -40
    nextButtonTopAnchor?.constant = -40
  }
  
  // Fix Layout on Orientation Change
  override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    print(UIDevice.current.orientation.isLandscape)
    
    // Redraw collectionview with proper width/height for all cells
    collectionView.collectionViewLayout.invalidateLayout()
    
    let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
    
    // Scroll to indexPath after rotation is going
    DispatchQueue.main.async {
      self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      // Update cell drawing when reassigning page, so landscape image will be updated in didSet
      self.collectionView.reloadData()
    }
  }
  
  func finishLoggingIn() {
    //Key window returns actual window for your app
    let rootViewController = UIApplication.shared.keyWindow?.rootViewController
    guard let mainNavigationController = rootViewController as? MainNavigationController else {return}
    mainNavigationController.viewControllers = [HomeController()]
    
    UserDefaults.standard.setIsLoggedIn(value: true)
    
    dismiss(animated: true, completion: nil)
  }
}

extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // # of items
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // Add one for login screen
    return pages.count + 1
  }
  
  // Create Cell
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if indexPath.item == pages.count {
      let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
      loginCell.delegate = self
      return loginCell
    }
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageCellId, for: indexPath) as! PageCell
    let page = pages[indexPath.item]
    cell.page = page
    
    return cell
  }
  
  // Cell Size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height)
  }
  
  // Register Cells
  fileprivate func registerCells() {
    collectionView.register(PageCell.self, forCellWithReuseIdentifier: pageCellId)
    collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
  }
  
}


protocol LoginViewControllerDelegate: class {
  func finishLoggingIn()
}

//
//  PageCell.swift
//  AudibleLogin
//
//  Created by Emmanuoel Haroutunian on 2/18/17.
//  Copyright © 2017 Emmanuoel Haroutunian. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
  
  var page: Page? {
    didSet {
      guard let page = page else { return }
      imageView.image = UIImage(named: page.imageName)
      
      let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium),
                        NSForegroundColorAttributeName: UIColor.init(white: 0.2, alpha: 1)]
      let attributedText = NSMutableAttributedString(string: page.title, attributes: attributes)
      
      let messageTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14),
                               NSForegroundColorAttributeName: UIColor.init(white: 0.2, alpha: 0.2)]
      let messageAttributedText = NSMutableAttributedString(string: "\n\n\(page.message)", attributes: messageTextAttributes)
      
      attributedText.append(messageAttributedText)
      
      // Center Attributed Text
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      let length   = attributedText.string.characters.count
      
      attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
      
      textView.attributedText = attributedText
    }
  }
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "page1")
     
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  let textView: UITextView = {
    let tv = UITextView()
    tv.text = "SAMPLE TEXT FOR NOW"
    tv.isEditable = false
    tv.contentInset = UIEdgeInsetsMake(24, 0, 0, 0)
    return tv
  }()
  
  let lineSeperatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.9, alpha: 1)
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    addSubview(imageView)
    addSubview(textView)
    addSubview(lineSeperatorView)
    
    imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
    
    textView.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
    textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    
     lineSeperatorView.anchorToTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
    lineSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
  }
  
}

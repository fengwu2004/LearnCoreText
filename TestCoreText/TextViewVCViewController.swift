//
//  TextViewVCViewController.swift
//  TestCoreText
//
//  Created by ky on 2019/1/14.
//  Copyright © 2019 yellfun. All rights reserved.
//

import UIKit

class TextViewVCViewController: UIViewController {
  
  @IBOutlet weak var textView:UITextView!
    
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    print("viewdidLoaded")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
    
    let text = "Every font has a distinct personality. But how can you identify it? This article will teach you the science and psychology of choosing fonts."
    
    let mutableAttrText = NSMutableAttributedString(string: text)
    
    let attchment = NSTextAttachment()
    
    attchment.image = UIImage(named: "1")
    
    attchment.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
    
    let attrtext = NSAttributedString(attachment: attchment)
    
    mutableAttrText.insert(attrtext, at: 10)
    
    textView.attributedText = mutableAttrText
  }
}

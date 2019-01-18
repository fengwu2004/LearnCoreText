//
//  ViewController.swift
//  TestCoreText
//
//  Created by ky on 2019/1/14.
//  Copyright © 2019 yellfun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var label:UILabel!
  
  @IBOutlet weak var textField:UITextField!
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    textField.delegate = self
    
    NotificationCenter.default.addObserver(self, selector: #selector(onShowKeyBoard), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(onChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    
    let ges = UITapGestureRecognizer(target: self, action: #selector(onTapBack))
    
    view.addGestureRecognizer(ges)
  }
  
  @objc func onChangeFrame(_ notif:Notification) {
    
    print("onChangeFrame", notif)
  }
  
  @objc func onShowKeyBoard() {
    
    print("onShowKeyBoard")
  }
  
  @objc func onTapBack() {
    
    textField.resignFirstResponder()
  }
  
  //delegate
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
    print("textFieldShouldBeginEditing")
    
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    print("textFieldDidBeginEditing")
  }
  
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    
    print("textFieldDidEndEditing", reason)
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    label.text = textField.text
    
    print(string, range)
    
    return true
  }

  deinit {
    
    NotificationCenter.default.removeObserver(self)
  }
  
  @IBAction func onShow() {
  
    let vc = DViewController()
    
    self.present(vc, animated: true, completion: nil)
  }
}


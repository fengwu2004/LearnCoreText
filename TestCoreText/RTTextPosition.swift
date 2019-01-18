//
//  RTTextPosition.swift
//  TestCoreText
//
//  Created by ky on 2019/1/18.
//  Copyright © 2019 yellfun. All rights reserved.
//

import UIKit

class RTTextPosition: UITextPosition {
  
  var index:Int = 0

  weak var delegate:UITextInputDelegate?
  
  static func positionWithIndex(_ index:Int) -> RTTextPosition {
    
    let obj = RTTextPosition()
    
    obj.index = index
    
    return obj
  }
}

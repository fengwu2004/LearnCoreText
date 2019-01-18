//
//  RTTextRange.swift
//  TestCoreText
//
//  Created by ky on 2019/1/18.
//  Copyright © 2019 yellfun. All rights reserved.
//

import UIKit

class RTTextRange: UITextRange {
  
  var range:NSRange = NSRange(location: 0, length: 0)
  
  static func indexedRangeWithRange(_ range:NSRange) -> RTTextRange {
    
    let rtrange = RTTextRange()
    
    rtrange.range = range
    
    return rtrange
  }
  
  override var start: UITextPosition {
    
    return RTTextPosition.positionWithIndex(range.location)
  }
  
  override var end: UITextPosition {
    
    return RTTextPosition.positionWithIndex(range.location + range.length)
  }
  
  override var isEmpty: Bool {
    
    return range.length == 0
  }
}

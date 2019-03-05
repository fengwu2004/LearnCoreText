//
//  RTView.swift
//  TestCoreText
//
//  Created by ky on 2019/1/17.
//  Copyright © 2019 yellfun. All rights reserved.
//

import UIKit
import CoreText

class RTView: UIView, UITextInput {
  
  var selectedRange = NSRange(location: 0, length: 0)
  
  var markedRange = NSRange(location: 0, length: 0)
  
  var textInputeDelegate:UITextInputDelegate?
  
  override var canBecomeFirstResponder: Bool {
    
    return true
  }
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    
    self.isUserInteractionEnabled = true
    
    textInputTokenizer = UITextInputStringTokenizer(textInput: self)
    
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doTap(_:))))
  }
  
  override func resignFirstResponder() -> Bool {
    
    return super.resignFirstResponder()
  }
  
  private var textInputTokenizer:UITextInputStringTokenizer!
  
  @objc
  func doTap(_ sender:UITapGestureRecognizer) -> Void {
    
    if self.isFirstResponder {
      
      self.inputDelegate?.textWillChange(self)
      
      self.inputDelegate?.textDidChange(self)
    }
    else {
      
      self.becomeFirstResponder()
    }
  }
  
  var text = NSMutableString(string: "")

  var hasText: Bool {
    
    return true
  }
  
  func insertText(_ text: String) {
    
    print("insertText\(text)")
    
    return
  }
  
  func deleteBackward() {
    
    print("deleteBackward")
    
    if markedRange.location != NSNotFound {
      
      self.text.deleteCharacters(in: markedRange)
      
      selectedRange = NSRange(location: markedRange.location, length: 0)
      
      markedRange = NSRange(location: NSNotFound, length: 0)
    }
    else if selectedRange.length > 0 {
      
      self.text.deleteCharacters(in: selectedRange)
      
      selectedRange.length = 0
    }
    else if selectedRange.location > 0 {
      
      let index = selectedRange.location - 1
      
      self.text.deleteCharacters(in: NSRange(location: index, length: 1))
      
      selectedRange.length = 0
      
      selectedRange.location = index
    }
    
    self.setNeedsDisplay()
  }
  
  var textInputView: UIView {
    
    return self
  }
  
  func text(in range: UITextRange) -> String? {
    
    return nil
  }
  
  func replace(_ range: UITextRange, withText text: String) {
    
    guard let range = (range as? RTTextRange)?.range else {
      
      return
    }
    
    self.text.replaceCharacters(in: range, with: text)
  }
  
  var selectedTextRange: UITextRange? {
    
    get {
    
      return RTTextRange.indexedRangeWithRange(self.selectedRange)
    }
    
    set(newRange) {
      
      if let range = (newRange as? RTTextRange)?.range {
        
        self.selectedRange = range
      }
    }
  }
  
  var markedTextRange: UITextRange? {
    
    if markedRange.length == 0 || markedRange.location == NSNotFound {
      
      return nil
    }
    
    return RTTextRange.indexedRangeWithRange(markedRange)
  }
  
  var markedTextStyle: [NSAttributedString.Key : Any]?
  
  func setMarkedText(_ markedText: String?, selectedRange: NSRange) {
    
    guard let text = markedText else {
      
      return
    }
    
    if markedRange.location != NSNotFound {
      
      self.text.replaceCharacters(in: markedRange, with: text)
      
      markedRange.length = text.count
    }
    else if self.selectedRange.length != 0 {
      
      self.text.replaceCharacters(in: selectedRange, with: text)
      
      markedRange = NSRange(location: self.selectedRange.location, length: text.count)
    }
    else {
      
      self.text.insert(text, at: self.selectedRange.location)
      
      markedRange = NSRange(location: self.selectedRange.location, length: text.count)
    }
    
    self.selectedRange = NSRange(location: selectedRange.location + markedRange.location, length: selectedRange.length)
    
    setNeedsDisplay()
  }
  
  func unmarkText() {
    
    markedRange.location = NSNotFound
  }
  
  var beginningOfDocument: UITextPosition {
    
    return RTTextPosition.positionWithIndex(0)
  }
  
  var endOfDocument: UITextPosition {
    
    return RTTextPosition.positionWithIndex(self.text.length)
  }
  
  func textRange(from fromPosition: UITextPosition, to toPosition: UITextPosition) -> UITextRange? {
    
    return nil
  }
  
  func position(from position: UITextPosition, offset: Int) -> UITextPosition? {
    
    return nil
  }
  
  func position(from position: UITextPosition, in direction: UITextLayoutDirection, offset: Int) -> UITextPosition? {
    
    return nil
  }
  
  func compare(_ position: UITextPosition, to other: UITextPosition) -> ComparisonResult {
    
    return ComparisonResult.orderedSame
  }
  
  func offset(from: UITextPosition, to toPosition: UITextPosition) -> Int {
    
    return 0
  }
  
  var inputDelegate: UITextInputDelegate?
  
  var tokenizer: UITextInputTokenizer {
    
    return textInputTokenizer
  }
  
  func position(within range: UITextRange, farthestIn direction: UITextLayoutDirection) -> UITextPosition? {
    
    return nil
  }
  
  func characterRange(byExtending position: UITextPosition, in direction: UITextLayoutDirection) -> UITextRange? {
    
    return nil
  }
  
  func baseWritingDirection(for position: UITextPosition, in direction: UITextStorageDirection) -> UITextWritingDirection {
    
    return UITextWritingDirection.leftToRight
  }
  
  func setBaseWritingDirection(_ writingDirection: UITextWritingDirection, for range: UITextRange) {
    
    return
  }
  
  func firstRect(for range: UITextRange) -> CGRect {
    
    return CGRect(x: 10, y: 10, width: 100, height: 300)
  }
  
  func caretRect(for position: UITextPosition) -> CGRect {
    
    return CGRect(x: 10, y: 10, width: 3, height: 100)
  }
  
  func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
    
    return []
  }
  
  func closestPosition(to point: CGPoint) -> UITextPosition? {
    
    return nil
  }
  
  func closestPosition(to point: CGPoint, within range: UITextRange) -> UITextPosition? {
    
    return nil
  }
  
  func characterRange(at point: CGPoint) -> UITextRange? {
    
    return nil
  }
  
  override func draw(_ rect: CGRect) {
    
    let ctx = getCtx()
   
    let mutablestring = NSAttributedString(string: self.text as String)
  
    let frameSetter = CTFramesetterCreateWithAttributedString(mutablestring)
    
    let path = CGPath(rect: self.bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)), transform: nil)
    
    let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
    
    CTFrameDraw(frame, ctx)
  }
  
  func calculateImageRectWithFrame(_ frame:CTFrame) -> CGRect {
    
    let lines = CTFrameGetLines(frame) as! [CTLine]
    
    var points = [CGPoint](repeating: CGPoint.zero, count: lines.count)
    
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &points)
  
    for line in lines {
      
      let runs = CTLineGetGlyphRuns(line) as! [CTRun]
      
      for run in runs {
        
        let attr:NSDictionary = CTRunGetAttributes(run)
        
        if attr[kCTRunDelegateAttributeName] == nil {
          
          continue
        }
        
        var boundsRun = CGRect.zero
        
        var ascent:CGFloat = 0, descent:CGFloat = 0
        
        boundsRun.size.width = CGFloat(CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, nil))
        
        boundsRun.size.height = ascent + descent
        
        let xoffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, nil)
        
        boundsRun.origin.x = points[0].x + xoffset
        
        boundsRun.origin.y = points[0].y - descent
        
        let path = CTFrameGetPath(frame)
        
        let colRect = path.boundingBox
        
        return boundsRun.offsetBy(dx: colRect.origin.x, dy: colRect.origin.y)
      }
    }
    
    return .zero
  }
  
  func getCtx() -> CGContext {
    
    let ctx = UIGraphicsGetCurrentContext()
    
    ctx?.translateBy(x: 0, y: self.bounds.size.height)
    
    ctx?.scaleBy(x: 1, y: -1)
    
    ctx?.textMatrix = CGAffineTransform.identity
    
    return ctx!
  }
}

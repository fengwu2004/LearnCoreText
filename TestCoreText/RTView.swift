//
//  RTView.swift
//  TestCoreText
//
//  Created by ky on 2019/1/17.
//  Copyright © 2019 yellfun. All rights reserved.
//

import UIKit
import CoreText

private func deallocate(_ point:UnsafeMutableRawPointer) -> Void {
  
  print(point)
}

private func getAscent(_ point:UnsafeMutableRawPointer) -> CGFloat {
  
  let dic = point.load(as: [String:Int].self)
  
  if let value = dic["height"] {
    
    return CGFloat(value)
  }
  
  return  0
}

private func getDescent(_ point:UnsafeMutableRawPointer) -> CGFloat {
  
  return 0
}

private func getWidth(_ point:UnsafeMutableRawPointer) -> CGFloat {
  
  let dic = point.load(as: [String:Int].self)
  
  if let value = dic["height"] {
    
    return CGFloat(value)
  }
  
  return 0
}

class RTView: UIView, UITextInput {
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
  }
  
  private var textInputTokenizer:UITextInputStringTokenizer!
  
  required init?(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
    
    textInputTokenizer = UITextInputStringTokenizer(textInput: self)
    
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doTap(_:))))
  }
  
  @objc
  func doTap(_ sender:UITapGestureRecognizer) -> Void {
    
    if self.isFirstResponder {
      
      self.inputDelegate?.textWillChange(self)
      
      self.inputDelegate?.textDidChange(self)
    }
    else {
      
      self.becomeFirstResponder()
      
      self.inputDelegate?.textWillChange(self)
      
      self.inputDelegate?.textDidChange(self)
    }
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    textInputTokenizer = UITextInputStringTokenizer(textInput: self)
  }
  
  var text:NSMutableAttributedString = NSMutableAttributedString(string: "这是富文本这是富文本这是富文本这是富文本这是富文本这是富文本这是富文本这是富文本这是富文本这是富文本这是富文本这是富文本这是富文本这是富文本这是富文本")

  var hasText: Bool {
    
    return true
  }
  
  func insertText(_ text: String) {
    
    print("insertText\(text)")
    
    return
  }
  
  func deleteBackward() {
    
    print("deleteBackward")
  }
  
  func text(in range: UITextRange) -> String? {
    
    return nil
  }
  
  func replace(_ range: UITextRange, withText text: String) {
    
    return
  }
  
  var selectedTextRange: UITextRange?
  
  var markedTextRange: UITextRange?
  
  var markedTextStyle: [NSAttributedString.Key : Any]?
  
  func setMarkedText(_ markedText: String?, selectedRange: NSRange) {
    
    print("setMarkedText")
    
    return
  }
  
  func unmarkText() {
    
    print("unmarkText")
  }
  
  var beginningOfDocument: UITextPosition {
    
    return RTTextPosition()
  }
  
  var endOfDocument: UITextPosition {
    
    return RTTextPosition()
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
    
    
  }
  
  func firstRect(for range: UITextRange) -> CGRect {
    
    return .zero
  }
  
  func caretRect(for position: UITextPosition) -> CGRect {
    
    return .zero
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
   
    let mutablestring = self.text
  
    let frameSetter = CTFramesetterCreateWithAttributedString(mutablestring)
    
    let path = CGPath(rect: self.bounds.inset(by: UIEdgeInsets(top: 100, left: 100, bottom: 200, right: 50)), transform: nil)
    
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
    
    print(self.bounds.size)
    
    ctx?.translateBy(x: 0, y: self.bounds.size.height)
    
    ctx?.scaleBy(x: 1, y: -1)
    
    ctx?.textMatrix = CGAffineTransform.identity
    
    return ctx!
  }
}

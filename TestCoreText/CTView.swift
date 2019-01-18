//
//  CTView.swift
//  TestCoreText
//
//  Created by ky on 2019/1/15.
//  Copyright © 2019 yellfun. All rights reserved.
//

import UIKit
import CoreText
import CoreFoundation

class CTView: UIView {
  
  override func draw(_ rect: CGRect) {
    
    displayTextInNonrectangular(rect)
  }
  
  func getCtx() -> CGContext {
    
    let ctx = UIGraphicsGetCurrentContext()
    
    print(self.bounds.size)
    
    ctx?.translateBy(x: 0, y: self.bounds.size.height)
    
    ctx?.scaleBy(x: 1, y: -1)
    
    ctx?.textMatrix = CGAffineTransform.identity
    
    return ctx!
  }
  
  func drawParagraph() -> Void {
    
    let ctx = getCtx()
    
    let path = CGMutablePath()
    
    let bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
    
    path.addRect(bounds)
    
    let textString = "Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine"
    
    let attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0)
    
    CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), textString as CFString)
    
    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    
    let values:[CGFloat] = [1, 0, 0, 0.8]
    
    let red = CGColor(colorSpace: rgbColorSpace, components: values)
    
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 12), kCTForegroundColorAttributeName, red)
    
    let framesetter = CTFramesetterCreateWithAttributedString(attrString!)
    
    let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
    
    CTFrameDraw(frame, ctx)
  }
  
  func drawSingleLine() -> Void {
    
    let ctx = getCtx()
    
    let textString = "Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine."
    
    let attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0)
    
    CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), textString as CFString)
    
    let line = CTLineCreateWithAttributedString(attrString!)
    
    ctx.textPosition = CGPoint(x: 0, y: 100)
    
    CTLineDraw(line, ctx)
  }
  
  func createColoums(_ count:Int) -> [CGPath] {
    
    let bound = self.bounds
    
    let width = bound.size.width / CGFloat(count)
    
    var rects = [CGRect](repeating: CGRect(x: 0, y: 0, width: 0, height: 0), count: count)
    
    rects[0] = bound
    
    for i in 0..<(rects.count - 1) {
      
      (rects[i], rects[i + 1]) = rects[i].divided(atDistance: width, from: CGRectEdge.minXEdge)
    }
    
    return rects.map({
      
      let finnalRect = $0.inset(by: UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15))
      
      let path = CGMutablePath()
      
      path.addRect(finnalRect)
      
      return path
    })
  }
  
  func drawColumnar() -> Void {
    
    let ctx = getCtx()
    
    let paths = createColoums(4)
    
    let attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0)
    
    let textString = "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111 as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the worl222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine"
    
    CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), textString as CFString)
    
    let framesetter = CTFramesetterCreateWithAttributedString(attrString!)
    
    var startIndex = 0
    
    for path in paths {
      
      let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(startIndex, 0), path, nil)
      
      CTFrameDraw(frame, ctx)
      
      let frameRange = CTFrameGetVisibleStringRange(frame)
      
      startIndex += frameRange.length
    }
  }
  
  func breakLine() -> Void {
    
    let ctx = getCtx()
    
    let width:Double = 100.0
    
    let textString = "Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine."
    
    let attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0)
    
    CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), textString as CFString)
    
    let typesetter = CTTypesetterCreateWithAttributedString(attrString!)
    
    let start = 0
    
    let count = CTTypesetterSuggestLineBreak(typesetter, start, width)
    
    let line = CTTypesetterCreateLine(typesetter, CFRange(location: start, length: count))
    
    let flush:CGFloat = 0
    
    let penOffset = CTLineGetPenOffsetForFlush(line, flush, width)
    
    let textPosition = CGPoint(x: 100, y: 100)
    
    ctx.textPosition = CGPoint(x: textPosition.x + CGFloat(penOffset), y: textPosition.y)
    
    CTLineDraw(line, ctx)
  }
  
  func applyParaStyle(_ fontName:CFString, pointSize:CGFloat, plainText:String, lineSpaceInc:CGFloat) -> CFAttributedString {
    
    let font = CTFontCreateWithName(fontName, pointSize, nil)
    
    var lineSpace = (CTFontGetLeading(font) + lineSpaceInc) * 0.5
    
    let size = MemoryLayout.size(ofValue: lineSpace)
    
    print(size)
    
    var setting = CTParagraphStyleSetting(spec: CTParagraphStyleSpecifier.lineSpacingAdjustment, valueSize: size, value: &lineSpace)
    
    let paragraphStyle = CTParagraphStyleCreate(&setting, 1)
    
    let attributes = [kCTFontNameAttribute:font, kCTParagraphStyleAttributeName:paragraphStyle] as [NSAttributedString.Key : Any]
    
    return NSAttributedString(string: plainText, attributes: attributes)
  }
  
  func DrawingStyledParagraph(_ rect:CGRect) -> Void {
    
    let ctx = getCtx()
    
    let plainText = "Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine    Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine."
    
    let attrString = applyParaStyle("Didot Italic" as CFString, pointSize: 24, plainText: plainText, lineSpaceInc: 10)
    
    let frameSetter = CTFramesetterCreateWithAttributedString(attrString)
    
    print(rect)
    
    let r = rect.inset(by: UIEdgeInsets(top: 300, left: 0, bottom: 100, right: 0))
    
    print(r)
    
    let path = CGPath(rect: r, transform: nil)
    
    UIColor.red.setStroke()
    
    let besirpath = UIBezierPath(cgPath: path)
    
    besirpath.stroke()
    
    let frame = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: 0), path, nil)
    
    CTFrameDraw(frame, ctx)
  }
  
  static func AddSquashedDonutPath(_ path:CGMutablePath, m:CGAffineTransform, rect:CGRect) {
    
    let width = rect.width
    
    let height = rect.height
    
    let radiusH = width / 3.0
    
    let radiusV = height / 3.0
    
    path.move(to: CGPoint(x: rect.origin.x, y: rect.origin.y + height - radiusV), transform: m)
    
    path.addQuadCurve(to: CGPoint(x: rect.origin.x + radiusH, y: rect.origin.y + height), control: CGPoint(x: rect.origin.x, y: rect.origin.y + height), transform: m)
    
    path.addLine(to: CGPoint(x: rect.origin.x + width - radiusH, y: rect.origin.y + height), transform: m)
    
    path.addQuadCurve(to: CGPoint(x: rect.origin.x + width, y: rect.origin.y + height - radiusV), control: CGPoint(x: rect.origin.x + width, y: rect.origin.y + height), transform: m)
    
    path.addLine(to: CGPoint(x: rect.origin.x + width, y: rect.origin.y + radiusV), transform: m)
    
    path.addQuadCurve(to: CGPoint(x: rect.origin.x + width - radiusH, y: rect.origin.y), control: CGPoint(x: rect.origin.x + width, y: rect.origin.y), transform: m)
    
    path.addLine(to: CGPoint(x: rect.origin.x + radiusH, y: rect.origin.y), transform: m)
    
    path.addQuadCurve(to: CGPoint(x: rect.origin.x, y: rect.origin.y + radiusV), control: CGPoint(x: rect.origin.x, y: rect.origin.y), transform: m)
    
    path.closeSubpath()
    
    path.addEllipse(in: CGRect(x: rect.origin.x + width / 2.0 - width / 5.0, y: rect.origin.y + height / 2.0 - height / 5.0, width: width / 5.0 * 2.0, height: height / 5.0 * 2.0), transform: m)
  }
  
  func displayTextInNonrectangular(_ rect:CGRect) -> Void {
    
    let ctx = getCtx()
    
    let textString = "Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine."
    
    let attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0)
    
    CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), textString as CFString)
    
    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    
    let values:[CGFloat] = [1, 0, 0, 0.8]
    
    let red = CGColor(colorSpace: rgbColorSpace, components: values)
    
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 12), kCTForegroundColorAttributeName, red)
    
    let framesetter = CTFramesetterCreateWithAttributedString(attrString!)
    
    let path = CGMutablePath()
    
    CTView.AddSquashedDonutPath(path, m: CGAffineTransform.identity, rect: rect.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)))
    
    ctx.setFillColor(UIColor.yellow.cgColor)
    
    ctx.addPath(path)
    
    ctx.fillPath()
    
    ctx.drawPath(using: CGPathDrawingMode.stroke)
    
    let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
    
    CTFrameDraw(frame, ctx)
  }
}

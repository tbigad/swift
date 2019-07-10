//
//  SelectColorButton.swift
//  Note
//
//  Created by Pavel N on 7/9/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

@IBDesignable
class SelectColorButton: UIButton {
    @IBInspectable var presetColor : UIColor = .clear
    @IBInspectable var isSelect:Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    let saturationExponentTop:Float = 2.0
    let saturationExponentBottom:Float = 1.3
    let elementSize:CGFloat = 1.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
       
        
        if presetColor != .clear {
            context.setFillColor(presetColor.cgColor)
            context.fill(rect)
        } else {
            for y : CGFloat in stride(from: 0.0 ,to: rect.height, by: elementSize) {
                var saturation = y < rect.height / 2.0 ? CGFloat(2 * y) / rect.height : 2.0 * CGFloat(rect.height - y) / rect.height
                saturation = CGFloat(powf(Float(saturation), y < rect.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
                let brightness = y < rect.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rect.height - y) / rect.height
                for x : CGFloat in stride(from: 0.0 ,to: rect.width, by: elementSize) {
                    let hue = x / rect.width
                    let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
                    context.setFillColor(color.cgColor)
                    context.fill(CGRect(x:x, y:y, width:elementSize,height:elementSize))
                }
            }
        }
        
        if isSelect {
            let parentCenter:CGPoint = CGPoint(x: rect.midX, y: rect.midY);
            let circleWidth = rect.width/2
            let circleHeight = rect.height/2
            let circleX = parentCenter.x - circleWidth/2
            let circleY = parentCenter.y - circleHeight/2
            let circleRect: CGRect = CGRect(x: circleX, y: circleY, width: circleWidth, height: circleHeight)
            drawRectChecked(rect: circleRect)
        }
        
    }
    
    func drawRectChecked(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let checkmarkBlue2 = UIColor(red: 0.078, green: 0.435, blue: 0.875, alpha: 1)
        let shadow2 = UIColor.black
        
        let shadow2Offset = CGSize(width: 0.1, height: -0.1)
        let shadow2BlurRadius = 2.5
        let frame = rect
        let group = CGRect(x: frame.minX + 3, y: frame.minY + 3, width: frame.width - 6, height: frame.height - 6)
        
        let checkedOvalPath = UIBezierPath(ovalIn: CGRect(x: group.minX + floor(group.width * 0.00000 + 0.5), y: group.minY + floor(group.height * 0.00000 + 0.5), width: floor(group.width * 1.00000 + 0.5) - floor(group.width * 0.00000 + 0.5), height: floor(group.height * 1.00000 + 0.5) - floor(group.height * 0.00000 + 0.5)))
        
        context!.saveGState()
        context!.setShadow(offset: shadow2Offset, blur: CGFloat(shadow2BlurRadius), color: shadow2.cgColor)
        checkmarkBlue2.setFill()
        checkedOvalPath.fill()
        context!.restoreGState()
        UIColor.white.setStroke()
        checkedOvalPath.lineWidth = 1
        checkedOvalPath.stroke()
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: group.minX + 0.27083 * group.width, y: group.minY + 0.54167 * group.height))
        bezierPath.addLine(to: CGPoint(x: group.minX + 0.41667 * group.width, y: group.minY + 0.68750 * group.height))
        bezierPath.addLine(to: CGPoint(x: group.minX + 0.75000 * group.width, y: group.minY + 0.35417 * group.height))
        bezierPath.lineCapStyle = CGLineCap.square
        UIColor.white.setStroke()
        bezierPath.lineWidth = 1.3
        bezierPath.stroke()
    }
    
    func drawRectGrayedOut(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let grayTranslucent = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        let shadow2 = UIColor.black
        let shadow2Offset = CGSize(width: 0.1, height: -0.1)
        let shadow2BlurRadius = 2.5
        let frame = self.bounds
        let group = CGRect(x: frame.minX + 3, y: frame.minY + 3, width: frame.width - 6, height: frame.height - 6)
        let uncheckedOvalPath = UIBezierPath(ovalIn: CGRect(x: group.minX + floor(group.width * 0.00000 + 0.5), y: group.minY + floor(group.height * 0.00000 + 0.5), width: floor(group.width * 1.00000 + 0.5) - floor(group.width * 0.00000 + 0.5), height: floor(group.height * 1.00000 + 0.5) - floor(group.height * 0.00000 + 0.5)))
        
        context!.saveGState()
        context!.setShadow(offset: shadow2Offset, blur: CGFloat(shadow2BlurRadius), color: shadow2.cgColor)
        grayTranslucent.setFill()
        uncheckedOvalPath.fill()
        context!.restoreGState()
        UIColor.white.setStroke()
        uncheckedOvalPath.lineWidth = 1
        uncheckedOvalPath.stroke()
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: CGPoint(x: group.minX + 0.27083 * group.width, y: group.minY + 0.54167 * group.height))
        bezierPath.addLine(to: CGPoint(x: group.minX + 0.41667 * group.width, y: group.minY + 0.68750 * group.height))
        bezierPath.addLine(to: CGPoint(x: group.minX + 0.75000 * group.width, y: group.minY + 0.35417 * group.height))
        bezierPath.lineCapStyle = CGLineCap.square
        UIColor.white.setStroke()
        bezierPath.lineWidth = 1.3
        bezierPath.stroke()
    }
    
    func drawRectOpenCircle(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let shadow = UIColor.black
        let shadowOffset = CGSize(width: 0.1, height: -0.1)
        let shadowBlurRadius = 0.5
        let shadow2 = UIColor.black
        let shadow2Offset = CGSize(width: 0.1, height: -0.1)
        let shadow2BlurRadius = 2.5
        let frame = self.bounds
        let group = CGRect(x: frame.minX + 3, y: frame.minY + 3, width: frame.width - 6, height: frame.height - 6)
        let emptyOvalPath = UIBezierPath(ovalIn: CGRect(x: group.minX + floor(group.width * 0.00000 + 0.5), y: group.minY + floor(group.height * 0.00000 + 0.5), width: floor(group.width * 1.00000 + 0.5) - floor(group.width * 0.00000 + 0.5), height: floor(group.height * 1.00000 + 0.5) - floor(group.height * 0.00000 + 0.5)))
        
        context!.saveGState()
        context!.setShadow(offset: shadow2Offset, blur: CGFloat(shadow2BlurRadius), color: shadow2.cgColor)
        
        context!.restoreGState()
        context!.saveGState()
        context!.setShadow(offset: shadowOffset, blur: CGFloat(shadowBlurRadius), color: shadow.cgColor)
        UIColor.white.setStroke()
        emptyOvalPath.lineWidth = 1
        emptyOvalPath.stroke()
        context!.restoreGState()
        
    }
}

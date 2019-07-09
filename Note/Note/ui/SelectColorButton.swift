//
//  SelectColorButton.swift
//  Note
//
//  Created by Pavel N on 7/9/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

@IBDesignable
class SelectColorButton: UIView {
    @IBInspectable var presetColor : UIColor = .clear
    @IBInspectable var isSelect:Bool = false
    
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
    }
}

//
//  ColorPickerViewController.swift
//  Note
//
//  Created by Pavel N on 7/10/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController, HSBColorPickerDelegate {
    
    var currenSelect:UIColor = .white {
        didSet{
            let adjasted:UIColor = currenSelect.adjust(brightnessBy: CGFloat(sliderBrightness?.value ?? 0.0))
            currenSelectLabel.backgroundColor = adjasted
            currenSelectLabel.text = adjasted.toHexString()
        }
    }
    var doneWasPressed:Bool = false
    @IBOutlet var sliderBrightness: UISlider!
    @IBOutlet var currenSelectLabel: UILabel!
    @IBOutlet var colorPickerScene: HSBColorPicker!
    @IBOutlet var brightlessTextLabel: UILabel!
    
    func HSBColorColorPickerTouched(sender: HSBColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizer.State) {
        self.currenSelect = color
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPickerScene.delegate = self
        currenSelect = .white
    }
    @IBAction func sliderBrightnessChanged(_ sender: UISlider) {
        let val = sender.value
        let adjasted:UIColor = currenSelect.adjust(brightnessBy: CGFloat(val))
        currenSelectLabel.backgroundColor = adjasted
        currenSelectLabel.text = adjasted.toHexString()
        let str:String = "Brightness \(val)"
        brightlessTextLabel.text = str
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if doneWasPressed {
            let destVC = segue.destination as? ViewController
            destVC?.selectedColor = currenSelect.adjust(brightnessBy: CGFloat(sliderBrightness?.value ?? 0.0))
        }
    }
    @IBAction func donePressed(_ sender: UIButton) {
        doneWasPressed = true
    }
}

extension UIColor {
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
    public func adjust(hueBy hue: CGFloat = 0, saturationBy saturation: CGFloat = 0, brightnessBy brightness: CGFloat = 0) -> UIColor {
        
        var currentHue: CGFloat = 0.0
        var currentSaturation: CGFloat = 0.0
        var currentBrigthness: CGFloat = 0.0
        var currentAlpha: CGFloat = 0.0
        
        if getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentAlpha) {
            return UIColor(hue: currentHue + hue,
                           saturation: currentSaturation + saturation,
                           brightness: currentBrigthness + brightness,
                           alpha: currentAlpha)
        } else {
            return self
        }
    }
}

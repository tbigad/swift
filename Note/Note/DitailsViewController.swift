//
//  ViewController.swift
//  Note
//
//  Created by Pavel N on 6/24/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

class DitailsViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet var colorButtonsStack: UIStackView!
    @IBOutlet var customColorBtn: SelectColorButton!
    @IBOutlet var dataPicker: UIDatePicker!
    @IBOutlet var textField: UITextView!
    
    var selectedColor: UIColor = .white {
        willSet {
            var findPreset:Bool = false
            for veiw in colorButtonsStack.arrangedSubviews {
                let btn:SelectColorButton? = veiw as? SelectColorButton
                if((btn) != nil) {
                    if btn?.presetColor == newValue {
                        btn?.isSelect = true
                        findPreset = true
                    } else {
                        btn?.isSelect = false
                    }
                }
                if !findPreset{
                    customColorBtn.isSelect = true
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedColor = .white
        self.HideKeyboard()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
    }

    @IBAction func switchPressed(_ sender: UISwitch) {
        dataPicker.isHidden = !sender.isOn
    }
    @IBAction func CustomColourPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToCustomColor", sender: self)
    }
    
    @IBAction func unwindFromPicker(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func colorBtnPressed(_ sender: SelectColorButton) {
        print(sender.presetColor)
        selectedColor = sender.presetColor
    }
    @IBAction func colorRedBtnPressed(_ sender: SelectColorButton) {
        colorBtnPressed(sender)
    }
    @IBAction func colorBlueBtnPressed(_ sender: SelectColorButton) {
        colorBtnPressed(sender)
    }
    @IBAction func colorYellowBtnPreset(_ sender: SelectColorButton) {
        colorBtnPressed(sender)
    }
    
}

extension UIViewController {
    func HideKeyboard(){
        let Tap:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
}


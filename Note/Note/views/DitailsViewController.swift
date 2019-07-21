//
//  ViewController.swift
//  Note
//
//  Created by Pavel N on 6/24/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

protocol DitailsViewDelegate {
    func dataDidChanged(data:Note?);
}

class DitailsViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var colorButtonsStack: UIStackView!
    @IBOutlet var customColorBtn: SelectColorButton!
    @IBOutlet var dataPicker: UIDatePicker!
    @IBOutlet var textField: UITextView!
    
    var note:Note?
    var delegate : DitailsViewDelegate?
    
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
        if(note == nil){
            note = Note("", "")
        }
        selectedColor = note?.color ?? .white
        if ((note?.autoRemoveDate) != nil) {
            dataPicker.date = (note?.autoRemoveDate)!
        }
        textField.text = note?.content
        titleField.text = note?.title
        
        self.HideKeyboard()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
    }

    override func viewWillDisappear(_ animated: Bool) {
        let n = Note(titleField.text!, textField.text, note!.priority,note!.uid , dataPicker.date, selectedColor)
        delegate?.dataDidChanged(data: n)
    }
    
    @IBAction func unwindToDitalis(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    @IBAction func switchPressed(_ sender: UISwitch) {
        dataPicker.isHidden = !sender.isOn
    }
    @IBAction func CustomColourPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToCustomColor", sender: self)
    }
        
    @IBAction func colorBtnPressed(_ sender: SelectColorButton) {
        print(sender.presetColor)
        selectedColor = sender.presetColor
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


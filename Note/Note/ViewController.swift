//
//  ViewController.swift
//  Note
//
//  Created by Pavel N on 6/24/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var dataPicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func switchPressed(_ sender: UISwitch) {
        dataPicker.isHidden = sender.isOn
    }
}


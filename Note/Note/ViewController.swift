//
//  ViewController.swift
//  Note
//
//  Created by Pavel N on 6/23/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(test(1, 1, 20))
    }
    func test(_ a: Int, _ b: Int, _ k: Int) -> Int {
        if k == 0 {
            return b
        }
        return test(b, a+b, k-1)
    }
}


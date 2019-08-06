//
//  LoadNotesDBOperation.swift
//  Note
//
//  Created by Pavel N on 7/30/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import Foundation

class LoadNotesDBOperation: BaseDBOperation {
    
    override init(notebook: FileNotebook) {
        super.init(notebook: notebook)
    }
    
    override func main() {
        notebook.loadFromFile()
        finish()
    }
}

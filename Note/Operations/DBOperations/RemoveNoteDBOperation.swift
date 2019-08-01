//
//  RemoveNoteDBOperation.swift
//  Note
//
//  Created by Pavel N on 7/30/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import Foundation

class RemoveNoteDBOperation: BaseDBOperation {
    private let note: Note
    
    init(note: Note,
         notebook: FileNotebook) {
        self.note = note
        super.init(notebook: notebook)
    }
    
    override func main() {
        notebook.remove(with: note.uid)
        notebook.saveToFile()
        finish()
    }
}

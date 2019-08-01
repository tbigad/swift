//
//  RemoveNoteOperation.swift
//  Note
//
//  Created by Pavel N on 7/31/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import Foundation
class RemoveNoteOperation : AsyncOperation {
    private let note: Note
    private let notebook: FileNotebook
    
    private let removeFromDbOperation: RemoveNoteDBOperation
    private let saveBackendOperation: SaveNotesBackendOperation
    
    private(set) var result: Bool? = false
    
    init(note: Note,
         notebook: FileNotebook,
         backendQueue: OperationQueue,
         dbQueue: OperationQueue)
    {
        self.note = note
        self.notebook = notebook
        
        removeFromDbOperation = RemoveNoteDBOperation(note: note, notebook: notebook)
        
        saveBackendOperation = SaveNotesBackendOperation(notes: [])
        
        super.init()
        
        let adapterOperation = BlockOperation() { [unowned removeFromDbOperation, unowned saveBackendOperation] in
            saveBackendOperation.notesarray = removeFromDbOperation.notebook.notesArray
        }
        
        adapterOperation.addDependency(removeFromDbOperation)
        
        saveBackendOperation.addDependency(adapterOperation)
        
        addDependency(removeFromDbOperation)
        addDependency(saveBackendOperation)
        
        dbQueue.addOperation(removeFromDbOperation)
        dbQueue.addOperation(adapterOperation)
        backendQueue.addOperation(saveBackendOperation)
    }
    
    override func main()
    {
        switch saveBackendOperation.result!
        {
        case .success:
            result = true
        case .failure:
            result = false
        }
        finish()
    }
}

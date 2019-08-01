//
//  LoadNotesOperation.swift
//  Note
//
//  Created by Pavel N on 7/31/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import Foundation

class LoadNotesOperation : AsyncOperation {
    private let notebook: FileNotebook
    
    private let loadDbOperation: LoadNotesDBOperation
    private let loadBackendOperation: LoadNotesBackendOperation
    
    private(set) var result: Bool? = false
    
    private let backendQueue: OperationQueue
    private let dbQueue: OperationQueue
    
    init(notebook: FileNotebook,
         backendQueue: OperationQueue,
         dbQueue: OperationQueue)
    {
        self.notebook = notebook
        
        self.dbQueue = dbQueue
        self.backendQueue = backendQueue
        
        loadDbOperation = LoadNotesDBOperation(notebook: self.notebook)
        loadBackendOperation = LoadNotesBackendOperation()        
        super.init()
        
        let replaceNotesOperation = BlockOperation()
        { [unowned loadBackendOperation] in
            switch loadBackendOperation.result!
            {
            case .success(let notes):
                self.notebook.replaseNotes(notes: notes)
            default:
                return
            }
            
        }
        
        replaceNotesOperation.addDependency(loadDbOperation)
        replaceNotesOperation.addDependency(loadBackendOperation)
        
        self.addDependency(replaceNotesOperation)
        
        dbQueue.addOperation(loadDbOperation)
        dbQueue.addOperation(replaceNotesOperation)
        backendQueue.addOperation(loadBackendOperation)
    }
    
    override func main()
    {
        switch loadBackendOperation.result!
        {
        case .success:
            result = true
        case .failure:
            result = false
        }
        finish()
    }
}

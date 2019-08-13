//
//  LoadNotesDBOperation.swift
//  Note
//
//  Created by Pavel N on 7/30/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import Foundation
import CoreData

class LoadNotesDBOperation: BaseDBOperation {
    
    override init(notebook: FileNotebook) {
        super.init(notebook: notebook)
    }
    
    override func main() {
        notebook.loadFromFile()
        fetchData()
    }
    
    func fetchData(){
        let request = NSFetchRequest <NoteObject>(entityName: UserSettings.shared.modelEntityName)
        var notes:[NoteObject]?
        do {
            notes = try backgroundContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        for n in notes ?? [NoteObject](){
            print(n.title)
        }
        finish()
    }
}

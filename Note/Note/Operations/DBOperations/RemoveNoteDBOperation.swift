//
//  RemoveNoteDBOperation.swift
//  Note
//
//  Created by Pavel N on 7/30/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import Foundation
import CoreData

class RemoveNoteDBOperation: BaseDBOperation {
    private let note: Note
    
    init(note: Note,
         notebook: FileNotebook) {
        self.note = note
        super.init(notebook: notebook)
    }
    
    override func main() {
        remove()
    }
    
    func remove(){
        let request = NSFetchRequest <NoteObject>(entityName: UserSettings.shared.modelEntityName)
        var notesCD:[NoteObject]?
        do {
            notesCD = try backgroundContext.fetch(request)
            let obj = notesCD?.first(where: {$0.id == note.uid})
            if obj != nil {
                backgroundContext.delete(obj!)
            }
            saveContext(context: backgroundContext)
        } catch {
            print(error.localizedDescription)
        }
        notebook.remove(with: note.uid)
        finish()
    }
}

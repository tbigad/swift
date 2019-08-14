//
//  LoadNotesDBOperation.swift
//  Note
//
//  Created by Pavel N on 7/30/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class LoadNotesDBOperation: BaseDBOperation {
    
    override init(notebook: FileNotebook) {
        super.init(notebook: notebook)
    }
    
    override func main() {
        //notebook.loadFromFile()
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
        var notesArray:NoteBook = NoteBook()
        for n in notes ?? [NoteObject](){
            let color = UIColor().fromHexString(hexString: n.color!)
            let note:Note = Note(n.title!,
                                 n.content!,
                                 Note.Priority.medium,
                                 n.id!,
                                 n.destryDate,
                                 color )
            
            notesArray.append(note)
        }
        notebook.replaseNotes(notes: notesArray)
        finish()
    }
}

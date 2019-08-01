//
//  FileNotebook.swift
//  Note
//
//  Created by Pavel N on 6/23/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import Foundation

class FileNotebook {
    public func add(note: Note) {
        if notesArray.contains(where: {$0.uid == note.uid}) {
            let index = notesArray.firstIndex(where: {$0.uid == note.uid})
            notesArray[index!] = note
        } else {
            notesArray.append(note)
        }
    }
    public func replaseNotes(notes: [Note]) {
        notesArray.removeAll()
        notesArray = notes
    }
    public func remove(with uid: String) {
        let index = indexByUId(uid);
        if index < 0 {
            return
        }
        notesArray.remove(at: index)
    }
    public func remove(at index: Int) {
        if index < 0 {
            return
        }
        notesArray.remove(at: index)
    }
    
    public func saveToFile(){
        // TODO: move path to init
        guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = docURL.appendingPathComponent("Notes.json")
        
        let notes = notesArray.map{ $0.json }
        do {
            let data = try JSONSerialization.data(withJSONObject: notes, options: [])
            try data.write(to: fileURL, options: [])
            print("saved to json")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    public func loadFromFile(){
        // TODO: move path to init
        guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = docURL.appendingPathComponent("Notes.json")
        do {
            let data = try Data(contentsOf: fileURL, options: [])
            guard let notes = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] else { return }
            notesArray = notes.map{ Note.parse(json: $0)! }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    private func indexByUId(_ uid: String) -> Int {
        for (index,note) in notesArray.enumerated() {
            if note.uid == uid {
                return index
            }
        }
        return -1
    }
    private(set) var notesArray : [Note] = []
}

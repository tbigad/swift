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
        if notes.contains(where: {$0.uid == note.uid}) {
            let index = notes.firstIndex(where: {$0.uid == note.uid})
            notes[index!] = note
        } else {
            notes.append(note)
        }
    }
    public func remove(with uid: String) {
        let index = indexByUId(uid);
        if index < 0 {
            return
        }
        notes.remove(at: index)
    }
    public func remove(at index: Int) {
        if index < 0 {
            return
        }
        notes.remove(at: index)
    }
    public func saveToFile() {
        let dirPath = getDirPath()
        
        for note in notes {
            let data = try? JSONSerialization.data(withJSONObject: note.json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let notePath = dirPath.appendingPathComponent(note.uid + ".json")
            let file = try? FileHandle(forUpdating: notePath)
            if file == nil {
                FileManager.default.createFile(atPath: notePath.path, contents: data)
            } else {
                try? data?.write(to: notePath)
            }
        }
    }
    public func loadFromFile() {
        let dirPath = getDirPath()
        let fileURLs = try? FileManager.default.contentsOfDirectory(at: dirPath, includingPropertiesForKeys: nil)
        if fileURLs == nil && fileURLs!.isEmpty {
            return
        }
        for url in fileURLs! {
            if let jsonData = try? Data(contentsOf: url, options: Data.ReadingOptions.mappedIfSafe)
            {
                do {
                    let dict = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    print(dict)
                
                    let data = try JSONSerialization.data(withJSONObject: dict, options: [])
                    
                    print(data)
                    let js = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                    print(js)
                    
                    if let note = Note.parse(json: js )  {
                        add(note: note)
                    }
                } catch { }
                
            }
        }
        
    }
    
    private func getDirPath() -> URL {
        let fileManager = FileManager.default
        guard let dirPath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("MyNotes") else {
            return URL(fileURLWithPath: "")
        }
        print(dirPath.path)
        
        var isDir: ObjCBool = false
        if !fileManager.fileExists(atPath: dirPath.path, isDirectory: &isDir), !isDir.boolValue {
            try? fileManager.createDirectory(at: dirPath,withIntermediateDirectories: true, attributes: nil)
        }
        return dirPath
    }
    
    private func indexByUId(_ uid: String) -> Int {
        for (index,note) in notes.enumerated() {
            if note.uid == uid {
                return index
            }
        }
        return -1
    }
    private(set) var notes : [Note] = []
}

//
//  MainViewController.swift
//  Note
//
//  Created by Pavel N on 7/15/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {

    var noteBook = FileNotebook()
    private let dbOperationQueue = OperationQueue()
    private let backendOperationQueue = OperationQueue()
    private let commonQueue =  OperationQueue()
    
    @IBOutlet var notesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notesTableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "Note")
        
        let loadNotesOperation = LoadNotesOperation(notebook: noteBook, backendQueue: backendOperationQueue, dbQueue: dbOperationQueue)
        loadNotesOperation.completionBlock = {
            OperationQueue.main.addOperation {
                self.notesTableView.reloadData()
            }
        }
        commonQueue.addOperation(loadNotesOperation)
        dbOperationQueue.maxConcurrentOperationCount = 1
        backendOperationQueue.maxConcurrentOperationCount = 1
    }
    

    @IBAction func addNewBtnPressed(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        notesTableView.setEditing(!notesTableView.isEditing, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DitailsViewController, segue.identifier == "goToNoteDitails" {
            controller.delegate = self
            if let row = notesTableView.indexPathForSelectedRow {
                controller.note = noteBook.notesArray[row.row]
                notesTableView.deselectRow(at: row, animated: true)
            } else {
                controller.note = nil
            }
        }
    }
}

extension MainViewController : UITableViewDataSource, UITableViewDelegate, DitailsViewDelegate {
    
    func dataDidChanged(data: Note?) {
        if data != nil {            
            let saveNotesOperation = SaveNoteOperation(note: data!, notebook: noteBook, backendQueue: backendOperationQueue, dbQueue: dbOperationQueue)
            saveNotesOperation.completionBlock = {
                OperationQueue.main.addOperation{ self.notesTableView.reloadData() }
            }
            
            commonQueue.addOperation(saveNotesOperation)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return noteBook.notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath) as! NoteTableViewCell
        let note = noteBook.notesArray[indexPath.row]
        cell.textNoteLabel.text = note.content
        cell.titleLabel.text = note.title
        cell.noteColor = note.color
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removeNoteOperation = RemoveNoteOperation(note: noteBook.notesArray[indexPath.row], notebook: noteBook, backendQueue: backendOperationQueue, dbQueue: dbOperationQueue)
            
            removeNoteOperation.completionBlock =
                {
                    OperationQueue.main.addOperation(){
                        tableView.beginUpdates()
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        tableView.endUpdates()
                    }
            }
            
            commonQueue.addOperation(removeNoteOperation)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNoteDitails", sender: noteBook.notesArray[indexPath.row])
    }
}

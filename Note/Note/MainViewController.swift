//
//  MainViewController.swift
//  Note
//
//  Created by Pavel N on 7/15/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var notes = Note.simpleData()
    
    @IBOutlet var notesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        notesTableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "Note")
        // Do any additional setup after loading the view.
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
                controller.note = notes[row.row]
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
            if notes.contains(where: {$0.uid == data?.uid}) {
                let index = notes.firstIndex(where: {$0.uid == data?.uid})
                notes[index!] = data!
                print(notes[index!].title)
                notesTableView.reloadData()
            } else {
                notes.append(data!)
                notesTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath) as! NoteTableViewCell
        let note = notes[indexPath.row]
        cell.textNoteLabel.text = note.content
        cell.titleLabel.text = note.title
        cell.noteColor = note.color
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNoteDitails", sender: notes[indexPath.row])
    }
}

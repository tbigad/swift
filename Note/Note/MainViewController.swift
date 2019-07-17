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
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath) as! NoteTableViewCell
        let note = notes[indexPath.row]
        cell.textNoteLabel.text = note.content
        cell.titleLabel.text = note.title
        return cell
    }
    
    
}

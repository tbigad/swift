import Foundation

class SaveNoteDBOperation: BaseDBOperation {
    private let note: Note
    
    init(note: Note,
         notebook: FileNotebook) {
        self.note = note
        super.init(notebook: notebook)
    }
    
    override func main() {
        notebook.add(note: note)
        notebook.saveToFile()
        saveNote()
    }
    
    func saveNote(){
        backgroundContext.performAndWait {
            let object = NoteObject(context: backgroundContext) 
            object.color = self.note.color.toHexString()
            object.content = self.note.content
            object.destryDate = self.note.autoRemoveDate
            object.id = self.note.uid
            object.title = self.note.title
            saveContext(context: backgroundContext)
            finish()
        }
    }
}

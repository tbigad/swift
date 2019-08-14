import Foundation
import CoreData

class SaveNoteDBOperation: BaseDBOperation {
    private let note: Note
    
    init(note: Note,
         notebook: FileNotebook) {
        self.note = note
        super.init(notebook: notebook)
    }
    
    override func main() {
        notebook.add(note: note)
        saveNote()
    }
    
    func saveNote(){
        backgroundContext.performAndWait {
            let request = NSFetchRequest <NoteObject>(entityName: UserSettings.shared.modelEntityName)
            let predicate = NSPredicate(format: "id = %@", self.note.uid)
            request.predicate = predicate
            request.returnsObjectsAsFaults = false
            
            let object:NoteObject?
            do {
                let notes = try backgroundContext.fetch(request)
                if notes.isEmpty {
                    object = NoteObject(context: backgroundContext)
                } else {
                    object = notes.first
                }
                
                object?.color = self.note.color.toHexString()
                object?.content = self.note.content
                object?.destryDate = self.note.autoRemoveDate
                object?.id = self.note.uid
                object?.title = self.note.title
                
            } catch {
                print(error.localizedDescription)
            }
            
            saveContext(context: backgroundContext)
            finish()
        }
    }
}

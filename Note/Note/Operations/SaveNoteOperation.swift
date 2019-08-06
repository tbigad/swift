import Foundation

class SaveNoteOperation: AsyncOperation {
    private let note: Note
    private let notebook: FileNotebook
    private let saveToDb: SaveNoteDBOperation
    private var saveToBackend: SaveNotesBackendOperation
    
    private(set) var result: Bool? = false
    
    init(note: Note,
         notebook: FileNotebook,
         backendQueue: OperationQueue,
         dbQueue: OperationQueue) {
        self.note = note
        self.notebook = notebook
        
        saveToDb = SaveNoteDBOperation(note: note, notebook: notebook)
        saveToBackend = SaveNotesBackendOperation(notes: notebook.notesArray)

        super.init()
        
        saveToDb.completionBlock = {
            backendQueue.addOperation(self.saveToBackend)
        }
        
        addDependency(saveToBackend)
        addDependency(saveToDb)
        saveToBackend.addDependency(saveToDb)
        dbQueue.addOperation(saveToDb)
    }
    
    override func main() {
        switch saveToBackend.result! {
        case .success:
            result = true
        case .failure:
            result = false
        }
        finish()
    }
}

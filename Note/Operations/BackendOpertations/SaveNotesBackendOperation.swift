import Foundation

enum SaveNotesBackendResult {
    case success
    case failure(NetworkError)
}

class SaveNotesBackendOperation: BaseBackendOperation {
    var result: SaveNotesBackendResult?
    var notesarray:[Note] = []
    init(notes: [Note]) {
        notesarray = notes
        super.init()
    }
    
    override func main() {
        result = .failure(.unreachable)
        finish()
    }
}

import Foundation

enum LoadNotesBackendResult {
    case success
    case failure(NetworkError)
}

class LoadNotesBackendOperation : BaseBackendOperation {
    var result: LoadNotesBackendResult?
    var notes:[Note] = []
    
    init(notes: [Note]) {
        super.init()
    }
    
    override func main() {
        result = .failure(.unreachable)
        finish()
    }
}

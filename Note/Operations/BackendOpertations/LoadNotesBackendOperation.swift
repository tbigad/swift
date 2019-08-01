import Foundation

enum LoadNotesBackendResult {
    case success([Note])
    case failure(NetworkError)
}

class LoadNotesBackendOperation : BaseBackendOperation {
    var result: LoadNotesBackendResult?
    var notes:[Note] = []
    
    override init() {
        super.init()
    }
    
    override func main() {
        result = .failure(.unreachable)
        finish()
    }
}

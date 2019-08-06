import Foundation

enum SaveNotesBackendResult {
    case success
    case failure(NetworkError)
}

class SaveNotesBackendOperation: BaseBackendOperation {
    var result: SaveNotesBackendResult?
    var notesarray:NoteBook = []
    private let semaphore = DispatchSemaphore(value: 0)
    init(notes: NoteBook) {
        notesarray = notes
        super.init()
        
        if UserSettings.shared.gitHubLoginedIn {
            result = .failure(.unreachable)
            return
        }
    }
    
    func postGist(data: Data){
        let description = "Save Notes"
        let isPublic = false
        let file1 = FileUpload(content: String(data: data, encoding: .utf8)!)
        let files:[String:FileUpload] = [UserSettings.shared.gitHubGistFileName:file1]
        
        let gist = GitHubGistUpload(description: description, isPublic: isPublic, files: files)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let components = URLComponents(string: "https://api.github.com/gists")
        let url = components?.url
        var request = URLRequest(url: url!)
        
        request.setValue("token \(UserSettings.shared.gitHubToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "POST"
        do {
            let data = try encoder.encode(gist)
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                self.result = .success
                self.semaphore.signal()
                print("error:", error)
                return
            }
            self.result = .success
            self.semaphore.signal()
        }
        task.resume()
    }
    func patchGist(data:Data){
        let description = "Save Notes"
        let isPublic = false
        let file1 = FileUpload(content: String(data: data, encoding: .utf8)!)
        let files:[String:FileUpload] = [UserSettings.shared.gitHubGistFileName:file1]
        
        let gist = GitHubGistUpload(description: description, isPublic: isPublic, files: files)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let components = URLComponents(string: "https://api.github.com/gists/\(UserSettings.shared.gitHubGistID)")
        let url = components?.url
        var request = URLRequest(url: url!)
        
        request.setValue("token \(UserSettings.shared.gitHubToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "PATCH"
        do {
            let data = try encoder.encode(gist)
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                self.result = .success
                self.semaphore.signal()
                print("error:", error)
                return
            }
            self.result = .success
            self.semaphore.signal()
        }
        task.resume()
    }
    
    override func main() {
        let json = FileNotebook.toJsonData(notes: notesarray)
        if UserSettings.shared.gitHubGistID.isEmpty {
            postGist(data: json)
        } else {
            patchGist(data: json)
        }
        semaphore.wait()
        finish()
    }
}

import Foundation

enum LoadNotesBackendResult {
    case success([Note])
    case failure(NetworkError)
}

class LoadNotesBackendOperation : BaseBackendOperation {
    var result: LoadNotesBackendResult?
    var notes:[Note] = []
    let semaphore = DispatchSemaphore(value: 0)
    override init() {
        super.init()
        
        if !UserSettings.shared.gitHubLoginedIn {
            fail()
            return
        }
        let token = UserSettings.shared.gitHubToken
        
        let components = URLComponents(string: "https://api.github.com/gists")
        guard let url = components?.url else { return }
        var request = URLRequest(url: url)
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                self?.fail()
                print("error:", error)
                return
            }
            
            guard let data = data else {self?.fail();return }
            do {
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(GitHubGists.self, from: data)
                self?.findGistNote(gists: gitData)
            } catch let err {
                self?.semaphore.signal()
                print("Err", err)
            }
            
//            let gitData = FileNotebook.fromData(data: data)
//            print("count: " ,gitData.count)
//            self?.notes = gitData
//            self?.result = .success(gitData)
            
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//                self.tableView.refreshControl?.endRefreshing()
//                self.tableView.reloadData()
//            }
            
        }
        task.resume()
    }
    private func findGistNote(gists: GitHubGists) {
        for gist in gists {
            if let index = gist.files.firstIndex(where: {$0.value.filename == UserSettings.shared.gitHubGistFileName}) {
                let raw_url = gist.files[index].value.rawURL
                UserSettings.shared.gitHubGistID = gist.id
                downloadFila(url: raw_url)
                return
            }
        }
        fail()
    }
    
    private func downloadFila(url: String){
        
        guard let rUrl = URL(string:url) else {
            fail()
            return
        }
        var request = URLRequest(url: rUrl)
        request.setValue("token \(UserSettings.shared.gitHubToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error:", error)
                return
            }
            guard let data = data else {self.fail();return }
            self.notes = FileNotebook.fromData(data: data)
            self.success()
        }
        task.resume()
    }
    
    private func fail(){
        result = .failure(.unreachable)
        self.semaphore.signal()
    }
    
    private func success(){
        result = .success(notes)
        self.semaphore.signal()
    }
    
    override func main() {
        semaphore.wait()
        finish()
    }
}

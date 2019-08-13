import Foundation
import WebKit

protocol AuthViewControllerDelegate: class {
    func handleTokenChanged(token: String)
}

struct  userInfo {
    let clientSecret = "44e8541987aa527af96a6757fa6a6363644ef94f"
    let clientId = "a96cd7995e4e118e66d7"
    var code:String = ""
    var token:String = ""
}

struct GitHubToken: Codable {
    var access_token: String
    var token_type: String
    var scope: String
}

final class AuthViewController: UIViewController {

    weak var delegate: AuthViewControllerDelegate?
    var timer:Timer?
    private let webView = WKWebView()
    private var code: String = "" {
        didSet {
            info.code = self.code
            postRequest()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        guard let request = codeGetRequest else { return }
        webView.navigationDelegate = self
        webView.load(request)
        
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: {_ in
            DispatchQueue.main.async {
                self.info.token = ""
                self.dismiss(animated: true, completion: nil)
            }
        })
        
    }
    override func viewDidLayoutSubviews() {
        webView.frame = self.view.bounds
    }

    // MARK: Private
    
    private var access_token = ""
    
    private var info:userInfo = userInfo()
    
    private func setupViews() {
        view.backgroundColor = .white
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
    }

    private var codeGetRequest: URLRequest? {
        guard var urlComponents = URLComponents(string: "https://github.com/login/oauth/authorize") else { return nil }

        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "\(info.clientId)"),
            URLQueryItem(name: "scope", value: "gist")
        ]

        guard let url = urlComponents.url else { return nil }

        return URLRequest(url: url)
    }
    private func postRequest() {
        var components = URLComponents(string: "https://github.com/login/oauth/access_token")
        components?.queryItems = [URLQueryItem(name: "client_id", value: info.clientId),
                                  URLQueryItem(name: "client_secret", value: info.clientSecret),
                                  URLQueryItem(name: "code", value: code)]
        
        guard let url = components?.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) {  (data, response, error) in

            if data != nil {
                guard let newFiles = try? JSONDecoder().decode(GitHubToken.self, from: data!) else { return }
                self.info.token = newFiles.access_token
                self.delegate?.handleTokenChanged(token: newFiles.access_token)
                
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        task.resume()
    }
    
    private var haveCode = false
}

extension AuthViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let request = navigationAction.request
        if let url = request.url{
            let targetString = url.absoluteString.replacingOccurrences(of: "#", with: "?")
            guard let components = URLComponents(string: targetString) else { return }
            if !haveCode, let code = components.queryItems?.first (where: { $0.name == "code" })?.value {
                self.code = code
                haveCode = true
            }
        }
        do {
            decisionHandler(.allow)
        }
    }
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        
        if error.code == -1001 { // TIMED OUT:
            
            // CODE to handle TIMEOUT
            
        } else if error.code == -1003 { // SERVER CANNOT BE FOUND
            
            // CODE to handle SERVER not found
            
        } else if error.code == -1100 { // URL NOT FOUND ON SERVER
            
            // CODE to handle URL not found
            
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.timer?.invalidate()
    }
}

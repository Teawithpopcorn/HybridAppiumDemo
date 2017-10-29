
import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = UIColor(red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1.0)
        webView.scrollView.backgroundColor = UIColor(red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1.0)
        
        let myURL = URL(string: "http://10.10.10.101:3000")
        let myRequest = URLRequest(url: myURL!)
        webView.uiDelegate = self
        webView.load(myRequest)
    }
}


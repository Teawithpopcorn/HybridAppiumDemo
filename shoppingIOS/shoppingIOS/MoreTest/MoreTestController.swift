import UIKit

class MoreTestController: UIViewController {
    private var leakBlock: (() -> Void)?
    
    private var dataArray: [String] = []
    
    deinit {
        print("该函数永远不会被调用")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leakBlock = { () -> Void in
            self.dataArray = (1...100000).map{ "leak string \($0)!!!!!!"}
        }
    }
    
    @IBAction func onCrashButtonTap(_ sender: Any) {
        let number: Int? = nil
        _ = number!
    }
}

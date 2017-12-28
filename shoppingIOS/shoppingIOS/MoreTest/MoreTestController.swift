import UIKit

class MoreTestController: DataBurialPointController {
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
    @IBAction func onCycleButtonTouch(_ sender: Any)
    {
        var test: A? = A()
        test = nil
    }
}

class A:NSObject
{
    var b: B?=nil
    override init()
    {
        super.init()
        self.b = B()
        self.b?.a = self
    }
    deinit
    {
        print("A is deinited")
    }
}

class B {
    var a: A? = nil
    deinit
    {
        print("B is deinited")
    }
}





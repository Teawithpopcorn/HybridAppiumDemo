
import UIKit
import WebKit

class RecipeListController: UIViewController {
    let viewModel: RecipeListViewModel = RecipeListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.shouldShowLogin {
            viewModel.shouldShowLogin = false
            let loginVC = R.storyboard.login.loginViewController()!
            present(loginVC, animated: false, completion: nil)
        }
    }
}


import UIKit
import PromiseKit

class LoginViewController: DataBurialPointController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var completeAtion : ((_ recipes: [Recipe]) -> Void)?
    
    let viewModel = LoginViewModel()
    
    @IBAction func onLoginButtonTap(_ sender: Any) {
        let err = viewModel.validate()
        guard err == .none else {
            ShoppingHUD.showErrorMessageHUD(err.rawValue)
            return
        }
        
        modalTransitionStyle = .flipHorizontal
 
        ShoppingHUD.showProgressHUD()
        firstly {
            return RecipeAPI.fetchRecipes(lastId: nil)
        }.always {
            ShoppingHUD.hideProgressHUD()
        }.then { [weak self] recipes -> Void in
            self?.completeAtion?(recipes)
            self?.dismiss(animated: true, completion: nil)
        }.catch { _ -> Void in
            ShoppingHUD.showPromptMessageHUD("获取美食失败")
        }
    }
    
    @IBAction func onUserNameChanged(_ field: UITextField) {
        self.viewModel.userName = field.text
    }
    
    @IBAction func onPasswordChanged(_ field: UITextField) {
        self.viewModel.password = field.text
    }
}

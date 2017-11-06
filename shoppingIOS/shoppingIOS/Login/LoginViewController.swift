import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = LoginViewModel()
    
    @IBAction func onLoginButtonTap(_ sender: Any) {
        let err = viewModel.validate()
        guard err == .none else {
            ShoppingHUD.showErrorMessageHUD(err.rawValue)
            return
        }
        
        modalTransitionStyle = .flipHorizontal
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onUserNameChanged(_ field: UITextField) {
        self.viewModel.userName = field.text
    }
    
    @IBAction func onPasswordChanged(_ field: UITextField) {
        self.viewModel.password = field.text
    }
}

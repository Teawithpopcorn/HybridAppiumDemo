import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func onLoginButtonTap(_ sender: Any) {
        modalTransitionStyle = .flipHorizontal
        dismiss(animated: true, completion: nil)
    }
}

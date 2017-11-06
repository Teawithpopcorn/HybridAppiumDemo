import PKHUD
import Foundation

private let hudDelay = 1.5

class ShoppingHUD {
    class func showProgressHUD(_ message: String = "") {
        DispatchQueue.main.async {
            HUD.show(.labeledProgress(title: "", subtitle: message))
        }
    }
    
    class func hideProgressHUD() {
        DispatchQueue.main.async {
            HUD.hide()
        }
    }
    
    class func showPromptMessageHUD(_ message: String) {
        DispatchQueue.main.async {
            HUD.flash(.label(message), onView: UIApplication.shared.keyWindow!, delay: hudDelay)
        }
    }
    
    class func showErrorMessageHUD(_ error: String) {
        DispatchQueue.main.async {
            HUD.flash(.labeledError(title: "", subtitle: error), onView: UIApplication.shared.keyWindow!, delay: hudDelay)
        }
    }
}

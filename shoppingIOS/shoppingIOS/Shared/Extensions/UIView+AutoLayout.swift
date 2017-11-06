import UIKit

extension UIView {
    func addConstraints(formats: [String], views: [String : UIView]) {
        for format in formats {
            self.addConstraint(format: format, views: views)
        }
    }
    
    func addConstraint(format: String, views: [String : UIView]) {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: views)
        self.addConstraints(constraints)
    }
}

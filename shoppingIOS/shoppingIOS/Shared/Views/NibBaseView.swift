import UIKit

@IBDesignable
class NibBaseView: UIView {
    var nibView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    func initialize() {
        if let nibName = self.nibName {
            
            nibView = Bundle(for: AppDelegate.self)
                .loadNibNamed(nibName, owner: self, options: nil)?[0] as? UIView
            
            if let actualNibView = nibView {
                actualNibView.frame = self.bounds
                super.addSubview(actualNibView)
                
                actualNibView.translatesAutoresizingMaskIntoConstraints = false
                self.addConstraint(format: "H:|[view]|", views: ["view": actualNibView])
                self.addConstraint(format: "V:|[view]|", views: ["view": actualNibView])
            }
        }
    }
    
    override func layoutSubviews() {
        if let actualNibView = nibView {
            self.backgroundColor = actualNibView.backgroundColor
        }
        
        super.layoutSubviews()
    }
    
    override func addSubview(_ view: UIView) {
        if let actualNibView = nibView {
            actualNibView.addSubview(view)
        } else {
            super.addSubview(view)
        }
    }
    
    var nibName: String? {
        let typeLongName = type(of: self).description()
        let tokens = typeLongName.characters
            .split(maxSplits: 10, omittingEmptySubsequences: true, whereSeparator: {$0 == "."})
            .map { String($0) }
        return tokens.last!
    }
}

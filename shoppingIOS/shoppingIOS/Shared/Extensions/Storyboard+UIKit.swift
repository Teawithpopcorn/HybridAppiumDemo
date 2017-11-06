import UIKit

@IBDesignable extension UIView {
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

class BackgroundHighlightedButton: UIButton {
    @IBInspectable var highlightedBackgroundColor :UIColor?
    @IBInspectable var nonHighlightedBackgroundColor :UIColor?

    override var isHighlighted :Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                self.backgroundColor = highlightedBackgroundColor
            }
            else {
                self.backgroundColor = nonHighlightedBackgroundColor
            }
            super.isHighlighted = newValue
        }
    }
}


@IBDesignable
class ExtensionView: UIView {
}

@IBDesignable
class ExtensionLabel: UILabel {

    private var edgeInset = UIEdgeInsets.zero

    @IBInspectable
    var paddingLeft: CGFloat {
        get { return edgeInset.left }
        set { edgeInset.left = newValue }
    }

    @IBInspectable
    var paddingRight: CGFloat {
        get { return edgeInset.right }
        set { edgeInset.right = newValue }
    }

    @IBInspectable
    var paddingTop: CGFloat {
        get { return edgeInset.top }
        set { edgeInset.top = newValue }
    }

    @IBInspectable
    var paddingBottom: CGFloat {
        get { return edgeInset.bottom }
        set { edgeInset.bottom = newValue }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, edgeInset))
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = self.edgeInset
        var rect = super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x    -= insets.left
        rect.origin.y    -= insets.top
        rect.size.width  += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
}

@IBDesignable
class ExtensionButton: UIButton {

}

@IBDesignable
class ExtensionImageView: UIImageView {

}

@IBDesignable
class ExtensionTextField: UITextField {
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextFieldViewMode.never
            leftView = nil
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: color])
    }
}

@IBDesignable
class ExtensionTextView: UITextView {

    private var edgeInset = UIEdgeInsets.zero

    @IBInspectable
    var paddingLeft: CGFloat {
        get { return edgeInset.left }
        set { edgeInset.left = newValue
            textContainerInset = edgeInset
        }
    }

    @IBInspectable
    var paddingRight: CGFloat {
        get { return edgeInset.right }
        set { edgeInset.right = newValue
            textContainerInset = edgeInset
        }
    }

    @IBInspectable
    var paddingTop: CGFloat {
        get { return edgeInset.top }
        set { edgeInset.top = newValue
            textContainerInset = edgeInset
        }
    }

    @IBInspectable
    var paddingBottom: CGFloat {
        get { return edgeInset.bottom }
        set { edgeInset.bottom = newValue
            textContainerInset = edgeInset
        }
    }
}

@IBDesignable
class ExtensionTableViewCell: UITableViewCell {

}

@IBDesignable
class ExtensionCollectionViewCell: UICollectionViewCell {

}



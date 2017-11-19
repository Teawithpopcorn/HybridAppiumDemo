import UIKit

class RecipeDetailController: UIViewController {
    @IBOutlet weak var recipeDetail: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    
    @IBOutlet weak var comboRow: ComboRow!
    @IBOutlet weak var flavorRow: FlavorRow!
    
    var viewModel: RecipeDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
    }
    
    private func setupViews() {
        comboRow.bind(viewModel: viewModel.comboRowViewModel)
        flavorRow.bind(viewModel: viewModel.flavorsViewModel)
        
        comboRow.comboStateChanged = {[unowned self] () -> Void in
            self.updateViews()
        }
    }
    
    private func updateViews() {
        title = viewModel.name
        recipeDescription.text = viewModel.description
        recipeDetail.setImageWithUrlString(viewModel.picture, placeholder: R.image.recipe_placeholder()!)
    
        if viewModel.shouldShowFlavors {
            flavorRow.isHidden = false
        } else {
            flavorRow.isHidden = true
            viewModel.resetAllFlavors()
        }
    }
    
    @IBAction func onPurchaseButtonTap(_ sender: Any) {
        let error = viewModel.checkValid()
        guard error == .none else {
            ShoppingHUD.showPromptMessageHUD(error.rawValue)
            return
        }
    
        ShoppingHUD.showProgressHUD()
        
        let when = DispatchTime.now() + 1.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            ShoppingHUD.hideProgressHUD()
            ShoppingHUD.showPromptMessageHUD("购买成功")
            self.navigationController?.popViewController(animated: true)
        }
    }
}

import UIKit

class RecipeDetailController: UIViewController {
    @IBOutlet weak var recipeDetail: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    
    var viewModel: RecipeDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        title = viewModel.name
        recipeDescription.text = viewModel.description
        recipeDetail.setImageWithUrlString(viewModel.picture)
    }
    
    @IBAction func onPurchaseButtonTap(_ sender: Any) {
        
    }
}

import UIKit

class RecipeCell: UITableViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeDescription: UILabel!
    
    func bind(viewModel: RecipeCellViewModel) {
        recipeName.text = viewModel.name
        recipeDescription.text = viewModel.description
        
        recipeImage.setImageWithUrlString(viewModel.picture)
    }
}

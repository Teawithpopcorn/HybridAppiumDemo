class RecipeDetailViewModel {
    enum RecipeValidateError: String {
        case none
        case noComboError = "请选择套餐"
        case noFlavorError = "请选择口味"
    }
    
    var name: String {
        return recipe.name
    }
    
    var description: String {
        return recipe.description
    }
    
    var picture: String {
        return recipe.picture
    }
    
    var shouldShowFlavors: Bool {
        return comboRowViewModel.selectedCombo != .none && comboRowViewModel.selectedCombo != .two
    }
    
    private let recipe: Recipe
    
    let comboRowViewModel = ComboRowViewModel()
    let flavorsViewModel = FlavorRowViewModel()
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func checkValid() -> RecipeValidateError {
        guard comboRowViewModel.selectedCombo != .none else {
            return .noComboError
        }
        
        if comboRowViewModel.selectedCombo == .one && flavorsViewModel.selectedFlavor == .none {
            return .noFlavorError
        }
        
        return .none
    }

    func resetAllFlavors() {
        flavorsViewModel.updateFlavor(flavor: .none)
    }
}

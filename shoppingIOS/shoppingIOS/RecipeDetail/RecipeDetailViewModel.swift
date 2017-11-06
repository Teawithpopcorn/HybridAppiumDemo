class RecipeDetailViewModel {
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
        return comboRowViewModel.selectedCombo != .two
    }
    
    private let recipe: Recipe
    
    let comboRowViewModel = ComboRowViewModel()
    let flavorsViewModel = FlavorRowViewModel()
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }

    func resetAllFlavors() {
        flavorsViewModel.updateFlavor(flavor: .none)
    }
}

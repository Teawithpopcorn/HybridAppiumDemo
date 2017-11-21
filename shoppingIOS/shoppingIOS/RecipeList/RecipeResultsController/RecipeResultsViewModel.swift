class RecipeResultsViewModel {
    var searchText: String = "" {
        didSet {
            displayRecipes = searchRecipe(text: searchText)
        }
    }
    
    let recipes: [Recipe]
    init(recipes: [Recipe]) {
        self.recipes = recipes
    }

    private var displayRecipes: [Recipe] = []

    var hasData: Bool {
        return self.displayRecipes.count > 0
    }
    
    private func searchRecipe(text searchString: String) -> [Recipe] {
        guard !searchString.isEmpty else {
            return recipes
        }
        
        return recipes.filter { $0.name.range(of: searchString) != nil }
    }
    
    func cellViewModel(at index: Int) -> RecipeCellViewModel {
        return RecipeCellViewModel(recipe: displayRecipes[index])
    }
    
    func generateRecipeDetailViewModel(at index: Int) -> RecipeDetailViewModel {
        return RecipeDetailViewModel(recipe: displayRecipes[index])
    }
    
    func numberOfRows() -> Int {
        return displayRecipes.count
    }
}

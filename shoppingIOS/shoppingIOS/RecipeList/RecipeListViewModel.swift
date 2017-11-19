class RecipeListViewModel {
    var shouldShowLogin: Bool = true
    var searchText: String = "" {
        didSet {
            displayRecipes = searchRecipe(text: searchText)
        }
    }
    private let recipes: [Recipe]
    private var displayRecipes: [Recipe]
    
    init() {
        recipes = Mocks.recipes
        displayRecipes = recipes
    }
    
    private func searchRecipe(text searchString: String) -> [Recipe] {
        guard !searchString.isEmpty else {
            return recipes
        }
        
        return recipes.filter { $0.name.range(of: searchString) != nil }
    }
    
    func cellViewModel(at index: Int) -> RecipeCellViewModel {
        return  RecipeCellViewModel(recipe: displayRecipes[index])
    }
    
    func generateRecipeDetailViewMode(at index: Int) -> RecipeDetailViewModel {
        return RecipeDetailViewModel(recipe: cellViewModel(at: index).recipe)
    }
    
    func numberOfRows() -> Int {
        return displayRecipes.count
    }
}


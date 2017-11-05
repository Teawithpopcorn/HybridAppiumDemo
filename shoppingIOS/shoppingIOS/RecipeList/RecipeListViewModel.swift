class RecipeListViewModel {
    var shouldShowLogin: Bool = true
    var searchText: String = "" {
        didSet {
            displayRecipes = searchRecipe(text: searchText)
        }
    }
    
    private lazy var recipesViewModels = { () -> [RecipeCellViewModel] in
        return Mocks.recipes.map { return RecipeCellViewModel(recipe: $0) }
    }()
    
    private lazy var displayRecipes: [RecipeCellViewModel] = {return recipesViewModels }()
    
    private func searchRecipe(text searchString: String) -> [RecipeCellViewModel] {
        guard !searchString.isEmpty else {
            return recipesViewModels
        }
        
        return recipesViewModels.filter { $0.name.range(of: searchString) != nil }
    }
    
    func cellViewModel(at index: Int) -> RecipeCellViewModel {
        return displayRecipes[index]
    }
    
    func numberOfRows() -> Int {
        return displayRecipes.count
    }
}


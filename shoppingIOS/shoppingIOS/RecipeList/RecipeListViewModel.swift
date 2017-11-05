class RecipeListViewModel {
    var shouldShowLogin: Bool = true
    
    private lazy var recipesViewModels = { () -> [RecipeCellViewModel] in
        return Mocks.recipes.map { return RecipeCellViewModel(recipe: $0) }
    }()
    
    func cellViewModel(at index: Int) -> RecipeCellViewModel {
        return recipesViewModels[index]
    }
    
    func numberOfRows() -> Int {
        return recipesViewModels.count
    }
}


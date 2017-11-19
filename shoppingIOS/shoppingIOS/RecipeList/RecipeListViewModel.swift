class RecipeListViewModel: PageableListDataSource {
    var shouldShowLogin: Bool = true
    var searchText: String = "" {
        didSet {
            displayRecipes = searchRecipe(text: searchText)
        }
    }
    private var recipes: [Recipe] = [] {
        didSet {
            displayRecipes = recipes
        }
    }
    private var displayRecipes: [Recipe] = []
    
    func fetchPageableDataList(indexId: Int?) -> Promise<[PageableModel]> {
        return RecipeAPI.fetchRecipes(lastId: indexId)
            .then { [unowned self] recipes -> [PageableModel] in
                if indexId == nil {
                    self.recipes = []
                }
                
                self.recipes += recipes
                return recipes
        }
    }
    
    var pageableDataSource: [PageableModel] {
        return self.displayRecipes
    }
    
    var hasData: Bool {
        return self.pageableDataSource.count > 0
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


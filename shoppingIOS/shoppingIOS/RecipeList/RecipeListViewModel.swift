class RecipeListViewModel: PageableListDataSource {
    var shouldShowLogin: Bool = true

    var recipes: [Recipe] = []
    
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
        return self.recipes
    }
    
    var hasData: Bool {
        return self.pageableDataSource.count > 0
    }
    
    func cellViewModel(at index: Int) -> RecipeCellViewModel {
        return RecipeCellViewModel(recipe: recipes[index])
    }
    
    func generateRecipeDetailViewModel(at index: Int) -> RecipeDetailViewModel {
        return RecipeDetailViewModel(recipe: recipes[index])
    }
    
    func generateRecipeResultsViewModel() -> RecipeResultsViewModel {
        return RecipeResultsViewModel(recipes: recipes)
    }
    
    func numberOfRows() -> Int {
        return recipes.count
    }
}


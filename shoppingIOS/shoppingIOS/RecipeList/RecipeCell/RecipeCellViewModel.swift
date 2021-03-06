class RecipeCellViewModel {
    var name: String {
        return recipe.name
    }
    
    var description: String {
        return recipe.description
    }
    
    var picture: String {
        return recipe.picture
    }
    
    let recipe: Recipe
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}

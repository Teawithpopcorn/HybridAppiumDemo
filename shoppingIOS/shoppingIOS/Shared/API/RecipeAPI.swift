class RecipeAPI {
    class func fetchRecipes() -> Promise<[Recipe]> {
        return ShoppingAPIClient
            .get(endpoint: "/recipes")
            .responseModel(type: [Recipe].self)
    }
}

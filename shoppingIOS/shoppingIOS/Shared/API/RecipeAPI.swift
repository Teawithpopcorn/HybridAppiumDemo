class RecipeAPI {
    class func fetchRecipes(lastId: Int?) -> Promise<[Recipe]> {
        let startId = lastId ?? 0
        
        return ShoppingAPIClient
            .get(endpoint: "/recipes?_start=\(startId)&_limit=\(pageSize)")
            .responseModel(type: [Recipe].self)
    }
}

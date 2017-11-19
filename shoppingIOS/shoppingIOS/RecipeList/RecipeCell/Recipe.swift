struct Recipe: Codable, PageableModel {
    let id: Int
    let name: String
    let description: String
    let picture: String
}

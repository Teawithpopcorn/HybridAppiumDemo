enum FlavorType: Int {
    case none = -1
    case hotALittle
    case hot
    case veryHot
}

class FlavorRowViewModel {
    var selectedFavor: FlavorType = .none
}

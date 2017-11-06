enum FlavorType: Int {
    case none = -1
    case hotALittle
    case hot
    case veryHot
}

class FlavorRowViewModel {
    var selectedFlavor: FlavorType = .none
    var selectedFlavorChanged: ((_ flavor: FlavorType) -> Void)?
    
    func updateFlavor(flavor: FlavorType) {
        selectedFlavor = flavor
        selectedFlavorChanged?(flavor)
    }
}

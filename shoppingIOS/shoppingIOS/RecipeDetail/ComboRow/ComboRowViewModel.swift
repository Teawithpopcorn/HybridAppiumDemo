enum ComboType: Int {
    case none = -1
    case one
    case two
}

class ComboRowViewModel {
    var selectedCombo: ComboType = .none
}

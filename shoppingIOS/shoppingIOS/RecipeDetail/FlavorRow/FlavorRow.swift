class FlavorRow: NibBaseView {
    @IBOutlet weak var hotALittleButton: StateButton!
    @IBOutlet weak var hotButton: StateButton!
    @IBOutlet weak var veryHotButton: StateButton!
    
    let viewModel = FlavorRowViewModel()
    
    private var buttons: [StateButton] {
        return [hotALittleButton, hotButton, veryHotButton]
    }
    
    private func getComboType(_ button: StateButton?) -> FlavorType {
        guard let button = button, let index = buttons.index(of: button) else {
            return .none
        }
        
        return FlavorType(rawValue: index)!
    }
    
    
    @IBAction func onHotButtonsTap(_ sender: StateButton) {
        let newType = getComboType(sender)
        
        resetAllSelected()
        if newType == viewModel.selectedFavor {
            viewModel.selectedFavor = .none
        } else {
            viewModel.selectedFavor = newType
            sender.isSelected = !sender.isSelected
        }
    }
    
    private func resetAllSelected() {
        buttons.forEach{ $0.isSelected = false }
    }
}

class FlavorRow: NibBaseView {
    @IBOutlet weak var hotALittleButton: StateButton!
    @IBOutlet weak var hotButton: StateButton!
    @IBOutlet weak var veryHotButton: StateButton!
    
    var viewModel: FlavorRowViewModel!
    
    private var buttons: [StateButton] {
        return [hotALittleButton, hotButton, veryHotButton]
    }
    
    private func getComboType(_ button: StateButton?) -> FlavorType {
        guard let button = button, let index = buttons.index(of: button) else {
            return .none
        }
        
        return FlavorType(rawValue: index)!
    }
    
    func bind(viewModel: FlavorRowViewModel) {
        self.viewModel = viewModel
        self.viewModel.selectedFlavorChanged = {[weak self] (type: FlavorType) -> Void in
            self?.resetAllSelected()
            if type != .none {
                let button = self?.buttons[type.rawValue]
                button?.isSelected = true
            }
        }
    }
    
    @IBAction func onHotButtonsTap(_ sender: StateButton) {
        let newType = getComboType(sender)
        
        resetAllSelected()
        if newType == viewModel.selectedFlavor {
            viewModel.selectedFlavor = .none
        } else {
            viewModel.selectedFlavor = newType
            sender.isSelected = !sender.isSelected
        }
    }
    
    func resetAllSelected() {
        buttons.forEach{ $0.isSelected = false }
    }
}

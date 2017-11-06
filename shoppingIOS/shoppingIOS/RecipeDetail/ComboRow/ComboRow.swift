import UIKit

class ComboRow: NibBaseView {
    @IBOutlet weak var comboOne: StateButton!
    @IBOutlet weak var comboTwo: StateButton!
    
    let viewModel = ComboRowViewModel()
    
    private var buttons: [StateButton] {
        return [comboOne, comboTwo]
    }
    
    private func getComboType(_ button: StateButton?) -> ComboType {
        guard let button = button, let index = buttons.index(of: button) else {
            return .none
        }
        
        return ComboType(rawValue: index)!
    }
    
    @IBAction func onComboTap(_ sender: StateButton) {
        let newType = getComboType(sender)
        
        resetAllSelected()
        if newType == viewModel.selectedCombo {
            viewModel.selectedCombo = .none
        } else {
            viewModel.selectedCombo = newType
            sender.isSelected = !sender.isSelected
        }
    }
    
    private func resetAllSelected() {
        buttons.forEach{ $0.isSelected = false }
    }
}

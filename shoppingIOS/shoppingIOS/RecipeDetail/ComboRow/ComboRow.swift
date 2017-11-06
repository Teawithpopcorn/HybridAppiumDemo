import UIKit

class ComboRow: NibBaseView {
    @IBOutlet weak var comboOne: StateButton!
    @IBOutlet weak var comboTwo: StateButton!
    
    var comboStateChanged: (() -> Void)?
    
    var viewModel: ComboRowViewModel!
    
    func bind(viewModel: ComboRowViewModel) {
        self.viewModel = viewModel
    }
    
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
        
        comboStateChanged?()
    }
    
    private func resetAllSelected() {
        buttons.forEach{ $0.isSelected = false }
    }
}

import UIKit

protocol RecipeResultsControllerDelegate: class {
    func selectedResult(result: RecipeDetailViewModel)
}

class RecipeResultsController: DataBurialPointController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    weak var delegate: RecipeResultsControllerDelegate?
    
    var viewModel: RecipeResultsViewModel = RecipeResultsViewModel(recipes: []) {
        didSet {
            self.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let nib = R.nib.recipeCell()
        let idString = R.reuseIdentifier.recipeCell.identifier
        tableview.register(nib, forCellReuseIdentifier: idString)
        
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    func reloadData() {
        tableview.reloadData()
        noDataView.isHidden = viewModel.hasData
    }
}

extension RecipeResultsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        reloadData()
    }
}

extension RecipeResultsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idString = R.reuseIdentifier.recipeCell.identifier
        let recipeCell = tableView.dequeueReusableCell(withIdentifier: idString) as! RecipeCell
        recipeCell.bind(viewModel: viewModel.cellViewModel(at: indexPath.row))
        return recipeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        self.delegate?.selectedResult(result: viewModel.generateRecipeDetailViewModel(at: indexPath.row))
    }
}


import UIKit
import WebKit

class RecipeListController: UIViewController {
    let viewModel: RecipeListViewModel = RecipeListViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.shouldShowLogin {
            viewModel.shouldShowLogin = false
            let loginVC = R.storyboard.login.loginViewController()!
            present(loginVC, animated: false, completion: nil)
        }
    }
    
    private func setupViews() {
        let nib = R.nib.recipeCell()
        let idString = R.reuseIdentifier.recipeCell.identifier
        tableView.register(nib, forCellReuseIdentifier: idString)
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
}

extension RecipeListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        let vc = R.storyboard.main.recipeDetailController()!
        vc.viewModel = viewModel.generateRecipeDetailViewMode(at: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idString = R.reuseIdentifier.recipeCell.identifier
        let recipeCell = tableView.dequeueReusableCell(withIdentifier: idString) as! RecipeCell
        recipeCell.bind(viewModel: viewModel.cellViewModel(at: indexPath.row))
        return recipeCell
    }
}


extension RecipeListController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.searchText = ""
        tableView.reloadData()
    }
}

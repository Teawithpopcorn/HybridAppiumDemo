import UIKit

class RecipeListController: UIViewController {
    let viewModel: RecipeListViewModel = RecipeListViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataPlaceholderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.shouldShowLogin {
            viewModel.shouldShowLogin = false
            let loginVC = R.storyboard.login.loginViewController()!
            loginVC.completeAtion = { [unowned self] recipes -> Void in
                self.viewModel.recipes = recipes
                self.reloadList()
            }
            present(loginVC, animated: false, completion: nil)
        }
    }
    
    private func setupViews() {
        let nib = R.nib.recipeCell()
        let idString = R.reuseIdentifier.recipeCell.identifier
        tableView.register(nib, forCellReuseIdentifier: idString)
        searchBar.placeholder = "搜索美食"
        
        self.configPullRereshAndLoadMore()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        tableView.keyboardDismissMode = .onDrag
    }
    
    private func reloadList() {
        noDataPlacehoder?.isHidden = viewModel.hasData
        tableView.reloadData()
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

extension RecipeListController: PageableListController {
    var noDataPlacehoder: UIView? { return noDataPlaceholderView }
    var pageableViewModel: PageableListDataSource { return viewModel }
    var contentTableView: UITableView { return tableView! }
}

extension RecipeListController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("取消", for: .normal)
        }
        removePullRereshAndLoadMore()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        
        reloadList()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.searchText = ""
        searchBar.showsCancelButton = false

        configPullRereshAndLoadMore()
        reloadList()
    }
}

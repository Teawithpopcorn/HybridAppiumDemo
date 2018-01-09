import UIKit

class RecipeListController: DataBurialPointController {
    let viewModel: RecipeListViewModel = RecipeListViewModel()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataPlaceholderView: UIView!
    
    var recipeSearchController: UISearchController = ({
        let resultsController = R.storyboard.main.recipeResultsController()!
        let controller = UISearchController(searchResultsController: resultsController)
        controller.hidesNavigationBarDuringPresentation = true
        controller.dimsBackgroundDuringPresentation = true
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.sizeToFit()
        return controller
    })()
    
    weak var maskView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
        
        let managerItem:UIBarButtonItem = UIBarButtonItem(title: "管理",
                                                          style: UIBarButtonItemStyle.plain,
                                                          target: self,
                                                          action: #selector(showDBPManager))
        self.navigationItem.setLeftBarButton(managerItem, animated: false)
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
            present(loginVC, animated: false) { [unowned self] in
                self.maskView.removeFromSuperview()
            }
        }
    }
    
    private func setupViews() {
        let nib = R.nib.recipeCell()
        let idString = R.reuseIdentifier.recipeCell.identifier
        tableView.register(nib, forCellReuseIdentifier: idString)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        
        let view = UIView(frame: CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size))
        view.backgroundColor = UIColor(red: 0, green: 125/255.0, blue: 195/255.0, alpha: 1)
        UIApplication.shared.keyWindow?.addSubview(view)
        maskView = view
        
        let resultsController = recipeSearchController.searchResultsController as! RecipeResultsController
        tableView.tableHeaderView = recipeSearchController.searchBar
        recipeSearchController.searchResultsUpdater = self
        recipeSearchController.searchBar.delegate = resultsController
        resultsController.delegate = self
        recipeSearchController.delegate = self
        definesPresentationContext = true
        recipeSearchController.searchBar.placeholder = "搜索美食"
        
        configPullRereshAndLoadMore()
    }
    
    @objc private func showDBPManager()
    {
        let viewController :DBPManagerViewController = DBPManagerViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func reloadList() {
        noDataPlacehoder?.isHidden = viewModel.hasData
        tableView.reloadData()
    }
    
    private func transitionToDetailPage(viewModel: RecipeDetailViewModel) {
        let dbpModel:DataBurialPointModel = DataBurialPointModel()
        dbpModel.name = viewModel.name+"详情页"
        dbpModel.page = "RecipeDetailController"
        let vc = R.storyboard.main.recipeDetailController()!
        vc.viewModel = viewModel
        vc.dataBurialPointModel = dbpModel
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RecipeListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        transitionToDetailPage(viewModel: viewModel.generateRecipeDetailViewModel(at: indexPath.row))
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

extension RecipeListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //print("working....")
    }
}

extension RecipeListController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        let result = searchController.searchResultsController as! RecipeResultsController
        result.viewModel = viewModel.generateRecipeResultsViewModel()
    }
}

extension RecipeListController: RecipeResultsControllerDelegate {
    func selectedResult(result: RecipeDetailViewModel) {
        transitionToDetailPage(viewModel: result)
    }
}

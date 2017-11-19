import PromiseKit
import ESPullToRefresh

let pageSize: Int = 8

typealias ESRefreshType = ESRefreshProtocol & ESRefreshAnimatorProtocol

protocol PageableListController: class {
    var pageableViewModel: PageableListDataSource { get }
    var contentTableView: UITableView { get }
    var noDataPlacehoder: UIView? { get }
    
    func fetchFirstPageData(showHud: Bool)
    func fetchNextPageData(showHud: Bool)
    func configPullRereshAndLoadMore()
}

extension PageableListController {
    func fetchNextPageData(showHud: Bool) {
        if showHud {
            ShoppingHUD.showProgressHUD()
        }
        pageableViewModel.fetchNextPage()
            .always { [unowned self] () -> Void in
                if showHud {
                    ShoppingHUD.hideProgressHUD()
                }
                self.contentTableView.es.stopLoadingMore()
            }
            .then { [unowned self] (isLastPage: Bool) -> Void in
                self.reloadDataSource(isLastPage: isLastPage)
            }
            .catch{ error -> Void in
                if showHud {
                    ShoppingHUD.showErrorMessageHUD(error.localizedDescription)
                }
            }
    }
    
    func fetchFirstPageData(showHud: Bool) {
        contentTableView.es.resetNoMoreData()
        if showHud {
            ShoppingHUD.showProgressHUD()
        }
        
        pageableViewModel.fetchFirstPage()
            .always { [unowned self] () -> Void in
                if showHud {
                    ShoppingHUD.hideProgressHUD()
                }
                self.contentTableView.es.stopPullToRefresh()
            }
            .then { [unowned self] (isLastPage: Bool) -> Void in
                self.reloadDataSource(isLastPage: isLastPage)
            }
            .catch { error -> Void in
                if showHud {
                    ShoppingHUD.showErrorMessageHUD(error.localizedDescription)
                }
            }
    }
    
    private func reloadDataSource(isLastPage: Bool) {
        if isLastPage {
            self.contentTableView.es.noticeNoMoreData()
        }
        self.contentTableView.reloadData()
        self.noDataPlacehoder?.isHidden = pageableViewModel.pageableDataSource.count > 0
    }
    
    func configPullRereshAndLoadMore() {
        configPullRefresh()
        configLoadMore()
    }
    
    func removePullRereshAndLoadMore() {
        contentTableView.es.removeRefreshHeader()
        contentTableView.es.removeRefreshFooter()
    }
    
    private func configPullRefresh() {
        let header: ESRefreshType = RefreshHeaderAnimator()
        contentTableView.es.addPullToRefresh(animator: header) { [unowned self] in
            self.fetchFirstPageData(showHud: true)
        }
    }
    
    private func configLoadMore() {
        let footer: ESRefreshType = RefreshFooterAnimator()
        contentTableView.es.addInfiniteScrolling(animator: footer) { [unowned self] in
            self.fetchNextPageData(showHud: true)
        }
    }
}

protocol PageableModel {
    var id: Int { get }
}

protocol PageableListDataSource {
    func fetchPageableDataList(indexId: Int?) -> Promise<[PageableModel]>
    var pageableDataSource: [PageableModel] { get }
}

extension PageableListDataSource {
    func fetchFirstPage() -> Promise<Bool> {
        return fetchData(id: nil, pageSize: pageSize)
    }
    
    func fetchNextPage() -> Promise<Bool> {
        guard let lastModel: PageableModel = pageableDataSource.last else {
            return fetchFirstPage()
        }
        
        return fetchData(id: lastModel.id, pageSize: pageSize)
    }
    
    private func fetchData(id: Int?, pageSize: Int) -> Promise<Bool> {
        return fetchPageableDataList(indexId: id)
            .then {(value: [PageableModel]) -> Bool in
                let isLastPage = value.isEmpty || value.count < pageSize
                return isLastPage
        }
    }
}

class RefreshHeaderAnimator: ESRefreshHeaderAnimator {
    init() {
        super.init(frame: CGRect.zero)
        pullToRefreshDescription = NSLocalizedString("下拉刷新数据", comment: "")
        releaseToRefreshDescription = NSLocalizedString("松开刷新", comment: "")
        loadingDescription = NSLocalizedString("加载中...", comment: "")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RefreshFooterAnimator: ESRefreshFooterAnimator {
    init() {
        super.init(frame: CGRect.zero)
        loadingMoreDescription = NSLocalizedString("加载更多", comment: "")
        noMoreDataDescription = NSLocalizedString("没有更多数据", comment: "")
        loadingDescription = NSLocalizedString("加载中...", comment: "")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  RepositoryViewModel.swift
//  RobustaTask
//
//  Created by Mark Mokhles on 05/11/2022.
//

import Foundation

protocol RepositoriesViewModelProtocol {

    var onDataUpdate: (() -> Void)? { get set }
    var paginationRepositoriesCount: Int { get }

    func textFieldDidChange(query: String)
    func getCellModel(for index: Int) -> Repository
    func setPaginationRepositories()
    func onSelect(index: Int)
}

class RepositoriesViewModel: RepositoriesViewModelProtocol {

    init(dataSource: RepositoriesAPIServiceProtocol, router: RepositoriesRouterProtocol) {
        self.dataSource = dataSource
        self.router = router
        getRepositories()
    }
    
    // MARK: - iVars

    private var repositories: [Repository] = []
    private var repositoriesWithoutFilteration: [Repository] = []
    private var dataSource: RepositoriesAPIServiceProtocol
    private var router: RepositoriesRouterProtocol

    // MARK: - Pagination iVars

    private var repositoriesPerPage = 10
    private var limit = 10
    private var paginationRepositories: [Repository] = []

    var paginationRepositoriesCount: Int  {
        return paginationRepositories.count
    }

    var onDataUpdate: (() -> Void)?

    // MARK: - GetRepositories

    private func getRepositories() {
        dataSource.getRepositories { [weak self ] result in
            switch result {
            case .success(let repositories):

                self?.repositories = repositories
                self?.repositoriesWithoutFilteration = repositories
                self?.limit = self?.repositories.count ?? 0

                for i in 0...min(10, repositories.count - 1) {
                    self?.paginationRepositories.append(repositories[i])
                }
                self?.onDataUpdate?()

            case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: - Get PaginationRepositories

    func setPaginationRepositories() {
        if repositoriesPerPage >= limit {
            return
        }
        else if repositoriesPerPage >= limit - 10 {
            for i in repositoriesPerPage..<limit {
                paginationRepositories.append(repositories[i])
            }
            self.repositoriesPerPage += 10

        } else {
            for i in repositoriesPerPage..<repositoriesPerPage + 10 {
                paginationRepositories.append(repositories[i])
            }
            self.repositoriesPerPage += 10
        }

        onDataUpdate?()
    }

    func getCellModel(for index: Int) -> Repository {
        return paginationRepositories[index]
    }

    func textFieldDidChange(query: String) {
        var filterdItemsArray = [Repository]()
        func filterContentForSearchText(searchText: String) {
            filterdItemsArray = repositoriesWithoutFilteration.filter { item in
                return (item.repositoryName?.lowercased().contains(searchText.lowercased()))!
            }
        }
        if query.isEmpty {
            filterContentForSearchText(searchText: query )
            paginationRepositories = repositoriesWithoutFilteration
        } else if query.count >= 2 {
            filterContentForSearchText(searchText: query )
            paginationRepositories = filterdItemsArray
        }
        onDataUpdate?()
    }

    func onSelect(index: Int) {
        router.routeToDetails(repository: paginationRepositories[index])
    }
}



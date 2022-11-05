//
//  RepositoriesViewController.swift
//  RobustaTask
//
//  Created by Mark Mokhles on 04/11/2022.
//

import UIKit

class RepositoriesViewController: UIViewController {

    // MARK: - iBOutlets

    @IBOutlet weak var repositoriesTableView: UITableView!

    // MARK: - iVars

    var repositories: [Repository] = []

    // MARK: - Pagination iVars

    var repositoriesPerPage = 10
    var limit = 10
    var paginationRepositories: [Repository] = []

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Repositories List"
        getRepositories()
        ConfigureTableView()
    }

    // MARK: - Configure TableView

    func  ConfigureTableView() {
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        repositoriesTableView.register(UINib(nibName: String(describing: RepositoryTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: RepositoryTableViewCell.self))
    }

    // MARK: - GetRepositories

    func getRepositories() {
        APIService.sharedService.getReprositories { (repositories: [Repository]?, error) in
            guard let repositories = repositories else {
                return
            }
            self.repositories = repositories
            self.limit = self.repositories.count

            for i in 0...10 {
                self.paginationRepositories.append(repositories[i])
            }

            DispatchQueue.main.async {
                self.repositoriesTableView.reloadData()
            }
        }
    }

    // MARK: - Get PaginationRepositories

    func setPaginationRepositories(repositoriesPerPage: Int) {
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

        DispatchQueue.main.async {
            self.repositoriesTableView.reloadData()
        }
    }
}

//MARK: - TableView Dtatasource

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        paginationRepositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self), for: indexPath) as?  RepositoryTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: paginationRepositories[indexPath.row])

        return cell
    }
}

//MARK: - TableView Delegate

extension RepositoriesViewController: UITableViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if scrollView == repositoriesTableView {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height {

                setPaginationRepositories(repositoriesPerPage: repositoriesPerPage)
            }
        }
    }
}

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
            DispatchQueue.main.async {
                self.repositoriesTableView.reloadData()
            }
        }
    }
}

//MARK: - TableView Dtatasource

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self), for: indexPath) as?  RepositoryTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: repositories[indexPath.row])

        return cell
    }
}

//MARK: - TableView Delegate

extension RepositoriesViewController: UITableViewDelegate {}

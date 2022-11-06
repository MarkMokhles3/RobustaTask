//
//  RepositoriesViewController.swift
//  RobustaTask
//
//  Created by Mark Mokhles on 04/11/2022.
//

import UIKit

class RepositoriesViewController: UIViewController {

    init(viewModel: RepositoriesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "\(RepositoriesViewController.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    // MARK: - iBOutlets

    @IBOutlet private weak var repositoriesTableView: UITableView!
    @IBOutlet private weak var viewSearch: UIView!
    @IBOutlet private weak var txtFieldSearch: UITextField!

    // MARK: - iVars

    private var viewModel: RepositoriesViewModelProtocol

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Repositories List"
        setUpSearchView()
        configureTableView()
        viewModel.onDataUpdate = {
            DispatchQueue.main.async { [weak self] in
                self?.repositoriesTableView.reloadData()
            }
        }
    }

    // MARK: - Configure TableView

    private func configureTableView() {
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        repositoriesTableView.register(UINib(nibName: String(describing: RepositoryTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: RepositoryTableViewCell.self))
    }

    // MARK: - SetUp SearchView

    private func setUpSearchView() {
        viewSearch.backgroundColor = .darkGray
        viewSearch.setCornerRadius(radius:10)
        txtFieldSearch.font = UIFont(name: "regualar", size: 17)
        txtFieldSearch.keyboardType = .default
        txtFieldSearch.attributedPlaceholder = NSAttributedString(string: "Search for repository",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        txtFieldSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }

    // MARK: - TextField DidChange

    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.textFieldDidChange(query: textField.text ?? "")
    }
}

//MARK: - TableView Dtatasource

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.paginationRepositoriesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self), for: indexPath) as?  RepositoryTableViewCell else {
            return UITableViewCell()
        }
        let model = viewModel.getCellModel(for: indexPath.row)
        cell.configureCell(with: model)

        return cell
    }
}

//MARK: - TableView Delegate

extension RepositoriesViewController: UITableViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if scrollView == repositoriesTableView {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height {
                viewModel.setPaginationRepositories()
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.viewModel.onSelect(index: indexPath.row)
    }
}

// MARK: - TextField Delegate

extension RepositoriesViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

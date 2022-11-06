//
//  RepositoriesRouter.swift
//  RobustaTask
//
//  Created by Mark Mokhles on 06/11/2022.
//

import Foundation
import UIKit

protocol RepositoriesRouterProtocol {
    func routeToDetails(repository: Repository)
}

class RepositoriesRouter: RepositoriesRouterProtocol {
    private var navigationController: UINavigationController?

    func getRootViewController() -> UINavigationController {
        let dataSource = RepositoriesAPIService()
        let viewModel = RepositoriesViewModel(dataSource: dataSource, router: self)
        let viewController = RepositoriesViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        return navigationController
    }

    func routeToDetails(repository: Repository) {
        let newViewController = RepositoriesDetailsViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

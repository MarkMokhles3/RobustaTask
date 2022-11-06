//
//  RepositoriesAPIService.swift
//  RobustaTask
//
//  Created by Mark Mokhles on 06/11/2022.
//

import Foundation

class RepositoriesAPIService: RepositoriesAPIServiceProtocol {

    func getRepositories(completion: @escaping(Result<[Repository],Error>) -> Void) {
        APIService.sharedService.request(url: "https://api.github.com/repositories", completion: completion)
    }
}

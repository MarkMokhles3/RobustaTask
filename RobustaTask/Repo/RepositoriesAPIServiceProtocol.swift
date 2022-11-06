//
//  APIServiceProtocol.swift
//  RobustaTask
//
//  Created by Mark Mokhles on 06/11/2022.
//

import Foundation

protocol RepositoriesAPIServiceProtocol {
    func getRepositories(completion: @escaping(Result<[Repository],Error>) -> Void)
}

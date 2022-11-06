//
//  RepositoriesAPIServiceMock.swift
//  RobustaTaskTests
//
//  Created by Mark Mokhles on 06/11/2022.
//

import Foundation
@testable import RobustaTask

enum MockError: Error {
    case apiFailure
}
class RepositoriesAPIServiceMock: RepositoriesAPIServiceProtocol {

    var shouldFail = false

    func getRepositories(completion: @escaping (Result<[RobustaTask.Repository], Error>) -> Void) {
        if shouldFail {
            completion(.failure(MockError.apiFailure))
        } else {
            completion(.success(repositories))
        }
    }

    let repositories: [Repository] = [

        Repository(repositoryName: "Mark", owner: Owner(repositoryOwnerName: "Mokhles", ownerImageURL: "TestTest")),
        Repository(repositoryName: "2", owner: Owner(repositoryOwnerName: "3", ownerImageURL: "TestTest")),
        Repository(repositoryName: "4", owner: Owner(repositoryOwnerName: "5", ownerImageURL: "TestTest"))
        ]
}

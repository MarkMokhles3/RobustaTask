//
//  Repository.swift
//  RobustaTask
//
//  Created by Mark Mokhles on 04/11/2022.
//

import Foundation

// MARK: - Repository

struct Repository: Codable {
    var repositoryName: String?
    var owner: Owner?

    enum CodingKeys: String, CodingKey {
        case repositoryName = "name"
        case owner
    }
}

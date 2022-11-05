//
//  Owner.swift
//  RobustaTask
//
//  Created by Mark Mokhles on 04/11/2022.
//

import Foundation

// MARK: - Owner
struct Owner: Codable {
    var repositoryOwnerName: String?
    var ownerImageURL: String?

    enum CodingKeys: String, CodingKey {
        case repositoryOwnerName = "login"
        case ownerImageURL = "avatar_url"
    }
}


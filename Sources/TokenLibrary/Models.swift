//
//  File.swift
//
//
//  Created by Samdan Dansranbavuu on 2022.07.19.
//

import Foundation

struct ApiError: Codable {
    let field: String
    let issue: String
}

public struct Response: Codable {
    let code: Int
    let description: String?
    let details: [ApiError]?
}

public struct GetAuthTokenResponse: Codable {
    let access_token: String
    let expires: Int
}

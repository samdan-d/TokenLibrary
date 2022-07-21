//
//  File.swift
//
//
//  Created by Samdan Dansranbavuu on 2022.07.19.
//

import Foundation

typealias completeClosure = (_ data: Data?, _ error: Response?) -> Void

public enum HpsHttpClient {
    private static var accessToken = ""
    static let baseURL = URL(string: "https://test.hipay.mn/")!

    static func post(url: String, parameters: [String: Any], callback: @escaping completeClosure) {
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }

        let apiUrl = URL(string: url, relativeTo: baseURL)!

        print("HpsHttpClient", apiUrl.absoluteURL)

        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue(accessToken, forHTTPHeaderField: "Autorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody

        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, _, _ in
            if let body = data {
                let response = try? JSONDecoder().decode(Response.self, from: body)
                if response?.code == 1 {
                    callback(body, response)
                } else {
                    callback(nil, response)
                }
            }
        }
        task.resume()
    }

    static func setAccessToken(token: String?) {
        accessToken = token ?? ""
    }
}

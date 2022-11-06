//
//  APIService.swift
//  RobustaTask
//
//  Created by Mark Mokhles on 04/11/2022.
//

import Foundation

class APIService {

    static let sharedService = APIService()

    func request<T: Decodable>(url: String, completion: @escaping(Result<T,Error>) -> Void) {

        guard let url = URL(string: url) else { return }

        let session = URLSession.shared
        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(T.self, from: data )
                debugPrint(response)
                completion(.success(response))

            } catch {
                debugPrint(error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

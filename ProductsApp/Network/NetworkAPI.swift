//
//  APIService.swift
//  ProductsApp
//
//  Created by Sarah Saber on 01/10/2024.
//

import Foundation
import Combine

class NetworkAPI: NetworkAPIProtocol {
    static let shared = NetworkAPI()

    private init() {}

    func request<T: Decodable>(url: URL, responseType: T.Type) -> AnyPublisher<T, NetworkError> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.serverError("Server error")
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return error as? NetworkError ?? NetworkError.unknown
            }
            .eraseToAnyPublisher()
    }
}

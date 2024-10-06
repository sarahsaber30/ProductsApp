//
//  MockNetworkAPI.swift
//  ProductsAppTests
//
//  Created by Sarah Saber on 06/10/2024.
//

import Foundation
import Combine
@testable import ProductsApp

class MockNetworkAPI: NetworkAPIProtocol {
    
    var shouldReturnError = false
    var mockResponse: ProductResponse?
    
    func request<T: Decodable>(url: URL, responseType: T.Type) -> AnyPublisher<T, NetworkError> {
        if shouldReturnError {
            return Fail(error: NetworkError.serverError("Mock Error")).eraseToAnyPublisher()
        } else if let response = mockResponse as? T {
            return Just(response)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.unknown).eraseToAnyPublisher()
        }
    }
}



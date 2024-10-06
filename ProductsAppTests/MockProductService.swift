//
//  MockProductService.swift
//  ProductsAppTests
//
//  Created by Sarah Saber on 05/10/2024.
//

import Foundation
import Combine
@testable import ProductsApp

class MockProductService: ProductService {
    
    // A variable to hold the mocked response
    var stubbedProducts: ProductResponse?
    var shouldReturnError = false
    
    // Overriding the fetchProducts function to return a mock response
    override func fetchProducts(page: Int, category: ProductCategoryEnum) -> AnyPublisher<ProductResponse, NetworkError> {
        if shouldReturnError {
            return Fail(error: NetworkError.serverError("Mocked error"))
                .eraseToAnyPublisher()
        } else if let stubbedProducts = stubbedProducts {
            return Just(stubbedProducts)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.unknown)
                .eraseToAnyPublisher()
        }
    }
}

//
//  MockProductService.swift
//  ProductsAppTests
//
//  Created by Sarah Saber on 06/10/2024.
//

import Foundation
import Combine
@testable import ProductsApp

class MockProductService: ProductService {
    var shouldReturnError = false
    var stubbedProducts: ProductResponse?

    override func fetchProducts(page: Int, category: ProductCategoryEnum) -> AnyPublisher<ProductResponse, NetworkError> {
        if shouldReturnError {
            return Fail(error: NetworkError.serverError("Mocked Error")).eraseToAnyPublisher()
        } else if let products = stubbedProducts {
            return Just(products)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.unknown).eraseToAnyPublisher()
        }
    }
}

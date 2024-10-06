//
//  ProductService.swift
//  ProductsApp
//
//  Created by Sarah Saber on 05/10/2024.
//

import Combine
import Foundation

class ProductService {
    private let networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol = NetworkAPI.shared) {
        self.networkAPI = networkAPI
    }

    func fetchProducts(page: Int, category: ProductCategoryEnum) -> AnyPublisher<ProductResponse, NetworkError> {
        guard let url = URL(string: "\(category.url)&skip=\(page * Constants.pageSize)") else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        return networkAPI.request(url: url, responseType: ProductResponse.self)
    }
}


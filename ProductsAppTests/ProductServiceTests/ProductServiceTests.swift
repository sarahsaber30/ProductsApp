//
//  ProductServiceTests.swift
//  ProductsAppTests
//
//  Created by Sarah Saber on 06/10/2024.
//

import Foundation
import XCTest
import Combine
@testable import ProductsApp

class ProductServiceTests: XCTestCase {
    
    var productService: ProductService!
    var mockNetworkAPI: MockNetworkAPI!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkAPI = MockNetworkAPI()
        productService = ProductService(networkAPI: mockNetworkAPI) // Inject the mock network API
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testFetchProductsSuccess() {
        // Given
        let mockProducts = [Product(id: 1,
                                    title: "Product 1",
                                    description: "Description",
                                    category: "beauty",
                                    price: 10.0,
                                    discountPercentage: 5.0,
                                    rating: 4.5,
                                    stock: 10,
                                    sku: "12345",
                                    weight: 1,
                                    dimensions: Dimensions(width: 10, height: 10, depth: 10),
                                    warrantyInformation: "1 year",
                                    shippingInformation: "Ships in 2-3 days",
                                    availabilityStatus: "In Stock",
                                    reviews: [],
                                    returnPolicy: "30 days",
                                    minimumOrderQuantity: 1,
                                    images: ["image"],
                                    thumbnail: "image")]
        
        let mockProductResponse = ProductResponse(products: mockProducts, total: 100, skip: 0, limit: 10)
        mockNetworkAPI.mockResponse = mockProductResponse

        let expectation = XCTestExpectation(description: "Products are fetched successfully")

        // When
        productService.fetchProducts(page: 0, category: .beauty)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Expected success, error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { productResponse in
                // Then
                XCTAssertEqual(productResponse.products.count, 1)
                XCTAssertEqual(productResponse.products.first?.title, "Product 1")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchProductsFailure() {
        // Given
        mockNetworkAPI.shouldReturnError = true

        let expectation = XCTestExpectation(description: "Error is returned when fetching products")

        // When
        productService.fetchProducts(page: 0, category: .beauty)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error, NetworkError.serverError("Mock Error"))
                    expectation.fulfill() // Fulfill the expectation when the error is returned
                case .finished:
                    XCTFail("Expected failure")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

}

//
//  ProductViewModelTests.swift
//  ProductsAppTests
//
//  Created by Sarah Saber on 06/10/2024.
//

import Foundation
import XCTest
import Combine
@testable import ProductsApp

class ProductViewModelTests: XCTestCase {
    var viewModel: ProductViewModel!
    var mockProductService: MockProductService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockProductService = MockProductService()
        viewModel = ProductViewModel(productService: mockProductService)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }
    
    
    func testLoadProductsSuccess() {
        // Given
        let mockProducts = [Product(id: 1,
                                    title: "Mock Product",
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

        
        let mockProductResponse = ProductResponse(
            products: mockProducts,
            total: 100,
            skip: 0,
            limit: 10
        )

        mockProductService.stubbedProducts = mockProductResponse

        // Set up expectation for asynchronous loading
        let expectation = XCTestExpectation(description: "Products are loaded")

        // When
        viewModel.loadProducts()

        // Then
        viewModel.$products
            .sink { products in
                if !products.isEmpty {
                    XCTAssertEqual(products.count, 1)
                    XCTAssertEqual(products.first?.title, "Mock Product")
                    expectation.fulfill() // Fulfill the expectation when the product is loaded
                }
            }
            .store(in: &cancellables)

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testLoadProductsFailure() {
        // Given
        mockProductService.shouldReturnError = true
        
        // Set up expectation for the asynchronous call
        let expectation = XCTestExpectation(description: "Error handled, isLoading should be false")
        
        // When
        viewModel.loadProducts()
        
        // Then
        viewModel.$isLoading
            .sink { isLoading in
                if !isLoading {
                    XCTAssertFalse(isLoading, "isLoading should be false after an error")
                    expectation.fulfill() // Fulfill expectation when isLoading becomes false
                }
            }
            .store(in: &cancellables)
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0) // Wait for up to 5 seconds for the test to complete
    }
    
    
    func testBeautyButtonPressed() {
            // Given
            let mockProducts = [Product(id: 1,
                                        title: "Beauty Product",
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
                                        shippingInformation: "Ships in 3-5 days",
                                        availabilityStatus: "In Stock",
                                        reviews: [],
                                        returnPolicy: "30 days",
                                        minimumOrderQuantity: 1,
                                        images: ["image"],
                                        thumbnail: "image")]

            
            let mockProductResponse = ProductResponse(
                products: mockProducts,
                total: 100,
                skip: 0,
                limit: 10
            )

            mockProductService.stubbedProducts = mockProductResponse

            // Set up an expectation for the asynchronous call
            let expectation = XCTestExpectation(description: "Products loaded for beauty category")

            // When
            viewModel.beautyButtonPressed()

            // Then
            viewModel.$products
                .sink { products in
                    if !products.isEmpty {
                        XCTAssertEqual(products.first?.category, "beauty") // Check that the category is 'beauty'
                        expectation.fulfill() // Fulfill the expectation once the products are loaded
                    }
                }
                .store(in: &cancellables)

            XCTAssertEqual(viewModel.selectedCategory, .beauty)

            // Wait for the expectation to be fulfilled
            wait(for: [expectation], timeout: 5.0) // Wait for up to 5 seconds for the test to complete
        }

    func testResetFunction() {
        // Given
        viewModel.products = [Product(id: 1,
                                      title: "Mock Product",
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

        // When
        viewModel.reset()

        // Then
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertEqual(viewModel.currentPage, 0)
        XCTAssertTrue(viewModel.hasMorePages)
        XCTAssertFalse(viewModel.isLoading)
    }
}

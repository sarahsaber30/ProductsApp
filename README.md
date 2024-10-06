
This is a SwiftUI-based iOS application that fetches and displays a list of products from an API. It includes filtering by category, infinite scrolling, and product details views, the app also handles network requests using 'Combine' and offers mock data to enable easy testing.

## Features
- Product List: Displays a list of products from the API with pagination.
- Product Filtering: Filter products by category (e.g., beauty, fragrances).
- Product Details: Shows detailed information for each product.
- Mock Product Service & ProductViewModelTests: Allows testing using mocked services.

## Requirements
- iOS 14.0 or later
- Xcode 15
- Swift 5.0

## Running the Application

- The app will launch on the selected simulator/device, and you'll be taken to the product list screen.
- You can filter products by clicking on category buttons (e.g., Beauty, Fragrances).
- Scroll to the bottom of the list to trigger infinite scrolling (loads more products).
- Click on any product to navigate to the product details page.

### Assumptions

- The API response includes all required product data, such as product details, categories, and pagination.
- The 'ProductCategoryEnum' is predefined and all product categories are consistent with the backend API.


### Key Decisions

- Combine for Network Requests: The project uses 'Combine' to manage asynchronous network requests and state updates. This makes the app more reactive and flexible.
- Dependency Injection for Testing: The 'ProductService' is injected into the 'ProductViewModel' to enable the use of mock services for unit tests.
- SwiftUI for UI: SwiftUI was used 


### Challenges & Solutions

1. Dependency Injection for Mock Services
   - Challenge: Setting up unit tests without making real network requests was crucial to ensure tests are reliable and fast.
   - Solution: I used dependency injection in 'ProductViewModel' to inject a 'MockProductService' during tests, which allowed for easy testing of the product loading logic.

2. Pagination
   - Challenge: Implementing infinite scrolling while ensuring new data is appended correctly without duplication.
   - Solution: Managed pagination state using 'currentPage', 'hasMorePages', and 'isLoading' in the view model. Tracked when the last item in the list appeared to trigger the next page load.

3. SwiftUI and Network Requests
   - Challenge: Handling async network requests with 'Combine' in SwiftUI and ensuring UI updates happen on the main thread.
   - Solution: Used '.receive(on: DispatchQueue.main)' in the network pipeline to ensure that UI updates occur on the main thread after receiving data.


### Testing Coverage

- ViewModel Tests: Tested business logic in 'ProductViewModel', including loading products, resetting the product list, and handling pagination.
- Service Tests: Mocked the network layer in 'ProductService' to test the service's ability to fetch and decode product data.


## Installation

1. Clone the repository:

    git clone https://github.com/sarahsaber30/ProductsApp.git
    cd ProductsApp


2. Open the 'ProductsApp.xcodeproj' in Xcode:

   open ProductsApp.xcodeproj

3. Run the project by selecting a simulator or connecting an iOS device, then press 'Cmd+R' or click the Run button in Xcode.



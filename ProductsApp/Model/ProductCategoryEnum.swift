//
//  ProductEnum.swift
//  ProductsApp
//
//  Created by Sarah Saber on 05/10/2024.
//

import Foundation

enum ProductCategoryEnum: String {
    case beauty = "beauty"
    case fragrances = "fragrances"
    
    var url: String {
        
        switch self {
        case .beauty:
            return "\(Constants.baseURL)/category/\(self.rawValue)?limit=\(Constants.pageSize)"
        case .fragrances:
            return "\(Constants.baseURL)/category/\(self.rawValue)?limit=\(Constants.pageSize)"
        }
    }
    
}

//
//  ProductCardView.swift
//  ProductsApp
//
//  Created by Sarah Saber on 05/10/2024.
//

import Foundation
import SwiftUI

struct ProductCardView: View {
    let isOnSale: Bool = true
    let warranty: String = "1 year"
    
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // Price Section
            VStack(alignment: .leading, spacing: 5) {
                Text("EGP\(product.price, specifier: "%.2f")")
                    .font(.system(size: 18))
                    .bold()
                
                if isOnSale {
                    HStack(spacing: 5) {
                        Text("Sale")
                            .foregroundColor(.red)
                            .font(.caption)
                        
                        Text("EGP \(product.discountPercentage, specifier: "%.2f")")
                            .font(.caption)
                            .strikethrough()
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.top)
            
            Divider()
            
            // Stock and Warranty
            HStack {
                Text("\(product.availabilityStatus)")
                        .foregroundColor(.black)
                        .font(.caption)
                        .padding(6)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                
                Spacer()
                
                Text("Warranty: \(product.warrantyInformation)")
                    .foregroundColor(.black.opacity(0.8))
                    .fontWeight(.medium)
                    .font(.caption)
            }
            
            Divider()
            
            HStack(spacing: 24) {
                VStack {
                    Image(systemName: "creditcard")
                        .font(.system(size: 24))
                    Text("Cash or Card")
                        .font(.caption)
                    Text("Payment")
                        .font(.caption)
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: "arrow.uturn.left")
                        .font(.system(size: 24))
                    Text("30 days")
                        .font(.caption)
                    Text("Return Policy")
                        .font(.caption)
                }
            }
            .padding(.vertical)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
        .padding(.horizontal,24)
    }
}

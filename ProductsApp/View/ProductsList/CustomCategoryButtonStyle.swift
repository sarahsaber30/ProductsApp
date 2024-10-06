//
//  CustomCategoryButtonStyle.swift
//  ProductsApp
//
//  Created by Sarah Saber on 05/10/2024.
//

import Foundation
import SwiftUI

struct CustomCategoryButtonStyle: ButtonStyle {
    var isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .background(isSelected ? Color.gray.opacity(0.2) : Color.white )
            .cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(isSelected ? Color.gray.opacity(0.5) : Color.gray.opacity(0.5), lineWidth: 1)
            )
            .foregroundColor(Color.black)
            .font(.system(size: 12, weight: .medium))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Adds a scaling animation when click on button
    }
}

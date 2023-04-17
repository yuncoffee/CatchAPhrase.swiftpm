//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/17.
//

import SwiftUI

struct GradientBoxView: View {
    
    private var gradientStart = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
    private var gradientEnd = Color(#colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1))
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(
              gradient: .init(colors: [gradientStart, gradientEnd]),
              startPoint: .init(x: 0.5, y: 0),
              endPoint: .init(x: 0.5, y: 0.6)
            ))
    }
}


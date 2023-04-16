//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/17.
//

import SwiftUI

struct BackButtonView: View {
    
    var completion: ()->()
    
    var body: some View {
        Button {
            completion()
        } label: {
            Image(systemName: "arrow.backward")
        }
        .frame(width: 40, height: 40)
        .foregroundColor(CustomColor.gray05)
    }
}


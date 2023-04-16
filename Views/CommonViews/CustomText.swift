//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/16.
//

import SwiftUI

struct CustomText: View {
    
    var value = ""
    var fontSize = 64

    var body: some View {
        Text(value)
            .font(Font.custom("NanumMyeongjo-YetHangul", size: CGFloat(fontSize)))
    }
}

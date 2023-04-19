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
    var style = CustomFontStyle.Kr
    
    var body: some View {
        Text(value)
            .font(Font.custom(style.rawValue, size: CGFloat(fontSize)))
    }
}

enum CustomFontStyle: String {
    case Kr = "NanumMyeongjo-YetHangul"
    case En = "LibreBaskerville-Regular"
}

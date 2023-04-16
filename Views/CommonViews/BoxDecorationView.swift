//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/17.
//

import SwiftUI

struct BoxDecorationView: View {
    
    let lineStyle = StrokeStyle(lineWidth: 2,lineCap: .round, dash: [4, 6])
    
    var size: CGFloat = 320
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                DottedLine
            }
            .padding(.vertical, 20)
            VStack(spacing: 0) {
                DottedLine
            }
            .padding(.vertical, 20)
            .rotationEffect(Angle(degrees: 90))
            Rectangle()
                .border(CustomColor.gray03, width: 4)
                .foregroundColor(.clear)
        }
        .frame(width: size, height: size)
    }
}

// MARK: Views
extension BoxDecorationView {
    var DottedLine: some View {
        return ForEach(0..<7) { _ in
            Line()
                .stroke(CustomColor.gray03, style: lineStyle)
        }
    }
    
    struct Line: Shape {
        func path(in rect: CGRect) -> Path {
            let start = CGPoint(x: rect.minX, y: rect.midY)
            let end = CGPoint(x: rect.maxX, y: rect.midY)

            return Path { p in
                p.move(to: start)
                p.addLine(to: end)
            }
        }
    }
}

struct BoxDecorationView_Previews: PreviewProvider {
    static var previews: some View {
        BoxDecorationView()
    }
}

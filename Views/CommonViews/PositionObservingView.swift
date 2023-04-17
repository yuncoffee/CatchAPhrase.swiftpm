//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/16.
//

import SwiftUI

struct PositionObservingView<Content: View>: View {
    var coordinateSpace: CoordinateSpace
    
    @Binding
    var position: CGPoint
    
    @Binding
    var length: Double
    
    @ViewBuilder
    var content: () -> Content

    var body: some View {
        content()
            .background(GeometryReader { geometry in
                Color.clear.preference(
                    key: PreferenceKey.self,
                    value: geometry.frame(in: coordinateSpace).origin
                )
                .onAppear {
                    length = geometry.size.height / 2
                }
            })
            
            .onPreferenceChange(PreferenceKey.self) { position in
                self.position = position
            }
    }
}

private extension PositionObservingView {
    enum PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }

        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
            // No-op
        }
    }
}

struct OffsetObservingScrollView<Content: View>: View {
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    
    @Binding
    var offset: CGPoint
    
    @Binding
    var length: Double
    
    @ViewBuilder
    var content: () -> Content

    private let coordinateSpaceName = UUID()

    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
                            x: -newOffset.x,
                            y: -newOffset.y
                        )
                    }
                ),
                length: $length,
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}

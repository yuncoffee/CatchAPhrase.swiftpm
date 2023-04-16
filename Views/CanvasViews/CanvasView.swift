//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/14.
//

import SwiftUI

struct CanvasView: View {
    @EnvironmentObject
    var globalStore: GlobalStore
    
    var currentIndex: Int
    
    var body: some View {
        CanvasContainerView()
            .onAppear{
                globalStore.currentPoemIndex = currentIndex
            }
    }
}

// MARK: Views
extension CanvasView {
    func CanvasContainerView() -> some View {
        GeometryReader { geomtery in
            if #available(iOS 16.0, *) {
                HStack(spacing: globalStore.isFinished ? 0 : 24) {
                    if geomtery.size.width > 834 {
                        ScriptView()
                            .frame(minWidth: geomtery.size.width * 0.3,
                                   maxWidth: globalStore.isFinished ? .infinity : geomtery.size.width * 0.3,
                                   maxHeight: .infinity)
                            .background(CustomColor.gray01)
                            .cornerRadius(4)
                            .zIndex(1)
                    }
                    DialView()
                        .frame(
                            maxWidth: globalStore.isFinished ? 0 : .infinity,
                            maxHeight: .infinity
                        )
                        .background(CustomColor.gray01)
                        .cornerRadius(4)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(24)
                .background(CustomColor.gray02)
                .navigationTitle("Canvas")
                .toolbar(.hidden, for: .navigationBar)
                
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

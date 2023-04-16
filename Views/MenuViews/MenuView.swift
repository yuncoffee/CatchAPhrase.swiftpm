//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/14.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject
    var poemStore = PoemStore()
    
    @ObservedObject
    var globalStore: GlobalStore
    
    var body: some View {
        MenuContainerView(
            StageListView,
            BackLinkButtonView
        )
    }
}

// MARK: Views
extension MenuView {
    
    var BackLinkButtonView: some View {
        BackButtonView {
            presentationMode.wrappedValue.dismiss()
        }
        .position(x: 40, y: 40)
    }
    
    var StageListView: some View {
        LazyVGrid(columns: [GridItem(.fixed(240), spacing: 24), GridItem(.fixed(240), spacing: 24)], spacing: 24) {
            ForEach(0..<4) { index in
                ZStack {
                    BoxDecorationView(size: 240)
                    NavigationLink(destination: CanvasView(currentIndex: index)
                        .environmentObject(globalStore)
                        .environmentObject(poemStore)
                    ) {
                        CustomText(value: "\(poemStore.poems[index].thumbChar)", fontSize: 120)
                            .foregroundColor(CustomColor.gray06)
                    }
                }
            }
        }
    }
    
    func MenuContainerView( _ stageListView: any View, _ backLinkButtonView: any View) -> some View {
        GeometryReader { geometry in
            if #available(iOS 16.0, *) {
                ZStack {
                    VStack {
                        AnyView(stageListView)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(CustomColor.gray01)
                    .cornerRadius(4)
                    AnyView(backLinkButtonView)
                }
                .toolbar(.hidden, for: .navigationBar)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(24)
                .background(CustomColor.gray02)
            } else {
                
            }
        }
    }
}

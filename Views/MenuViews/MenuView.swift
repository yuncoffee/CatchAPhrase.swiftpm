//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/14.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject
    var globalStore: GlobalStore
    
    var body: some View {
        
        GeometryReader { geometry in
            if #available(iOS 16.0, *) {
                ZStack {
                    VStack {
                        LazyVGrid(columns: [GridItem(.fixed(240), spacing: 24), GridItem(.fixed(240), spacing: 24)], spacing: 24) {
                            ForEach(0..<4) { index in
                                ZStack {
                                    BoxDecorationView(size: 240)
                                    NavigationLink(destination: CanvasView(currentIndex: index).environmentObject(globalStore)) {
                                            CustomText(value: "가", fontSize: 120)
                                            .foregroundColor(CustomColor.gray06)
                                            
                                    }
                                    .toolbar(.hidden, for: .navigationBar)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(CustomColor.gray01)
                    .cornerRadius(4)

                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                    }
                    .frame(width: 40, height: 40)
                    .foregroundColor(CustomColor.gray05)
                    .position(x: 40, y: 40)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(24)
                .background(CustomColor.gray02)
            } else {
                
            }
        }
    }
}

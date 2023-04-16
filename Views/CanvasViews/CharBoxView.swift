//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/15.
//

import SwiftUI
import Foundation

struct CharBoxView: View {
    
    @EnvironmentObject
    var globalStore: GlobalStore
    
    @State
    private
    var draggedOffset = CGSize.zero
    
    @State
    private var translationY = 0.0 {
        didSet {
            print(translationY)
            if translationY < -320 {
                isSubmitAble = true
            }
        }
    }
    
    @State
    private var isSubmitAble = false

    var body: some View {
        ZStack() {
            BoxDecorationView()
            boxContentsView
            ReadCurrentCharView
                .frame(width: 40, height: 40)
                .background(CustomColor.siri_btn)
                .cornerRadius(50)
                .position(x: 300 - 12, y: 300 - 12)
        }
        .frame(width: 320, height: 320)
    }
}

// MARK: Views
extension CharBoxView {
    var boxContentsView: some View {
        CustomText(value: globalStore.currentCharcter, fontSize: draggedOffset.height < -100 ? 64 : 200)
            .offset(draggedOffset)
            .gesture(drag)
            .animation(.easeIn(duration: 0.1), value: draggedOffset)
            .opacity(isSubmitAble ? 0 : 1)
    }
    
    var ReadCurrentCharView: some View {
        Button {
            globalStore.readContentToSiri(contents: globalStore.currentCharcter)
        } label: {
            Image(systemName: "play.fill")
                .foregroundColor(CustomColor.black)
        }
    }
}

// MARK: Gesture
extension CharBoxView {
    var drag: some Gesture {
      DragGesture()
        .onChanged { gesture in
            translationY = gesture.translation.height
            draggedOffset = gesture.translation
        }
        .onEnded { gesture in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0)) {
                if isSubmitAble {
                    globalStore.compareTitleWithWord()
                }
                
                draggedOffset = .zero
                translationY = .zero
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    isSubmitAble = false
                }
            }
        }
    }
}

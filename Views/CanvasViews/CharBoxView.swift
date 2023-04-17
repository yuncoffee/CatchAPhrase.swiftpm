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
    
    @Binding
    var krScalers: [Int]
    
    @State
    private
    var draggedOffset = CGSize.zero
    
    @State
    private var translationY = 0.0 {
        didSet {
            let ios = globalStore.deviceOS == "iOS"
            let offset: Double = ios ? -240 : -320
            print(translationY)
            if translationY < offset {
                isSubmitAble = true
            }
        }
    }
    
    @State
    private var isSubmitAble = false

    var body: some View {
        let ios = globalStore.deviceOS == "iOS"
        
        ZStack() {
            BoxDecorationView(size: ios ? 240 : 320)
            boxContentsView
            ReadCurrentCharView
        }
        .frame(width: 320, height: 320)
    }
}

// MARK: Views
extension CharBoxView {
    var boxContentsView: some View {
        let ios = globalStore.deviceOS == "iOS"
        
        return CustomText(value: globalStore.currentCharcter, fontSize: draggedOffset.height < -100 ? 64 : ios ? 160 : 200)
            .offset(draggedOffset)
            .gesture(drag)
            .animation(.easeIn(duration: 0.1), value: draggedOffset)
            .opacity(isSubmitAble ? 0 : 1)
    }
    
    var ReadCurrentCharView: some View {
        let ios = globalStore.deviceOS == "iOS"
        
        return Button {
            globalStore.readContentToSiri(contents: globalStore.currentCharcter)
        } label: {
            Image(systemName: "play.fill")
                .foregroundColor(CustomColor.black)
            
        }
        .frame(width: 40, height: 40)
        .background(CustomColor.siri_btn)
        .cornerRadius(50)
        .position(x: ios ? 260 - 12 : 300 - 12, y: ios ? 260 - 12 : 300 - 12)
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
                    krScalers = [0, 0, 0]
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

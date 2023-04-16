//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/14.
//

import SwiftUI
import AVFoundation

struct ScriptView: View {
    @Environment(\.presentationMode)
    var presentationMode

    @EnvironmentObject
    var globalStore: GlobalStore
    
    @EnvironmentObject
    var poemStore: PoemStore
    
    var gradientStart = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
    var gradientEnd = Color(#colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1))
    
    @State
    private var scrollOffset = CGPoint()
    
    @State
    private var baseScrollOffset = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ScriptHeaderView
            PoemScriptView
            ScriptFooterView
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding(16)
    }
}


// MARK: Views
extension ScriptView {
    var ScriptHeaderView: some View {
        HStack(alignment: .top) {
            BackButtonView {
                // TODO: 초기화 시키는 로직 수정
                presentationMode.wrappedValue.dismiss()
                globalStore.isFinished = false
                globalStore.correctYetWord = "가나다"
                globalStore.correctWord = ""
            }
        }
        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
    }
    
    var PoemScriptView: some View {
        let poem = poemStore.poems[globalStore.currentPoemIndex]
        
        return ZStack(alignment: .bottomLeading) {
            OffsetObservingScrollView(offset: $scrollOffset, length: $baseScrollOffset) {
                CustomText(value: poem.contents, fontSize: 24)
                    .foregroundColor(
                        globalStore.isFinished
                            ? CustomColor.gray06
                            : CustomColor.gray03)
                    .padding(.bottom, 200)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            GradientBoxView
            PoemDetailInfoView
            
        }
        .frame(alignment: .bottomLeading)
    }
    
    var GradientBoxView: some View {
        Rectangle()
            .fill(LinearGradient(
              gradient: .init(colors: [gradientStart, gradientEnd]),
              startPoint: .init(x: 0.5, y: 0),
              endPoint: .init(x: 0.5, y: 0.6)
            ))
            .frame(height: 200)
            .opacity(globalStore.isFinished ? 0.1 : 1)
    }
    
    var PoemDetailInfoView: some View {
        let poem = poemStore.poems[globalStore.currentPoemIndex]

        return CustomText(value: "\(poem.name) (\(poem.author))", fontSize: 18)
            .foregroundColor(CustomColor.gray06)
            .opacity(baseScrollOffset < scrollOffset.y ? 1 : 0)
            .animation(.easeIn, value: scrollOffset)
    }
    
    var ScriptFooterView: some View {
        let poem = poemStore.poems[globalStore.currentPoemIndex]
        return HStack(alignment: .top) {
            Button {
                globalStore.readContentToSiri(contents: poem.contents)
            } label: {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
            }
            .frame(width: 40, height: 40)
            .foregroundColor(CustomColor.gray05)
            .border(CustomColor.gray03, width: 2)
            .cornerRadius(4)
        }
        .frame(maxWidth: .infinity, minHeight: 48, alignment: .trailing)
        .opacity(globalStore.isFinished ? 1 : 0)
    }
}

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
    
    @State
    private var scrollOffset = CGPoint()
    
    @State
    private var baseScrollOffset = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            if globalStore.deviceOS != "iOS" {
                ScriptHeaderView
            }
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
                presentationMode.wrappedValue.dismiss()
                globalStore.resetDialStatus()
                
            }
        }
        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
    }
    
    var PoemScriptView: some View {
        let poem = poemStore.poems[globalStore.currentPoemIndex]
        
        return ZStack(alignment: .bottomLeading) {
            OffsetObservingScrollView(offset: $scrollOffset, length: $baseScrollOffset) {
                CustomText(value: globalStore.isLanguageKr ? poem.krInfo.1 : poem.enInfo.1, fontSize: 24)
                    .foregroundColor(
                        globalStore.isFinished
                            ? CustomColor.gray06
                            : CustomColor.gray03)
                    .padding(.bottom, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            GradientBoxView()
                .opacity(globalStore.isFinished ? 0 : 1)
            VStack {
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
                    .foregroundColor(CustomColor.black)
                Text("\(globalStore.currentFirstPhrases.count) / \(globalStore.correctedFirstPhrases.count)")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .opacity(globalStore.isFinished ? 0 : 1)
        }
        .frame(alignment: .bottomLeading)
    }
    
    var PoemDetailInfoView: some View {
        let poem = poemStore.poems[globalStore.currentPoemIndex]

        return CustomText(value: globalStore.isLanguageKr ? "\(poem.krInfo.0) (\(poem.krInfo.2))" : "\(poem.enInfo.0) (\(poem.enInfo.2))", fontSize: 18)
            .foregroundColor(CustomColor.black)
    }
    
    var ScriptFooterView: some View {
        let poem = poemStore.poems[globalStore.currentPoemIndex]
        let iOS = globalStore.deviceOS == "iOS"
        return HStack(alignment: .center) {
            PoemDetailInfoView
            Spacer()
            HStack {
                Button {
                    globalStore.toggleLanguage()
                } label: {
                    Image(systemName: "globe")
                        .foregroundColor(CustomColor.black)
                }
                .frame(width: 40, height: 40)
                .background(CustomColor.siri_btn)
                .cornerRadius(50)
                Button {
                    globalStore.readContentToSiri(contents: poem.krInfo.1)
                } label: {
                    Image(systemName: "play.fill")
                        .foregroundColor(CustomColor.black)
                }
                .frame(width: 40, height: 40)
                .background(CustomColor.siri_btn)
                .cornerRadius(50)
            }

        }
        .frame(maxWidth: .infinity, minHeight: iOS ? 0 : 48, alignment: .trailing)
        .opacity(globalStore.isFinished ? 1 : 0)
    }
}

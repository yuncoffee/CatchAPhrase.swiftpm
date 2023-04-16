//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/14.
//

import SwiftUI
import AVFoundation

struct ScriptView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject
    var globalStore: GlobalStore
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    @State
    var poemText =
    """
    내 마음은 호수요 그대 노 저어오오
    
    나는 그대의 흰 그림자를 안고

    옥같이 그대의 뱃전에 부서지리다

    내 마음은 촛불이요

    그대 저 문을 닫아 주오

    내는 그대의 비단 옷자락에 떨며

    고요히 한 방울도 남김없이 타오리다

    내 마음은 나그네요

    그대 피리를 불어주오

    나는 달 아래 귀를 기울이며

    호젓이 나의 밤을 새우 리다

    내 마음은 낙엽이요

    잠깐 그대의 뜰에 머물게 하오

    이제 바람이 불면 나는 또 나그네와 같이

    외로이 그대를 떠나오리다
    
        잠깐 그대의 뜰에 머물게 하오

        이제 바람이 불면 나는 또 나그네와 같이

        외로이 그대를 떠나오리다
    """
    
    var gradientStart = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
    var gradientEnd = Color(#colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1))
    
    @State private var scrollOffset = CGPoint()
    @State private var testOffset = 0.0
    
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
            Button {
                presentationMode.wrappedValue.dismiss()
                globalStore.isFinished = false
                globalStore.correctYetWord = "가나다"
                globalStore.correctWord = ""
            } label: {
                Image(systemName: "arrow.backward")
            }
            .frame(width: 40, height: 40)
            .foregroundColor(CustomColor.gray05)
        }
        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
    }
    
    var PoemScriptView: some View {
        ZStack(alignment: .bottomLeading) {
            OffsetObservingScrollView(offset: $scrollOffset, length: $testOffset) {
                Text(poemText)
                    .foregroundColor(globalStore.isFinished ? CustomColor.gray06  :  CustomColor.gray03)
                    .font(Font.custom("NanumMyeongjoBold", fixedSize: 24))
                    .padding(.bottom, 200)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Rectangle()
                .fill(LinearGradient(
                  gradient: .init(colors: [gradientStart, gradientEnd]),
                  startPoint: .init(x: 0.5, y: 0),
                  endPoint: .init(x: 0.5, y: 0.6)
                ))
//                .border(.red)
                .frame(height: 200)
                .opacity(globalStore.isFinished ? 0.1 : 1)
                Text("김 동 명(1900-1968)")
                    .foregroundColor(CustomColor.gray06)
                    .font(Font.custom("NanumMyeongjoBold", fixedSize: 18))
//                    .border(.red)
                    .opacity(testOffset < scrollOffset.y ? 1 : 0)
                    .animation(.easeIn, value: scrollOffset)
            
        }
        .frame(alignment: .bottomLeading)
    }
    
    var ScriptFooterView: some View {
        HStack(alignment: .top) {
            Button {
                let speechUtterance = AVSpeechUtterance(string: poemText)
                                speechUtterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
                                speechSynthesizer.speak(speechUtterance)
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

//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/14.
//

import SwiftUI
import AVFoundation

struct DialView: View {
    
    @EnvironmentObject
    var globalStore: GlobalStore
    
    @StateObject
    var dialStore = DialStore()
    
    @State
    private var isAnimationStart = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CurrentScriptHeaderView
            Divider()
                .frame(height: 2)
                .background(CustomColor.gray04)
            CurrentDialView
        }
        .onReceive(dialStore.$krScalers) { krScalers in
            dialStore.updateCurrentCharcter(globalStore: globalStore)
        }
    }
}


// MARK: View
extension DialView {
    
    // MARK: CurrentDialView
    private var CurrentDialView: some View {
        GeometryReader { geometry in
            ZStack {
                let ios = globalStore.checkIsiOS()
                // left
                CharDialView
                    .rotationEffect(Angle(degrees: Double(dialStore.totalRotates[0].height)))
                    .gesture(rotationLeft)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: dialStore.totalRotates[0])
                    .position(x: ios ? -132 : -60, y: geometry.size.height / 2 - 24)
                // right
                CharDialView
                    .rotationEffect(Angle(degrees: Double(-dialStore.totalRotates[1].height)))
                    .gesture(rotationRight)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: dialStore.totalRotates[1])
                    .position(x: ios ? geometry.size.width + 132 : geometry.size.width + 60, y: geometry.size.height / 2 - 24)
                // btm
                CharDialView
                    .rotationEffect(Angle(degrees: Double(dialStore.totalRotates[2].width)))
                    .gesture(rotationBtm)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: dialStore.totalRotates[2])
                    .position(x: geometry.size.width / 2, y: ios ? geometry.size.height / 2 + 340 : geometry.size.height / 2 + 360)
                CharBoxView(krScalers: $dialStore.krScalers)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - 24)
                    .zIndex(-1)
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
                    .offset(y: dialStore.isShowAnimation ? -8 : 0)
                    .animation(.easeIn(duration: 0.4).repeatForever( autoreverses: true), value: dialStore.isShowAnimation)
                    .opacity(dialStore.isShowAnimation ? 1 : 0)
                    
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: CurrentScriptHeaderView
    private var CurrentScriptHeaderView: some View {
        GeometryReader { geometry in

            HStack(spacing: 0) {
                CustomText(value: globalStore.correctWord, fontSize: 64)
                    .foregroundColor(CustomColor.black)
                    .multilineTextAlignment(.center)
                CustomText(value: globalStore.correctYetWord, fontSize: 64)
                    .foregroundColor(isAnimationStart ? .red : CustomColor.gray03)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scaleEffect(globalStore.isWrongAnswerSubmited)
            .animation(.spring(response: 0.1, dampingFraction: 0.2, blendDuration: 0).repeatCount(3, autoreverses: true), value: globalStore.isWrongAnswerSubmited)
            .onChange(of: globalStore.isWrongAnswerSubmited) { newValue in
                if newValue == 0.9 {
                    isAnimationStart = true
                } else {
                    isAnimationStart = false
                }
            }
        }
        .frame(maxHeight: 100)
        .padding(.vertical, 16)
    }
    
    // MARK: CharDialView
    private var CharDialView: some View {
        ZStack {
            ForEach(0..<360) { deg in
                let isMarkableTic = deg % 4 == 0
                if deg % 6 == 0 {
                    Rectangle()
                        .frame(width: isMarkableTic ? 380 : 385, height: isMarkableTic ? 2 : 4)
                        .rotationEffect(Angle(degrees: Double(deg)))
                        .foregroundColor(isMarkableTic ? CustomColor.gray04 : CustomColor.black)
                }
            }
            Circle()
                .foregroundColor(CustomColor.gray01)
                .frame(width: 360)
        }
    }
}

// MARK: Gesutre Info
extension DialView {
    private var rotationLeft: some Gesture {
        DragGesture()
            .onChanged { value in
                dialStore.totalRotates[0].height = value.translation.height + dialStore.currentRotates[0].height
                
            }
            .onEnded { value in
                dialStore.currentRotates[0] = dialStore.totalRotates[0]
            }
    }
    private var rotationRight: some Gesture {
        DragGesture()
            .onChanged { value in
                dialStore.totalRotates[1].height = value.translation.height + dialStore.currentRotates[1].height
                
            }
            .onEnded { value in
                dialStore.currentRotates[1] = dialStore.totalRotates[1]
            }
    }
    private var rotationBtm: some Gesture {
        DragGesture()
            .onChanged { value in
                dialStore.totalRotates[2].width = value.translation.width + dialStore.currentRotates[2].width
                
            }
            .onEnded { value in
                dialStore.currentRotates[2] = dialStore.totalRotates[2]
            }
    }
}


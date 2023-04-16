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
    
    @State
    var totalRotates = [CGSize.zero, CGSize.zero, CGSize.zero] {
        didSet {
            if prevRotates[0].height + 32 < totalRotates[0].height {
                prevRotates[0] = totalRotates[0]
                krScalers[0] += 1
            }
            if prevRotates[0].height - 32 > totalRotates[0].height {
                prevRotates[0] = totalRotates[0]
                krScalers[0] -= 1
            }
            if prevRotates[1].height + 32 < totalRotates[1].height {
                prevRotates[1] = totalRotates[1]
                krScalers[1] += 1
            }
            if prevRotates[1].height - 32 > totalRotates[1].height {
                prevRotates[1] = totalRotates[1]
                krScalers[1] -= 1
            }
            if prevRotates[2].width + 32 < totalRotates[2].width {
                prevRotates[2] = totalRotates[2]
                krScalers[2] += 1
            }
            if prevRotates[2].width - 32 > totalRotates[2].width {
                prevRotates[2] = totalRotates[2]
                krScalers[2] -= 1
            }
        }
    }
    
    @State
    var prevRotates = [CGSize.zero, CGSize.zero, CGSize.zero] {
        didSet {
            AudioServicesPlaySystemSoundWithCompletion(1157, nil);
        }
    }
    
    @State
    var currentRotates = [CGSize.zero, CGSize.zero, CGSize.zero]
    
    @State
    var krScalers = [0, 0, 0] {
        didSet {
            if krScalers[0] < 0 {
                krScalers[0] = 18
            } else if krScalers[0] > 18 {
                krScalers[0] = 0
            }
            if krScalers[1] < 0 {
                krScalers[1] = 20
            } else if krScalers[1] > 20 {
                krScalers[1] = 0
            }
            if krScalers[2] < 0 {
                krScalers[2] = 27
            } else if krScalers[2] > 27 {
                krScalers[2] = 0
            }
            
            if let firstScaler = Unicode.Scalar(0x1100 + krScalers[0]),
               let secondaryScaler = Unicode.Scalar(0x1161 + krScalers[1]),
               let thirdScaler = Unicode.Scalar(0x11a6 + 1 + krScalers[2])
            {
                let char = krScalers[2] == 0
                ? String(firstScaler).appending(String(secondaryScaler))
                : String(firstScaler).appending(String(secondaryScaler)).appending(String(thirdScaler))

                globalStore.currentCharcter = char
            }
        }
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                CurrentScriptHeaderView
                Divider()
                    .frame(height: 2)
                    .background(CustomColor.gray04)
                GeometryReader { geometry in
                    ZStack {
                        // left
                        CharDialView
                            .rotationEffect(Angle(degrees: Double(totalRotates[0].height)))
                            .gesture(rotationLeft)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: totalRotates[0])
                            .position(x: -60, y: geometry.size.height / 2 - 24)
                            
                        // right
                        CharDialView
                            .rotationEffect(Angle(degrees: Double(-totalRotates[1].height)))
                            .gesture(rotationRight)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: totalRotates[1])
                            .position(x: geometry.size.width + 60, y: geometry.size.height / 2 - 24)
                        CharBoxView()
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - 24)
                        // btm
                        CharDialView
                            .rotationEffect(Angle(degrees: Double(totalRotates[2].width)))
                            .gesture(rotationBtm)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: totalRotates[2])
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2 + 360)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


// MARK: View
extension DialView {
    var CurrentScriptHeaderView: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Text(globalStore.correctWord)
                    .font(.custom("NanumMyeongjo-YetHangul", size: 64))
                    .foregroundColor(CustomColor.black)
                    .multilineTextAlignment(.center)
                Text(globalStore.correctYetWord)
                    .font(Font.custom("NanumMyeongjo-YetHangul", size: 64))
                    .foregroundColor(CustomColor.gray03)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxHeight: 100)
        .padding(.vertical, 16)
    }
    
    var CharDialView: some View {
        ZStack {
            ForEach(0..<360) { deg in
                let isMarkableTic = deg % 4 == 0
                if deg % 6 == 0 {
                    Rectangle()
                        .frame(width: isMarkableTic ? 380 : 385, height: isMarkableTic ? 2 : 4 )
                        .rotationEffect(Angle(degrees: Double(deg)))
                        .foregroundColor(isMarkableTic ? CustomColor.gray04 : CustomColor.black )
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
    var rotationLeft: some Gesture {
        DragGesture()
            .onChanged { value in
                totalRotates[0].height = value.translation.height + currentRotates[0].height
                
            }
            .onEnded { value in
                currentRotates[0] = totalRotates[0]
            }
    }
    var rotationRight: some Gesture {
        DragGesture()
            .onChanged { value in
                totalRotates[1].height = value.translation.height + currentRotates[1].height
                
            }
            .onEnded { value in
                currentRotates[1] = totalRotates[1]
            }
    }
    var rotationBtm: some Gesture {
        DragGesture()
            .onChanged { value in
                totalRotates[2].width = value.translation.width + currentRotates[2].width
                
            }
            .onEnded { value in
                currentRotates[2] = totalRotates[2]
            }
    }
}


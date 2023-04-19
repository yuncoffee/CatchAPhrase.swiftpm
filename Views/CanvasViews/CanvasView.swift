//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/14.
//

import SwiftUI

struct CanvasView: View {
    
    
    var currentIndex: Int
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @EnvironmentObject
    var globalStore: GlobalStore
    
    @EnvironmentObject
    var poemStore: PoemStore
    
    var body: some View {
        CanvasContainerView()
            .onAppear{
                globalStore.currentPoemIndex = currentIndex
                globalStore.currentFirstPhrases = poemStore.poems[currentIndex].firstPhrase.components(separatedBy: " ")
                globalStore.correctYetWord = globalStore.currentFirstPhrases[0]
            }
    }
}

// MARK: Views
extension CanvasView {
    private func CanvasContainerView() -> some View {
        GeometryReader { geomtery in
            if #available(iOS 16.0, *) {
                    if geomtery.size.width > 834 {
                        HStack(spacing: globalStore.isFinished ? 0 : 24) {
                            ScriptView()
                                .frame(minWidth: geomtery.size.width * 0.3,
                                       maxWidth: globalStore.isFinished ? .infinity : geomtery.size.width * 0.3,
                                       maxHeight: .infinity)
                                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0), value: globalStore.isFinished)
                                .background(CustomColor.gray01)
                                .cornerRadius(4)
                                .zIndex(1)
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
                        ZStack {
                            let iOS = globalStore.deviceOS == "iOS"
                            VStack {
                                if iOS {
                                    HStack(alignment: .top) {
                                        BackButtonView {
                                            presentationMode.wrappedValue.dismiss()
                                            globalStore.resetDialStatus()
                                            
                                        }
                                        Spacer()
                                        VStack {
                                            Image(systemName: "lock.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(CustomColor.black)
                                            Text("\(globalStore.correctedFirstPhrases.count) / \(globalStore.currentFirstPhrases.count)")
                                        }
                                        .frame(maxWidth: 40, maxHeight: 40)
                                        .opacity(globalStore.isFinished ? 0 : 1)
                                        Spacer()
                                        PlayInfoButtonView()
                                    }
                                    .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                                }
                                DialView()
                                    .frame(
                                        maxWidth: .infinity,
                                        maxHeight: globalStore.isFinished ? 0 : .infinity
                                    )
                                    .background(CustomColor.gray01)
                                    .cornerRadius(4)
                                ScriptView()
                                    .frame(maxWidth: .infinity,
                                           minHeight: iOS ? 0 : geomtery.size.width * 0.3,
                                           maxHeight: globalStore.isFinished ? .infinity : iOS ? 0 : geomtery.size.width * 0.3
                                           )
                                    .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0), value: globalStore.isFinished)
                                    .background(CustomColor.gray01)
                                    .cornerRadius(4)
                                    .zIndex(1)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(24)
                            .background(CustomColor.gray02)
                            .navigationTitle("Canvas")
                            .toolbar(.hidden, for: .navigationBar)
                        }
                    }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

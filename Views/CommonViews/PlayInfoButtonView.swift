//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/19.
//

import SwiftUI

struct PlayInfoButtonView: View {
    
    @State
    private var showPopover: Bool = false
    
    var body: some View {
        Button {
            self.showPopover = true
        } label: {
            Image(systemName: "questionmark.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(CustomColor.gray05)
        }
        .frame(width: 40, height: 40)
        .sheet(isPresented: self.$showPopover) {
            PlayDescriptionView
        }
    }
}

extension PlayInfoButtonView {
    private var PlayDescriptionView: some View {
        VStack {
            ScrollView {
                Text(
                    """
                    How to Play?

                    Please complete the first verse of the locked poem for each question.
                    
                    Each time you complete the first phrase, the unlock counter goes up.

                    1. At the top of the letter, there is a phrase that needs to be matched.
                    
                    
                    2. Drag the letter and send it to the phrase.
                    
                    
                    3. If the current letter matches the letter that needs to be matched, the letter color will change.
                    
                    
                    4. If the current letter does not match the letter you need to match, please change the letter.
                    
                    
                    5. You can change the letters by swiping the dials on the left, right, and bottom of the letters.

                    Good luck.
                    
                    Enjoy Catch a Phrase!
                    
                    
                    Caution! You can compare letters from the beginning.

                    """
                )
                .font(.custom("LibreBaskerville-Regular", size: 24))
                .foregroundColor(CustomColor.gray06)
                .multilineTextAlignment(.leading)
            }
        }
        .padding(24)
    }
}


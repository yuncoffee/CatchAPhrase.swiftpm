//
//  File.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/16.
//

import Foundation
import AVFoundation

class GlobalStore: ObservableObject {
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    
    @Published
    var isLinkPageActive = false
    
    @Published
    var currentCharcter = "가"
    
    @Published
    var correctWord = ""
    
    @Published
    var correctYetWord = "가나다" {
        didSet {
            if correctYetWord.count == 0 {
                isFinished = true
            }
        }
    }
    
    @Published
    var currentPoemIndex = 0
    
    
    @Published
    var currentIdx = 0
    
    @Published
    var isFinished = false
    
    func compareTitleWithWord() {

        let currentChar = correctYetWord.index(correctYetWord.startIndex, offsetBy: currentIdx)
        
        print(correctYetWord[currentChar])
        
        if correctYetWord.count > 0 && correctYetWord[currentChar] == currentCharcter[currentCharcter.startIndex] {
            print("맞았음")
            correctYetWord.remove(at: correctYetWord.startIndex)
            correctWord.append(currentCharcter)
            currentCharcter = "가"
            
        } else {
            print("틀려씀")
        }
    }
}

extension GlobalStore {
    func readContentToSiri(contents: String) {
        let speechUtterance = AVSpeechUtterance(string: contents)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        speechSynthesizer.speak(speechUtterance)
    }
}

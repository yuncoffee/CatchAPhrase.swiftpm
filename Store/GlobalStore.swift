//
//  File.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/16.
//

import Foundation
import AVFoundation
import UIKit

class GlobalStore: ObservableObject {
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    /**
     split 된 첫 줄을 맞춘 진행상황을 비교하기 위한 배열
     */
    var correctedFirstPhrases: [String] = [] {
        didSet {
            if correctedFirstPhrases.count == currentFirstPhrases.count {
                phrasesCount = 0
                isFinished = true
            }
        }
    }
    /**
     split 된 첫 줄의 위치를 찾기 위한 인덱스
     */
    private var phrasesCount = 0 {
        didSet {
            let maxCount = currentFirstPhrases.count
            if phrasesCount < maxCount {
                let quizString = currentFirstPhrases[phrasesCount]
                correctYetWord = quizString
            }
        }
    }
    /**
     device os info
     */
    @Published
    var deviceOS = UIDevice.current.systemName
    
    @Published
    var isLanguageKr = true
    
    /**
     다이얼에 사용되는 Charcter
     */
    @Published
    var currentCharcter = "가"
     /**
      split한 첫 줄을 담은 배열
      */
    @Published
    var currentFirstPhrases: [String] = []
    /**
     정답을 맞춘 텍스트
     */
    @Published
    var correctWord = ""
    
    /**
     정답을 맞춰야 하는 텍스트
     */
    @Published
    var correctYetWord = "가나다"
    /**
     선택된 시의 정보를 가져오기 위한 인덱스
     */
    @Published
    var currentPoemIndex = 0
    /**
     퀴즈를 맞춘 상태를 확인하기 위한 Bool
     */
    @Published
    var isFinished = false
    
    @Published
    var isSiriSpeaking = false
    
    @Published
    var isWrongAnswerSubmited: CGFloat = 1 {
        didSet {
            if isWrongAnswerSubmited == 0.9 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.isWrongAnswerSubmited = 1
                }
            }
        }
    }
}

extension GlobalStore {
    func compareTitleWithWord() {
        let currentChar = correctYetWord.index(correctYetWord.startIndex, offsetBy: 0)

        if correctYetWord.count > 0 && correctYetWord[currentChar] == currentCharcter[currentCharcter.startIndex] {
            correctYetWord.remove(at: correctYetWord.startIndex)
            correctWord.append(currentCharcter)
            currentCharcter = "가"
            
            if correctYetWord.count == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                    self.correctedFirstPhrases.append(self.currentFirstPhrases[self.phrasesCount])
                    self.correctWord = ""
                    self.phrasesCount += 1
                }
            }
        } else {
            isWrongAnswerSubmited = 0.9
        }
    }
    
    func readContentToSiri(contents: String, _ language: String?) {
        let speechUtterance = AVSpeechUtterance(string: contents)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: language ?? "ko-KR")
        speechSynthesizer.speak(speechUtterance)
        isSiriSpeaking = true
        
    }
    
    func stopReadContentToSiri() {
        speechSynthesizer.stopSpeaking(at: .immediate)
        isSiriSpeaking = false
    }
    
    func resetDialStatus() {
        phrasesCount = 0
        correctedFirstPhrases = []
        currentFirstPhrases = []
        correctYetWord = ""
        correctWord = ""
        isFinished = false
        stopReadContentToSiri()
    }
    
    func toggleLanguage() {
        isLanguageKr.toggle()
    }
    
    func isiOS () -> Bool {
        return deviceOS == "iOS"
    }
}

//
//  File.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/17.
//

import Foundation
import AVFoundation
import UIKit

class DialStore: ObservableObject {
    class HapticManager {
        static let instance = HapticManager()
        
        func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(type)
        }
        
        func impact(type: UIImpactFeedbackGenerator.FeedbackStyle) {
            let generator = UIImpactFeedbackGenerator(style: type)
            generator.impactOccurred()
        }
    }

    @Published
    var isShowAnimation = false{
        didSet {
            
            if isShowAnimation {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    self.isShowAnimation = false
                }
            }
        }
    }

    
    
    @Published
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
    
    @Published
    var prevRotates = [CGSize.zero, CGSize.zero, CGSize.zero] {
        didSet {
            HapticManager.instance.impact(type: .rigid)
            AudioServicesPlaySystemSoundWithCompletion(1157, nil);
        }
    }
    
    @Published
    var currentRotates = [CGSize.zero, CGSize.zero, CGSize.zero]
    
    @Published
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
        }
    }
}

extension DialStore {
    func updateCurrentCharcter(globalStore: GlobalStore) {
        if let firstScaler = Unicode.Scalar(0x1100 + krScalers[0]),
           let secondaryScaler = Unicode.Scalar(0x1161 + krScalers[1]),
           let thirdScaler = Unicode.Scalar(0x11a6 + 1 + krScalers[2])
        {
            let char = krScalers[2] == 0
            ? String(firstScaler).appending(String(secondaryScaler))
            : String(firstScaler).appending(String(secondaryScaler)).appending(String(thirdScaler))

            globalStore.currentCharcter = char
            
            if globalStore.currentCharcter.count > 0 && globalStore.correctYetWord.count > 0 &&   globalStore.currentCharcter[globalStore.currentCharcter.startIndex] == globalStore.correctYetWord[globalStore.correctYetWord.startIndex] {
                isShowAnimation = true
            } else {
                isShowAnimation = false
            }
        }
    }
}

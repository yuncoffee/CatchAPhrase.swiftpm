//
//  File.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/17.
//

import Foundation

struct PoemInfo: Identifiable {
    let id = UUID()
    // 제목 / 내용 / 저자
    var krInfo: (String, String, String)
    var enInfo: (String, String, String)
    var firstPhrase: String
    var thumbChar: String
}

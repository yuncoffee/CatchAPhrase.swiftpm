//
//  File.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/17.
//

import Foundation

struct PoemInfo: Identifiable {
    let id = UUID()
    var name: String
    var author: String
    var contents: String
    var firstPhrase: String
    var thumbChar: String
}

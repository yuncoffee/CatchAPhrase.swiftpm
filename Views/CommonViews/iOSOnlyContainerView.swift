//
//  SwiftUIView.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/19.
//

import SwiftUI

struct iOSOnlyContainerView: View {
    
    @ObservedObject
    var globalStore: GlobalStore
    
    var iOSOnlyView: AnyView
    
    var notOnlyiOSView: AnyView?
    
    var body: some View {
        if globalStore.checkIsiOS() {
            iOSOnlyView
        }else {
            notOnlyiOSView
        }
    }
}

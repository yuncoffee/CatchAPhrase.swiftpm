import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject
    var globalStore: GlobalStore
    
    @State
    var showDetail = false
    
    var body: some View {
        HomeContainerView(
            HomeTitleView,
            StartButtonView
        )
    }
}

// MARK: Views
extension ContentView {
    
    var StartButtonView: some View {
        NavigationLink(destination: MenuView(globalStore: globalStore), isActive: $showDetail) {
            Button(action: { self.showDetail = true }) {
                Text("Start")
                    .font(.custom("LibreBaskerville-Regular", size: 48))
                    .frame(width: 320, height: 80)
                    .border(CustomColor.gray03, width: 2)
                    .foregroundColor(CustomColor.gray06)
                    .cornerRadius(4)
            }
        }
    }
    
    var HomeTitleView: some View {
        ZStack {
            HStack(spacing: -4) {
                ForEach(0..<2) { _ in
                    BoxDecorationView()
                }
            }
            Text("Catch a phrase")
                .font(.custom("LibreBaskerville-Regular", size: 64))
        }
        .padding(.bottom, 100)
    }
    
    func HomeContainerView (_ homeTitleView: any View, _ startButtonView: any View) -> some View {
        GeometryReader { geometry in
            if #available(iOS 16.0, *)
            {
                VStack {
                    VStack {
                        AnyView(homeTitleView)
                        AnyView(startButtonView)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(CustomColor.gray01)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(24)
                .background(CustomColor.gray02)
            } else {
                
            }
        }
    }
}

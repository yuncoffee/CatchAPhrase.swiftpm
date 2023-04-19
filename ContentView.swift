import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject
    var globalStore: GlobalStore
    
    @State
    var showDetail = false
    
    @State
    private var showPopover: Bool = false

    
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
            if globalStore.deviceOS == "iOS" {
                BoxDecorationView()
            } else {
                HStack(spacing: -4) {
                    ForEach(0..<2) { _ in
                        BoxDecorationView()
                    }
                }
            }
            Text("Catch a phrase")
                .font(.custom("LibreBaskerville-Regular", size: 64))
                .multilineTextAlignment(.center)
                
        }
        .padding(.bottom, globalStore.deviceOS == "iOS" ? 32 : 100)
    }
    
    func HomeContainerView (_ homeTitleView: any View, _ startButtonView: any View) -> some View {
        GeometryReader { geometry in
            if #available(iOS 16.0, *)
            {
                VStack {
                    ZStack{
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
                            AppDescriptionView
                        }
                        .position(x: geometry.size.width - 40 - 40, y: 32)
                        .zIndex(1)
                        VStack {
                            AnyView(homeTitleView)
                            AnyView(startButtonView)
                        }
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


extension ContentView {
    private var AppDescriptionView: some View {
        VStack {
            ScrollView {
                Text(
                    """
                    Hello, I’m Coffee.
                    
                    I'd like to introduce interesting Korean and contents in Korean to you.
                    
                    There are various Korean contents, but among them,
                    I will introduce Korean poems where words and sentences can be interpreted in various ways.

                    Among the well-known poems in Korea, the first verse picked four especially famous poems.
                    
                    But wouldn't it be more fun to learn about Hangul together than just looking at it?

                    Make a morpheme by turning a dial that
                    can change the combination of 'Initial consonants', 'Medial vowels', and 'Final consonants', and complete the first phrase.
                    
                    Soon, you will be able to learn more about Hangul and Korean expressions.

                    The characteristics of Hangeul, which create a single 'morphism' through the combination of 'Initial consonants', 'Medial vowels', and 'Final consonants'
                    
                    I'd be very happy if I got interested.

                    Enjoy Catch a Phrase!
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

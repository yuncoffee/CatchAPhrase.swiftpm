import SwiftUI

struct ContentView: View {

    @EnvironmentObject
    var globalStore: GlobalStore
    
    @State var showDetail = false

    var body: some View {
        GeometryReader { geometry in
            
            if #available(iOS 16.0, *)
            {
                VStack {
                    VStack {
                        ZStack {
                            HStack(spacing: -4) {
                                ForEach(0..<2) { _ in
                                    BoxDecorationView()
                                }
                            }
                            //Title
                            Text("Catch a phrase")
                                .font(.custom("LibreBaskerville-Regular", size: 64))
                        }
                        .padding(.bottom, 100)
                        
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
                        .navigationBarTitle("Home")
                        .toolbar(.hidden, for: .navigationBar)

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ContentView()
            }
            .previewDevice("iPad Pro (11-inch) (4th generation)")
            .previewInterfaceOrientation(.landscapeLeft) // Landscape mode
        } else {
            // Fallback on earlier versions
        }
    }
}

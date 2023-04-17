import SwiftUI

@main
struct MyApp: App {
    
    let globalStore = GlobalStore()
    
    init() {
        CustomFont.registerFonts(fontName: "NanumMyeongjo-YetHangul")
        CustomFont.registerFonts(fontName: "LibreBaskerville-Regular")
        globalStore.deviceOS = UIDevice.current.systemName
    }
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    ContentView()
                        .environmentObject(globalStore)
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

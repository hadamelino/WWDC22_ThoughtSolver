import SwiftUI

@main
struct MyApp: App {
    @ObservedObject var state = AppState()
    @ObservedObject var thoughts = Thoughts()
    
    var body: some Scene {
        WindowGroup {
            if state.showMain {
                ContentView()
                    .environmentObject(state)
                    .environmentObject(thoughts)
            }
        }

    }
}

class AppState: ObservableObject {
    @Published var showMain = false
    @Published var showInstruction = false
    @Published var showSummary = false
    
    init(){
        self.showMain = true
    }
}

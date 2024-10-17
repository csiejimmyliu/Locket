import SwiftUI

@main
struct LocketApp: App {
    @StateObject private var photoManager = PhotoManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(photoManager)
        }
    }
}

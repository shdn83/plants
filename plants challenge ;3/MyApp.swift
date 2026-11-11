import SwiftUI

@main
struct PlantsApp: App {
    @StateObject private var viewModel = PlantsViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

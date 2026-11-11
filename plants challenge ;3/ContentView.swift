import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: PlantsViewModel

    var body: some View {
        if viewModel.hasSeenOnboarding {
            Text("My Plants")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.ignoresSafeArea())
        } else {
            OnboardingView(onStart: viewModel.completeOnboarding)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PlantsViewModel())
    }
}
#Preview {
    ContentView()
}

import SwiftUI

enum ActiveSheet: Identifiable {
    case add
    case edit(Plant)

    var id: String {
        switch self {
        case .add:
            return "add"
        case .edit(let plant):
            return plant.id.uuidString
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: PlantsViewModel
    @State private var activeSheet: ActiveSheet?

    var body: some View {
        Group {
            if viewModel.hasSeenOnboarding {
                MyPlantsView(
                    onAdd: {
                        activeSheet = .add
                    },
                    onEdit: { plant in
                        activeSheet = .edit(plant)
                    }
                )
            } else {
                OnboardingView(onStart: {
                    viewModel.completeOnboarding()
                    activeSheet = .add
                })
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .add:
                SetReminderView()
            case .edit(let plant):
                SetReminderView(plantToEdit: plant)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PlantsViewModel())
    }
}

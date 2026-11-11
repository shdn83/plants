import SwiftUI

struct MyPlantsView: View {
    @EnvironmentObject var viewModel: PlantsViewModel
    let onAdd: () -> Void
    let onEdit: (Plant) -> Void

    private let accent = Color(red: 0.20, green: 0.50, blue: 0.41)

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                header
                Divider()
                content
            }

            addButton
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
    }

    private var header: some View {
        HStack {
            Text("My Plants 🌱")
                .font(.title.bold())
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 12)
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.hasNoPlants {
            emptyState
        } else if viewModel.allWatered {
            allDoneState
        } else {
            plantsList
        }
    }

    private var emptyState: some View {
        VStack {
            Spacer()
            Text("No reminders set yet..")
                .font(.footnote)
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private var allDoneState: some View {
        VStack(spacing: 12) {
            Spacer()
            Image(systemName: "leaf.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
            Text("All Done! 🎉")
                .font(.headline)
            Text("All Reminders Completed")
                .font(.footnote)
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private var plantsList: some View {
        VStack(spacing: 12) {
            VStack(spacing: 8) {
                Text(viewModel.progressMessage)
                    .font(.footnote)

                ProgressView(value: viewModel.progress)
                    .tint(accent)
                    .animation(.easeInOut, value: viewModel.progress)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)

            List(viewModel.plants) { plant in
                PlantRowView(plant: plant, onToggle: {
                    viewModel.toggleWatered(plant)
                })
                .listRowBackground(Color.black)
                .contentShape(Rectangle())
                .onTapGesture {
                    onEdit(plant)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        viewModel.deletePlant(plant)
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }

    private var addButton: some View {
        Button(action: onAdd) {
            Image(systemName: "plus")
                .font(.title3.bold())
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(accent)
                .clipShape(Circle())
        }
        .padding(24)
    }
}

struct MyPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        MyPlantsView(onAdd: {}, onEdit: { _ in })
            .environmentObject(PlantsViewModel())
    }
}

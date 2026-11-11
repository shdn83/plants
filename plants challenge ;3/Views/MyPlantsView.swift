import SwiftUI

struct MyPlantsView: View {
    @EnvironmentObject var viewModel: PlantsViewModel
    let onAdd: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                HStack {
                    Text("My Plants 🌱")
                        .font(.title.bold())
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 12)

                Divider()

                if viewModel.hasNoPlants {
                    Spacer()
                    Text("No reminders set yet..")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                } else {
        
                    List(viewModel.plants) { plant in
                        Text(plant.name)
                            .listRowBackground(Color.black)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }

            Button(action: onAdd) {
                Image(systemName: "plus")
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .frame(width: 48, height: 48)
                    .background(Color(red: 0.20, green: 0.50, blue: 0.41))
                    .clipShape(Circle())
            }
            .padding(24)
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
    }
}

struct MyPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        MyPlantsView(onAdd: {})
            .environmentObject(PlantsViewModel())
    }
}

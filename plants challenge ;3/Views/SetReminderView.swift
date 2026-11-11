import SwiftUI

struct SetReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: PlantsViewModel

    @State private var name = ""
    @State private var room = "Bedroom"
    @State private var light = "Full sun"
    @State private var wateringDays = "Every day"
    @State private var waterAmount = "20-50 ml"

    private let rooms = [
        "Bedroom", "Living Room", "Kitchen",
        "Balcony", "Bathroom"
    ]

    private let lights = [
        "Full sun", "Partial sun", "Low light"
    ]

    private let days = [
        "Every day", "Every 2 days", "Every 3 days",
        "Once a week", "Every 2 weeks"
    ]

    private let amounts = [
        "20-50 ml", "50-100 ml",
        "100-200 ml", "200-300 ml"
    ]

    private let fieldColor = Color(white: 0.17)

    private var isNameEmpty: Bool {
        name.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        VStack(spacing: 0) {

            // Header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.footnote.bold())
                        .foregroundColor(.white)
                        .frame(width: 32, height: 32)
                        .background(Color.gray.opacity(0.4))
                        .clipShape(Circle())
                }

                Spacer()

                Text("Set Reminder")
                    .font(.subheadline.bold())

                Spacer()

                Button {
                    save()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.footnote.bold())
                        .foregroundColor(.white)
                        .frame(width: 32, height: 32)
                        .background(
                            Color(red: 0.20, green: 0.50, blue: 0.41)
                        )
                        .clipShape(Circle())
                }
                .disabled(isNameEmpty)
                .opacity(isNameEmpty ? 0.4 : 1)
            }
            .padding()

            // Form
            Form {
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Pothos", text: $name)
                    }
                    .listRowBackground(fieldColor)
                }

                Section {
                    Picker(selection: $room) {
                        ForEach(rooms, id: \.self) {
                            Text($0)
                        }
                    } label: {
                        Label("Room", systemImage: "location")
                    }
                    .listRowBackground(fieldColor)

                    Picker(selection: $light) {
                        ForEach(lights, id: \.self) {
                            Text($0)
                        }
                    } label: {
                        Label("Light", systemImage: "sun.max")
                    }
                    .listRowBackground(fieldColor)
                }

                Section {
                    Picker(selection: $wateringDays) {
                        ForEach(days, id: \.self) {
                            Text($0)
                        }
                    } label: {
                        Label("Watering Days", systemImage: "drop")
                    }
                    .listRowBackground(fieldColor)

                    Picker(selection: $waterAmount) {
                        ForEach(amounts, id: \.self) {
                            Text($0)
                        }
                    } label: {
                        Label("Water", systemImage: "drop")
                    }
                    .listRowBackground(fieldColor)
                }
            }
            .pickerStyle(.menu)
            .tint(.gray)
            .scrollContentBackground(.hidden)
        }
        .foregroundColor(.white)
        .background(
            Color(white: 0.11).ignoresSafeArea()
        )
        .preferredColorScheme(.dark)
    }

    // Save Reminder
    private func save() {
        viewModel.addPlant(
            name: name.trimmingCharacters(in: .whitespaces),
            room: room,
            light: light,
            wateringDays: wateringDays,
            waterAmount: waterAmount
        )

        dismiss()
    }
}

struct SetReminderView_Previews: PreviewProvider {
    static var previews: some View {
        SetReminderView()
            .environmentObject(PlantsViewModel())
    }
}

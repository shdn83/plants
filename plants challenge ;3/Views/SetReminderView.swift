import SwiftUI

struct SetReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: PlantsViewModel

    let plantToEdit: Plant?

    @State private var name: String
    @State private var room: String
    @State private var light: String
    @State private var wateringDays: String
    @State private var waterAmount: String

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

    init(plantToEdit: Plant? = nil) {
        self.plantToEdit = plantToEdit
        _name = State(initialValue: plantToEdit?.name ?? "")
        _room = State(initialValue: plantToEdit?.room ?? "Bedroom")
        _light = State(initialValue: plantToEdit?.light ?? "Full sun")
        _wateringDays = State(initialValue: plantToEdit?.wateringDays ?? "Every day")
        _waterAmount = State(initialValue: plantToEdit?.waterAmount ?? "20-50 ml")
    }

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

                if plantToEdit != nil {
                    Section {
                        Button(role: .destructive) {
                            delete()
                        } label: {
                            Text("Delete Reminder")
                                .frame(maxWidth: .infinity)
                        }
                        .listRowBackground(fieldColor)
                    }
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
        let cleanName = name.trimmingCharacters(in: .whitespaces)

        if let plant = plantToEdit {
            viewModel.updatePlant(
                plant,
                name: cleanName,
                room: room,
                light: light,
                wateringDays: wateringDays,
                waterAmount: waterAmount
            )
        } else {
            viewModel.addPlant(
                name: cleanName,
                room: room,
                light: light,
                wateringDays: wateringDays,
                waterAmount: waterAmount
            )
        }

        dismiss()
    }

    // Delete Reminder
    private func delete() {
        if let plant = plantToEdit {
            viewModel.deletePlant(plant)
        }
        dismiss()
    }
}

// Preview
struct SetReminderView_Previews: PreviewProvider {
    static var previews: some View {
        SetReminderView(
            plantToEdit: Plant(
                name: "Pothos",
                room: "Bedroom",
                light: "Full sun",
                wateringDays: "Every day",
                waterAmount: "20-50 ml"
            )
        )
        .environmentObject(PlantsViewModel())
    }
}

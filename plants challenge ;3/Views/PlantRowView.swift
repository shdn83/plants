import SwiftUI

struct PlantRowView: View {
    let plant: Plant
    let onToggle: () -> Void

    private let accent = Color(red: 0.20, green: 0.50, blue: 0.41)

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(plant.isWatered ? accent : .gray)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 6) {
                Text("in \(plant.room)")
                    .font(.caption2)
                    .foregroundColor(.gray)

                Text(plant.name)
                    .font(.title3)
                    .foregroundColor(plant.isWatered ? .gray : .white)

                HStack(spacing: 8) {
                    badge(icon: "sun.max", text: plant.light)
                    badge(icon: "drop", text: plant.waterAmount)
                }
            }

            Spacer()
        }
        .padding(.vertical, 6)
    }

    private func badge(icon: String, text: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(text)
        }
        .font(.caption2)
        .foregroundColor(.gray)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(white: 0.15))
        .clipShape(Capsule())
    }
}

struct PlantRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlantRowView(
            plant: Plant(name: "Monstera", room: "Kitchen", light: "Full sun", wateringDays: "Every day", waterAmount: "20-50 ml"),
            onToggle: {}
        )
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

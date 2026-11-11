import SwiftUI
import Combine

class PlantsViewModel: ObservableObject {

    @Published var plants: [Plant] = []

    @Published var hasSeenOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasSeenOnboarding") {
        didSet {
            UserDefaults.standard.set(hasSeenOnboarding, forKey: "hasSeenOnboarding")
        }
    }

    func completeOnboarding() {
        hasSeenOnboarding = true
    }

    // MARK: - Add / Edit / Delete

    func addPlant(name: String, room: String, light: String, wateringDays: String, waterAmount: String) {
        let plant = Plant(name: name, room: room, light: light, wateringDays: wateringDays, waterAmount: waterAmount)
        plants.append(plant)
    }

    func updatePlant(_ plant: Plant, name: String, room: String, light: String, wateringDays: String, waterAmount: String) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].name = name
            plants[index].room = room
            plants[index].light = light
            plants[index].wateringDays = wateringDays
            plants[index].waterAmount = waterAmount
        }
    }

    func deletePlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
    }

    // MARK: - Today

    var hasNoPlants: Bool {
        plants.isEmpty
    }

    func toggleWatered(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWatered.toggle()
        }
    }

    var wateredCount: Int {
        plants.filter { $0.isWatered }.count
    }

    var progress: Double {
        plants.isEmpty ? 0 : Double(wateredCount) / Double(plants.count)
    }

    var allWatered: Bool {
        !plants.isEmpty && wateredCount == plants.count
    }

    var progressMessage: String {
        if wateredCount == 0 {
            return "Your plants are waiting for a sip 💦"
        }
        return "\(wateredCount) of your plants feel loved today ✨"
    }
}

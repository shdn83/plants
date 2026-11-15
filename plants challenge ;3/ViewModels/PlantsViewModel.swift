import SwiftUI
import Combine

class PlantsViewModel: ObservableObject {

    @Published var plants: [Plant] = [] {
        didSet {
            savePlants()
        }
    }

    @Published var hasSeenOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasSeenOnboarding") {
        didSet {
            UserDefaults.standard.set(hasSeenOnboarding, forKey: "hasSeenOnboarding")
        }
    }

    private let plantsKey = "savedPlants"

    init() {
        loadPlants()
    }

    func completeOnboarding() {
        hasSeenOnboarding = true
    }

    // MARK: - Save / Load

    private func savePlants() {
        if let data = try? JSONEncoder().encode(plants) {
            UserDefaults.standard.set(data, forKey: plantsKey)
        }
    }

    private func loadPlants() {
        guard let data = UserDefaults.standard.data(forKey: plantsKey),
              let saved = try? JSONDecoder().decode([Plant].self, from: data) else {
            return
        }
        plants = saved
    }

    // MARK: - Add / Edit / Delete

    func addPlant(name: String, room: String, light: String, wateringDays: String, waterAmount: String) {
        let plant = Plant(name: name, room: room, light: light, wateringDays: wateringDays, waterAmount: waterAmount)
        plants.append(plant)

        NotificationManager.shared.requestPermission()
        NotificationManager.shared.schedule(for: plant)
    }

    func updatePlant(_ plant: Plant, name: String, room: String, light: String, wateringDays: String, waterAmount: String) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].name = name
            plants[index].room = room
            plants[index].light = light
            plants[index].wateringDays = wateringDays
            plants[index].waterAmount = waterAmount

            NotificationManager.shared.cancel(for: plant)
            NotificationManager.shared.schedule(for: plants[index])
        }
    }

    func deletePlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
        NotificationManager.shared.cancel(for: plant)
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

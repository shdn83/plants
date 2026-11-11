import Foundation

struct Plant: Identifiable, Codable {
    var id = UUID()
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    var isWatered: Bool = false
}

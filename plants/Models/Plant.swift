import Foundation

// Plant Model

struct Plant: Identifiable, Codable {
    var id = UUID()
    var name: String = ""
    var room: Room = .bedroom
    var light: Light = .fullSun
    var watering: WateringFrequency = .everyDay
    var waterAmount: WaterAmount = .ml20to50
}


//  Enums

enum Room: String, CaseIterable, Identifiable, Codable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    var id: String { rawValue }
}

enum Light: String, CaseIterable, Identifiable, Codable {
    case fullSun = "Full Sun"
    case partialShade = "Partial Shade"
    case lowLight = "Low Light"
    var id: String { rawValue }
}

enum WateringFrequency: String, CaseIterable, Identifiable, Codable {
    case everyDay = "Every day"
    case every2Days = "Every 2 days"
    case everyWeek = "Every week"
    var id: String { rawValue }
}

enum WaterAmount: String, CaseIterable, Identifiable, Codable {
    case ml20to50 = "20-50 ml"
    case ml50to100 = "50-100 ml"
    case ml100to200 = "100-200 ml"
    case ml200to300 = "200-300 ml"
    var id: String { rawValue }
}

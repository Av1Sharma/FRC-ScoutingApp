import Foundation

struct Event: Decodable {
    let name: String
    let locationName: String
    let city: String
    let stateProv: String
    let startDate: String
    let endDate: String
    let divisionKeys: [String]?

    enum CodingKeys: String, CodingKey {
        case name
        case locationName = "location_name"
        case city
        case stateProv = "state_prov"
        case startDate = "start_date"
        case endDate = "end_date"
        case divisionKeys = "division_keys"
    }
}

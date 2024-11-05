import Foundation

struct Match: Decodable {
    let matchNumber: String
    let teamKeys: [String]?

    enum CodingKeys: String, CodingKey {
        case matchNumber = "match_number"
        case teamKeys = "team_keys"
    }

    // Custom initializer to convert match_number to String if it's an Int
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let matchNumberInt = try? container.decode(Int.self, forKey: .matchNumber) {
            matchNumber = String(matchNumberInt)
        } else {
            matchNumber = try container.decode(String.self, forKey: .matchNumber)
        }
        
        teamKeys = try? container.decode([String].self, forKey: .teamKeys) // Make this optional
    }
}

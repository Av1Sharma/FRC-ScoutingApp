import Foundation
struct Match: Identifiable, Codable {
    let id = UUID() // Unique identifier for SwiftUI List
    let matchNumber: Int
    let compLevel: String
    let blueTeams: [String]
    let redTeams: [String]

    enum CodingKeys: String, CodingKey {
        case matchNumber = "match_number"
        case compLevel = "comp_level"
        case alliances
    }

    enum AllianceKeys: String, CodingKey {
        case blue, red
    }

    enum TeamKeys: String, CodingKey {
        case teamKeys = "team_keys"
    }

    // Custom decoder to extract the team keys
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        matchNumber = try container.decode(Int.self, forKey: .matchNumber)
        compLevel = try container.decode(String.self, forKey: .compLevel)

        let alliancesContainer = try container.nestedContainer(keyedBy: AllianceKeys.self, forKey: .alliances)
        let blueAlliance = try alliancesContainer.nestedContainer(keyedBy: TeamKeys.self, forKey: .blue)
        blueTeams = try blueAlliance.decode([String].self, forKey: .teamKeys)

        let redAlliance = try alliancesContainer.nestedContainer(keyedBy: TeamKeys.self, forKey: .red)
        redTeams = try redAlliance.decode([String].self, forKey: .teamKeys)
    }

    // Add this to ensure it conforms to Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(matchNumber, forKey: .matchNumber)
        try container.encode(compLevel, forKey: .compLevel)

        var alliancesContainer = container.nestedContainer(keyedBy: AllianceKeys.self, forKey: .alliances)
        
        // Encode blue alliance
        var blueAllianceContainer = alliancesContainer.nestedContainer(keyedBy: TeamKeys.self, forKey: .blue)
        try blueAllianceContainer.encode(blueTeams, forKey: .teamKeys)
        
        // Encode red alliance
        var redAllianceContainer = alliancesContainer.nestedContainer(keyedBy: TeamKeys.self, forKey: .red)
        try redAllianceContainer.encode(redTeams, forKey: .teamKeys)
    }
}


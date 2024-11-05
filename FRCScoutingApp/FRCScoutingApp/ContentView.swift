import SwiftUI

struct ContentView: View {
    @State private var piecesScored: String = ""
    @State private var feedback: String = ""
    @State private var matches: [Match] = []
    @State private var eventKey: String = "2024vaale" // Specify your event key here

    var body: some View {
        VStack(spacing: 20) {
            Text("FRC Scouting App")
                .font(.largeTitle)
                .fontWeight(.bold)

            Button(action: {
                fetchMatches(for: eventKey) // Call fetchMatches with the specified event key
            }) {
                Text("Load Matches")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            // List of matches
            if matches.isEmpty {
                Text("No qualification matches found.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                List(matches) { match in
                    VStack(alignment: .leading) {
                        Text("Match \(match.matchNumber):")
                            .fontWeight(.bold)

                        HStack {
                            ForEach(match.blueTeams, id: \.self) { team in
                                Text(team)
                                    .foregroundColor(.blue) // Set font color to blue for blue alliance
                            }
                        }
                        HStack {
                            ForEach(match.redTeams, id: \.self) { team in
                                Text(team)
                                    .foregroundColor(.red) // Set font color to red for red alliance
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }

    // Updated fetchMatches function to use event key
    func fetchMatches(for eventKey: String) {
        let apiService = APIService()
        print("Fetching matches for event key: \(eventKey)") // Debug print
        apiService.fetchMatches(for: eventKey) { rawMatches in
            DispatchQueue.main.async {
                print("Raw matches fetched: \(rawMatches)") // Debug print
                
                // Filter matches to include only qualification matches (comp_level == "qm")
                self.matches = rawMatches.filter { $0.compLevel == "qm" }
                
                // Sort matches by match number
                self.matches.sort { $0.matchNumber < $1.matchNumber }
                
                // Debug print to check filtered and sorted matches
                print("Filtered and sorted matches (QM): \(self.matches)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

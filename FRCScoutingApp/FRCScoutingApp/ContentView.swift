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
                Text("No matches found.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                List(matches, id: \.matchNumber) { match in
                    HStack {
                        Text("Match \(match.matchNumber): ")
                            .fontWeight(.bold)
                        if let teamKeys = match.teamKeys, !teamKeys.isEmpty {
                            Text(teamKeys.joined(separator: ", "))
                        } else {
                            Text("No teams available")
                                .foregroundColor(.red)
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
        apiService.fetchMatches(for: eventKey) { matches in
            DispatchQueue.main.async {
                print("Matches fetched: \(matches)") // Debug print
                self.matches = matches
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

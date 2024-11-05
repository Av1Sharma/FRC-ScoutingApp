import SwiftUI

struct ContentView: View {
    @State private var matches: [Match] = []
    @State private var eventKey: String = "2024vaale" // Specify your event key here

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("FRC Scouting App")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Button(action: {
                    fetchMatches(for: eventKey)
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
                                    NavigationLink(destination: ScoutingFormView(teamNumber: team)) {
                                        Text(team)
                                            .foregroundColor(.blue)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.blue.opacity(0.1))
                                            .cornerRadius(5)
                                    }
                                }
                            }

                            HStack {
                                ForEach(match.redTeams, id: \.self) { team in
                                    NavigationLink(destination: ScoutingFormView(teamNumber: team)) {
                                        Text(team)
                                            .foregroundColor(.red)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.red.opacity(0.1))
                                            .cornerRadius(5)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }

    func fetchMatches(for eventKey: String) {
        let apiService = APIService()
        print("Fetching matches for event key: \(eventKey)")
        apiService.fetchMatches(for: eventKey) { rawMatches in
            DispatchQueue.main.async {
                print("Raw matches fetched: \(rawMatches)")
                
                // Filter matches to include only qualification matches (comp_level == "qm")
                self.matches = rawMatches.filter { $0.compLevel == "qm" }
                
                // Sort matches by match number
                self.matches.sort { $0.matchNumber < $1.matchNumber }
                
                print("Filtered and sorted matches (QM): \(self.matches)")
            }
        }
    }
}


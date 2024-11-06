import SwiftUI

struct ContentView: View {
    @State private var matches: [Match] = []
    @State private var eventKey: String = "" // Start with an empty string for the event key

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("FRC Scouting App")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // TextField to input the event key
                TextField("Enter Event Key", text: $eventKey)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default) // Ensure the keyboard type is set correctly for input

                Button(action: {
                    if !eventKey.isEmpty {
                        fetchMatches(for: eventKey) // Load matches for the event key
                    }
                }) {
                    Text("Load Matches")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                if matches.isEmpty {
                    Text("No qualification matches found.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    List(matches) { match in
                        NavigationLink(destination: MatchDetailView(match: match)) {
                            Text("Match \(match.matchNumber)")
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Matches")
        }
    }

    // Fetch function to get matches from the API
    func fetchMatches(for eventKey: String) {
        let apiService = APIService()
        apiService.fetchMatches(for: eventKey) { rawMatches in
            DispatchQueue.main.async {
                self.matches = rawMatches.filter { $0.compLevel == "qm" }
                self.matches.sort { $0.matchNumber < $1.matchNumber }
                // Hide the keyboard after fetching matches
                UIApplication.shared.endEditing(true)
            }
        }
    }
}

// Extension to dismiss the keyboard
extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows.first?.endEditing(force)
    }
}

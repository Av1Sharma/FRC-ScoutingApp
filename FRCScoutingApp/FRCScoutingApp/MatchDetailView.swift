import SwiftUI

struct MatchDetailView: View {
    let match: Match  // Pass the selected match to this view
    @State private var selectedTeam: Team? = nil
    @State private var isScoutingFormPresented = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Match \(match.matchNumber)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Teams")
                .font(.headline)

            // Display teams in the match, clickable to open the scouting form
            ForEach(match.blueTeams, id: \.self) { team in
                Button(action: {
                    selectedTeam = Team(name: team)
                    isScoutingFormPresented = true
                }) {
                    Text(team)
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
            }

            ForEach(match.redTeams, id: \.self) { team in
                Button(action: {
                    selectedTeam = Team(name: team)
                    isScoutingFormPresented = true
                }) {
                    Text(team)
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .onAppear {
            // Reset selectedTeam to ensure the sheet can be presented on each new appearance
            selectedTeam = nil
        }
        .sheet(item: $selectedTeam) { team in
            ScoutingFormView(teamNumber: team.name)
        }
    }
}

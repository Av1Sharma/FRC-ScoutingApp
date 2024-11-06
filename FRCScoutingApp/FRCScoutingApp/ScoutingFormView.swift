import SwiftUI

struct ScoutingFormView: View {
    var teamNumber: String
    @Environment(\.presentationMode) var presentationMode
    @State private var piecesScored: String = ""
    @State private var feedback: String = ""
    
    // New states
    @State private var playedAuton: Bool = false
    @State private var ampScore: Int = 0
    @State private var speakerScore: Int = 0
    @State private var autonRating: Int = 0
    @State private var leftAutonArea: Bool = false // New state to track if the team left the auton area
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Scouting Data for Team \(teamNumber)")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Ask if they played Auton
            Toggle("Played Auton?", isOn: $playedAuton)
                .padding()

            // Show Auton scoring options if they played Auton
            if playedAuton {
                VStack(spacing: 20) {
                    // Amp Scoring
                    VStack {
                        Text("Amp Scoring")
                            .font(.headline)
                        HStack {
                            Button(action: {
                                if ampScore > 0 {
                                    ampScore -= 1
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            
                            Image(systemName: "cube.fill") // This is a placeholder icon for the piece
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                            Button(action: {
                                ampScore += 1
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        Text("Score: \(ampScore)")
                            .font(.subheadline)
                    }
                    
                    // Speaker Scoring
                    VStack {
                        Text("Speaker Scoring")
                            .font(.headline)
                        HStack {
                            Button(action: {
                                if speakerScore > 0 {
                                    speakerScore -= 1
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            
                            Image(systemName: "speaker.fill") // Placeholder for speaker piece
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                            Button(action: {
                                speakerScore += 1
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        Text("Score: \(speakerScore)")
                            .font(.subheadline)
                    }

                    // Auton Rating (1-5 stars)
                    VStack {
                        Text("Auton Rating")
                            .font(.headline)
                        HStack {
                            ForEach(1..<6) { star in
                                Button(action: {
                                    self.autonRating = star
                                }) {
                                    Image(systemName: self.autonRating >= star ? "star.fill" : "star")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                }
                            }
                        }
                    }

                    // Ask if the team left the Auton area
                    Toggle("Left Auton Area?", isOn: $leftAutonArea)
                        .padding()
                }
                
                // Feedback TextField
                TextField("Feedback", text: $feedback)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }

            // Save button
            Button(action: {
                saveScoutingData()
            }) {
                Text("Save Scouting Data")
                    .font(.headline)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)

            Spacer()
        }
        .padding()
    }

    private func saveScoutingData() {
        print("Scouting data saved for team \(teamNumber):")
        print("Pieces Scored: \(piecesScored), Feedback: \(feedback)")
        print("Auton Played: \(playedAuton), Amp Score: \(ampScore), Speaker Score: \(speakerScore), Auton Rating: \(autonRating) stars")
        print("Left Auton Area: \(leftAutonArea ? "Yes" : "No")")
        presentationMode.wrappedValue.dismiss()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScoutingFormView(teamNumber: "1885")
    }
}

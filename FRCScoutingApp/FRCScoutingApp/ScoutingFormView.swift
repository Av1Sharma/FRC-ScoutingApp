import SwiftUI

struct ScoutingFormView: View {
    var teamNumber: String
    @Environment(\.presentationMode) var presentationMode
    @State private var piecesScored: String = ""
    @State private var feedback: String = ""

    // Auton and Teleop states
    @State private var playedAuton: Bool = false
    @State private var ampScore: Int = 0
    @State private var speakerScore: Int = 0
    @State private var autonRating: Int = 0
    @State private var leaveEarly: Bool = false  // New "Leave" field for auton
    
    // Teleop states
    @State private var playedTeleop: String = "Didn't Move" // Default to "Didn't Move"
    @State private var speakerNotes: Int = 0
    @State private var autonNotes: Int = 0
    @State private var cooperated: Bool = false
    @State private var trapNote: Bool = false
    @State private var defenseObservations: String = ""
    @State private var teleopRating: Int = 0

    // Endgame states
    @State private var melodyBonus: Bool = false
    @State private var ensembleBonus: Bool = false
    @State private var endPosition: String = "Onstage" // Default to "Onstage"
    
    // Strengths and Weaknesses states
    @State private var selectedStrengths: Set<String> = [] // To hold selected strengths
    @State private var otherStrength: String = "" // To store "Other" input
    @State private var selectedWeaknesses: Set<String> = [] // To hold selected weaknesses
    @State private var otherWeakness: String = "" // To store "Other" weakness

    var body: some View {
        VStack(spacing: 20) {
            Text("Scouting \(teamNumber)")
                .font(.largeTitle)
                .fontWeight(.bold)

            // ScrollView to allow scrolling if content becomes too long
            ScrollView {
                VStack(spacing: 20) {
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

                                    Image(systemName: "cube.fill") // Placeholder for the piece
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

                            // "Leave Early" Field
                            Toggle("Leave Early?", isOn: $leaveEarly)
                                .padding()
                        }
                    }

                    // Teleop options
                    VStack(spacing: 20) {
                        Text("Teleop Data")
                            .font(.headline)

                        Picker("Teleop Role", selection: $playedTeleop) {
                            Text("Didn't Move").tag("Didn't Move")
                            Text("Played Offense").tag("Offense")
                            Text("Played Defense").tag("Defense")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()

                        // If played offense
                        if playedTeleop == "Offense" {
                            VStack(spacing: 20) {
                                // Speaker Notes
                                VStack {
                                    Text("Speaker Notes")
                                        .font(.headline)
                                    HStack {
                                        Button(action: {
                                            if speakerNotes > 0 {
                                                speakerNotes -= 1
                                            }
                                        }) {
                                            Image(systemName: "minus.circle.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                        }

                                        Image(systemName: "speaker.fill")
                                            .resizable()
                                            .frame(width: 40, height: 40)

                                        Button(action: {
                                            speakerNotes += 1
                                        }) {
                                            Image(systemName: "plus.circle.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                        }
                                    }
                                    Text("Speaker Notes: \(speakerNotes)")
                                        .font(.subheadline)
                                }

                                // Auton Notes
                                VStack {
                                    Text("Auton Notes")
                                        .font(.headline)
                                    HStack {
                                        Button(action: {
                                            if autonNotes > 0 {
                                                autonNotes -= 1
                                            }
                                        }) {
                                            Image(systemName: "minus.circle.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                        }

                                        Image(systemName: "cube.fill")
                                            .resizable()
                                            .frame(width: 40, height: 40)

                                        Button(action: {
                                            autonNotes += 1
                                        }) {
                                            Image(systemName: "plus.circle.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                        }
                                    }
                                    Text("Auton Notes: \(autonNotes)")
                                        .font(.subheadline)
                                }

                                // Cooperation
                                Toggle("Cooperated?", isOn: $cooperated)
                                    .padding()

                                // Trap Note
                                Toggle("Trap Note?", isOn: $trapNote)
                                    .padding()

                                // Offense Rating (1-5 stars)
                                VStack {
                                    Text("Offense Rating")
                                        .font(.headline)
                                    HStack {
                                        ForEach(1..<6) { star in
                                            Button(action: {
                                                self.teleopRating = star
                                            }) {
                                                Image(systemName: self.teleopRating >= star ? "star.fill" : "star")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        // If played defense
                        if playedTeleop == "Defense" {
                            VStack(spacing: 20) {
                                // Defense Observations
                                TextField("Defense Observations", text: $defenseObservations)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()

                                // Defense Rating (1-5 stars)
                                VStack {
                                    Text("Defense Rating")
                                        .font(.headline)
                                    HStack {
                                        ForEach(1..<6) { star in
                                            Button(action: {
                                                self.teleopRating = star
                                            }) {
                                                Image(systemName: self.teleopRating >= star ? "star.fill" : "star")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Endgame data
                    VStack(spacing: 20) {
                        Text("Endgame Data")
                            .font(.headline)
                        
                        Toggle("Melody Bonus?", isOn: $melodyBonus)
                            .padding()
                        
                        Toggle("Ensemble Bonus?", isOn: $ensembleBonus)
                            .padding()
                        
                        Picker("End Position", selection: $endPosition) {
                            Text("Onstage").tag("Onstage")
                            Text("None").tag("None")
                            Text("Onstage Spotlit").tag("Onstage Spotlit")
                            Text("Stage Park").tag("Stage Park")
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                    }

                    // Strengths
                    VStack(spacing: 20) {
                        Text("Strengths")
                            .font(.headline)
                        
                        ForEach(["Fast Robot", "Good Auton", "Good Defense", "Good Driving", "Good Intake", "Good Passing", "High Accuracy", "Good Amp"], id: \.self) { strength in
                            Toggle(strength, isOn: Binding(
                                get: { selectedStrengths.contains(strength) },
                                set: { isSelected in
                                    if isSelected {
                                        selectedStrengths.insert(strength)
                                    } else {
                                        selectedStrengths.remove(strength)
                                    }
                                }
                            ))
                            .padding()
                        }
                        
                        if selectedStrengths.contains("Other") {
                            TextField("Describe Other Strength", text: $otherStrength)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                        }
                    }

                    // Weaknesses
                    VStack(spacing: 20) {
                        Text("Weaknesses")
                            .font(.headline)

                        ForEach(["Slow Robot", "Poor Auton", "Weak Defense", "Poor Driving", "Poor Intake", "Poor Passing", "Low Accuracy", "Poor Amp"], id: \.self) { weakness in
                            Toggle(weakness, isOn: Binding(
                                get: { selectedWeaknesses.contains(weakness) },
                                set: { isSelected in
                                    if isSelected {
                                        selectedWeaknesses.insert(weakness)
                                    } else {
                                        selectedWeaknesses.remove(weakness)
                                    }
                                }
                            ))
                            .padding()
                        }

                        if selectedWeaknesses.contains("Other") {
                            TextField("Describe Other Weakness", text: $otherWeakness)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                        }
                    }

                    // Feedback section
                    VStack(spacing: 20) {
                        Text("Feedback")
                            .font(.headline)

                        TextField("Enter Feedback", text: $feedback)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }

                    // Save button
                    Button(action: {
                        saveScoutingData()
                        presentationMode.wrappedValue.dismiss() // Close the page
                    }) {
                        Text("Save Scouting Data")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
    }

    func saveScoutingData() {
        // Example: Save or print the data
        print("Auton Scoring: \(ampScore), \(speakerScore), Rating: \(autonRating) stars, Leave Early: \(leaveEarly)")
        print("Teleop: Played \(playedTeleop), Speaker Notes: \(speakerNotes), Auton Notes: \(autonNotes), Cooperated: \(cooperated), Trap Note: \(trapNote), Rating: \(teleopRating) stars")
        print("Defense Observations: \(defenseObservations), Defense Rating: \(teleopRating) stars")
        print("Endgame: Melody Bonus: \(melodyBonus), Ensemble Bonus: \(ensembleBonus), End Position: \(endPosition)")
        print("Strengths: \(selectedStrengths), Other Strength: \(otherStrength)")
        print("Weaknesses: \(selectedWeaknesses), Other Weakness: \(otherWeakness)")
        print("Feedback: \(feedback)")
    }
}

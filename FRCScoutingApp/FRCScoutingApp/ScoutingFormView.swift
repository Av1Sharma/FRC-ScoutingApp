//
//  ScoutingFormView.swift
//  FRCScoutingApp
//
//  Created by Avi Sharma on 11/5/24.
//


import SwiftUI

struct ScoutingFormView: View {
    var teamNumber: String
    @Environment(\.presentationMode) var presentationMode
    @State private var piecesScored: String = ""
    @State private var feedback: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Scouting Data for Team \(teamNumber)")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Pieces Scored", text: $piecesScored)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Feedback", text: $feedback)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

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
        print("Scouting data saved for team \(teamNumber): \(piecesScored), Feedback: \(feedback)")
        presentationMode.wrappedValue.dismiss()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

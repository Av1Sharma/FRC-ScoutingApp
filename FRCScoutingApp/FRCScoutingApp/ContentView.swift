import SwiftUI

struct ContentView: View {
    @State private var piecesScored: String = ""
    @State private var feedback: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("FRC Scouting App")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Enter pieces scored", text: $piecesScored)
                .padding()
                .border(Color.gray, width: 1)
                .keyboardType(.numberPad)

            Button(action: {
                feedback = "You scored \(piecesScored) pieces."
                piecesScored = "" // Clear the text field after submission
            }) {
                Text("Submit")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Text(feedback)
                .font(.subheadline)
                .foregroundColor(.green)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

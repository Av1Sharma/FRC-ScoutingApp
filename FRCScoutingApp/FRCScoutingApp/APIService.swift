import Foundation
class APIService {
    func fetchMatches(for eventKey: String, completion: @escaping ([Match]) -> Void) {
        let urlString = "https://www.thebluealliance.com/api/v3/event/\(eventKey)/matches"
        var request = URLRequest(url: URL(string: urlString)!)
        request.addValue("KeD7jWq5jnKiOoDvQAHOHUfxlp0AHQF7oJfvyhmDhnppdEaurxpBGbxsF1XBcN5E", forHTTPHeaderField: "X-TBA-Auth-Key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching matches: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Log the raw JSON response for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }

            do {
                let matches = try JSONDecoder().decode([Match].self, from: data)
                print("Fetched matches: \(matches)")
                completion(matches)
            } catch {
                print("Error decoding matches: \(error)")
            }
        }.resume()
    }
}

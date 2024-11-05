import Foundation

struct Match: Decodable {
    let matchNumber: String
    let teamKeys: [String]
}

class APIService {
    func fetchMatches(completion: @escaping ([Match]) -> Void) {
        let urlString = "https://www.thebluealliance.com/api/v3/matches" // Replace with the actual endpoint
        var request = URLRequest(url: URL(string: urlString)!)
        request.addValue("KeD7jWq5jnKiOoDvQAHOHUfxlp0AHQF7oJfvyhmDhnppdEaurxpBGbxsF1XBcN5E", forHTTPHeaderField: "X-TBA-Auth-Key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let matches = try JSONDecoder().decode([Match].self, from: data)
                completion(matches)
            } catch {
                print("Error decoding: \(error)")
            }
        }.resume()
    }
}

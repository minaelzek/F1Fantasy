import Foundation

class RaceDataService {
    static let shared = RaceDataService()
    
    private init() {}
    
    func fetchRaceData(completion: @escaping (Result<RaceData, Error>) -> Void) {
        let url = URL(string: "https://api.example.com/raceData")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let raceData = try JSONDecoder().decode(RaceData.self, from: data)
                completion(.success(raceData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

struct RaceData: Decodable {
    let raceName: String
    let circuit: String
    let date: String
    let results: [RaceResult]
}

struct RaceResult: Decodable {
    let position: Int
    let driver: String
    let team: String
    let time: String
}

import Foundation

class LeagueService {
    static let shared = LeagueService()
    
    private init() {}
    
    func createLeague(name: String, completion: @escaping (Result<League, Error>) -> Void) {
        // Simulate a network request to create a league
        let league = League(id: UUID().uuidString, name: name, members: [])
        completion(.success(league))
    }
    
    func joinLeague(leagueId: String, userId: String, completion: @escaping (Result<League, Error>) -> Void) {
        // Simulate a network request to join a league
        var league = League(id: leagueId, name: "Sample League", members: [])
        league.members.append(userId)
        completion(.success(league))
    }
    
    func fetchLeagues(userId: String, completion: @escaping (Result<[League], Error>) -> Void) {
        // Simulate a network request to fetch leagues
        let leagues = [
            League(id: UUID().uuidString, name: "League 1", members: [userId]),
            League(id: UUID().uuidString, name: "League 2", members: [userId])
        ]
        completion(.success(leagues))
    }
}

struct League: Identifiable {
    let id: String
    let name: String
    var members: [String]
}

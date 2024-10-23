import Foundation

class LeagueService {
    private var leagues: [League] = []
    
    func createLeague(name: String, owner: User) -> League {
        let newLeague = League(name: name, owner: owner)
        leagues.append(newLeague)
        return newLeague
    }
    
    func joinLeague(league: League, user: User) {
        if !league.members.contains(user) {
            league.members.append(user)
        }
    }
    
    func inviteUserToLeague(league: League, user: User) {
        // Placeholder for invite functionality
        // This could involve sending an email or notification to the user
    }
    
    func getLeaguesForUser(user: User) -> [League] {
        return leagues.filter { $0.members.contains(user) }
    }
}

struct League {
    let id = UUID()
    let name: String
    let owner: User
    var members: [User] = []
}

struct User: Equatable {
    let id = UUID()
    let displayName: String
}

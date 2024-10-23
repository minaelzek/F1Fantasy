import Foundation

class LeagueViewModel: ObservableObject {
    @Published var leagues: [League] = []
    @Published var selectedLeague: League?
    @Published var showCreateLeague: Bool = false
    @Published var showInviteUser: Bool = false
    @Published var inviteEmail: String = ""
    @Published var leagueName: String = ""

    private let leagueService = LeagueService()

    func loadLeagues(for user: User) {
        leagues = leagueService.getLeaguesForUser(user: user)
    }

    func createLeague(owner: User) {
        let newLeague = leagueService.createLeague(name: leagueName, owner: owner)
        leagues.append(newLeague)
        showCreateLeague = false
    }

    func inviteUserToLeague() {
        if let league = selectedLeague {
            leagueService.inviteUserToLeague(league: league, user: User(displayName: inviteEmail))
            showInviteUser = false
        }
    }
}

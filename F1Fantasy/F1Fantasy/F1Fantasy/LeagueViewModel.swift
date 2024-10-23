import Foundation
import Combine

class LeagueViewModel: ObservableObject {
    @Published var leagues: [League] = []
    @Published var errorMessage: String?
    @Published var isLoading = false

    private var cancellables = Set<AnyCancellable>()

    func createLeague(name: String) {
        isLoading = true
        LeagueService.shared.createLeague(name: name) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let league):
                    self?.leagues.append(league)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func joinLeague(leagueId: String, userId: String) {
        isLoading = true
        LeagueService.shared.joinLeague(leagueId: leagueId, userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let league):
                    if let index = self?.leagues.firstIndex(where: { $0.id == league.id }) {
                        self?.leagues[index] = league
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func fetchLeagues() {
        isLoading = true
        LeagueService.shared.fetchLeagues(userId: "currentUserId") // Replace with actual user ID
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] leagues in
                self?.leagues = leagues
            })
            .store(in: &cancellables)
    }
}

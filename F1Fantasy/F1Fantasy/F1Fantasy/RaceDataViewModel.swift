import Foundation
import Combine

class RaceDataViewModel: ObservableObject {
    @Published var raceData: RaceData?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchRaceData() {
        isLoading = true
        RaceDataService.shared.fetchRaceData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] raceData in
                self?.raceData = raceData
            })
            .store(in: &cancellables)
    }
}

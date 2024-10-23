import Foundation
import Combine

class RaceDataViewModel: ObservableObject {
    @Published var raceData: RaceData?

    private var cancellables = Set<AnyCancellable>()

    func fetchRaceData() {
        RaceDataService.shared.fetchRaceData { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.raceData = data
                }
            case .failure(let error):
                print("Error fetching race data: \(error)")
            }
        }
    }
}

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var errorMessage: String?
    @Published var isLoading = false

    private var cancellables = Set<AnyCancellable>()

    func fetchMessages(forLeague leagueId: String) {
        isLoading = true
        ChatService.shared.fetchMessages(forLeague: leagueId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] messages in
                self?.messages = messages
            })
            .store(in: &cancellables)
    }

    func sendMessage(_ message: String, fromUser userId: String, toLeague leagueId: String) {
        isLoading = true
        ChatService.shared.sendMessage(message, fromUser: userId, toLeague: leagueId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] newMessage in
                self?.messages.append(newMessage)
            })
            .store(in: &cancellables)
    }
}

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var newMessage: String = ""
    
    private var chatService = ChatService()
    private var cancellables = Set<AnyCancellable>()
    
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        
        // Assuming userId and leagueId are available
        let userId = "currentUserId"
        let leagueId = "currentLeagueId"
        
        chatService.sendMessage(to: leagueId, message: newMessage, from: userId) { [weak self] error in
            if let error = error {
                print("Error sending message: \(error.localizedDescription)")
            } else {
                self?.newMessage = ""
            }
        }
    }
    
    func fetchMessages() {
        // Assuming leagueId is available
        let leagueId = "currentLeagueId"
        
        chatService.fetchMessages(for: leagueId)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching messages: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] messages in
                self?.messages = messages
            })
            .store(in: &cancellables)
    }
}

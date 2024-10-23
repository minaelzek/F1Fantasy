import Foundation

class ChatService {
    static let shared = ChatService()
    
    private init() {}
    
    func fetchMessages(forLeague leagueId: String, completion: @escaping (Result<[ChatMessage], Error>) -> Void) {
        // Simulate a network request to fetch chat messages
        let messages = [
            ChatMessage(id: UUID().uuidString, username: "User1", message: "Good luck everyone!"),
            ChatMessage(id: UUID().uuidString, username: "User2", message: "May the best driver win!")
        ]
        completion(.success(messages))
    }
    
    func sendMessage(_ message: String, fromUser userId: String, toLeague leagueId: String, completion: @escaping (Result<ChatMessage, Error>) -> Void) {
        // Simulate sending a chat message
        let chatMessage = ChatMessage(id: UUID().uuidString, username: userId, message: message)
        completion(.success(chatMessage))
    }
}

struct ChatMessage: Identifiable {
    let id: String
    let username: String
    let message: String
}

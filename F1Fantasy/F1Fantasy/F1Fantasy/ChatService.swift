import Foundation
import Firebase

class ChatService {
    private let db = Firestore.firestore()
    private let chatCollection = "chats"

    func sendMessage(to leagueId: String, message: String, from userId: String, completion: @escaping (Error?) -> Void) {
        let data: [String: Any] = [
            "leagueId": leagueId,
            "message": message,
            "userId": userId,
            "timestamp": Timestamp()
        ]
        
        db.collection(chatCollection).addDocument(data: data) { error in
            completion(error)
        }
    }

    func fetchMessages(for leagueId: String, completion: @escaping ([ChatMessage]?, Error?) -> Void) {
        db.collection(chatCollection)
            .whereField("leagueId", isEqualTo: leagueId)
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    completion(nil, error)
                    return
                }
                
                let messages = documents.compactMap { doc -> ChatMessage? in
                    let data = doc.data()
                    guard let message = data["message"] as? String,
                          let userId = data["userId"] as? String,
                          let timestamp = data["timestamp"] as? Timestamp else {
                        return nil
                    }
                    return ChatMessage(id: doc.documentID, message: message, userId: userId, timestamp: timestamp.dateValue())
                }
                completion(messages, nil)
            }
    }
}

struct ChatMessage {
    let id: String
    let message: String
    let userId: String
    let timestamp: Date
}

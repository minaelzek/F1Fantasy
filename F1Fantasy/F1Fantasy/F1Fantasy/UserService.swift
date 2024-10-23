import Foundation
import Firebase

class UserService {
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    private let usersCollection = "users"

    func signUp(email: String, password: String, displayName: String, completion: @escaping (Error?) -> Void) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let user = authResult?.user else {
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User creation failed"]))
                return
            }
            
            let data: [String: Any] = [
                "uid": user.uid,
                "email": email,
                "displayName": displayName
            ]
            
            self.db.collection(self.usersCollection).document(user.uid).setData(data) { error in
                completion(error)
            }
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }

    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try auth.signOut()
            completion(nil)
        } catch let signOutError as NSError {
            completion(signOutError)
        }
    }

    func getCurrentUser() -> User? {
        return auth.currentUser
    }

    func updateDisplayName(displayName: String, completion: @escaping (Error?) -> Void) {
        guard let user = auth.currentUser else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is signed in"]))
            return
        }
        
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = displayName
        changeRequest.commitChanges { error in
            if let error = error {
                completion(error)
                return
            }
            
            self.db.collection(self.usersCollection).document(user.uid).updateData(["displayName": displayName]) { error in
                completion(error)
            }
        }
    }
}

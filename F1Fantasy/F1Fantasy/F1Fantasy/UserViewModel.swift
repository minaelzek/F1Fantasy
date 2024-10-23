import Foundation
import Combine
import FirebaseAuth

class UserViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var errorMessage: String?
    @Published var isLoading = false

    private var cancellables = Set<AnyCancellable>()

    func fetchUserProfile() {
        guard let user = Auth.auth().currentUser else {
            errorMessage = "No user is currently signed in."
            return
        }
        
        fullName = user.displayName ?? ""
        email = user.email ?? ""
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            // Handle successful sign out
        } catch let signOutError as NSError {
            errorMessage = signOutError.localizedDescription
        }
    }

    func resetPassword() {
        guard let email = Auth.auth().currentUser?.email else {
            errorMessage = "No user is currently signed in."
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                // Handle successful password reset
            }
        }
    }
}

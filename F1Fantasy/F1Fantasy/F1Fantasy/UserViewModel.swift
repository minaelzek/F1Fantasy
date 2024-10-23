import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var displayName: String = ""
    private var userService = UserService()
    private var cancellables = Set<AnyCancellable>()

    func loadCurrentUser() {
        if let currentUser = userService.getCurrentUser() {
            self.user = currentUser
            self.displayName = currentUser.displayName ?? ""
        }
    }

    func signOut() {
        userService.signOut { error in
            if let error = error {
                print("Error signing out: \(error.localizedDescription)")
            } else {
                self.user = nil
                self.displayName = ""
            }
        }
    }

    func updateDisplayName() {
        userService.updateDisplayName(displayName: displayName) { error in
            if let error = error {
                print("Error updating display name: \(error.localizedDescription)")
            } else {
                self.loadCurrentUser()
            }
        }
    }
}

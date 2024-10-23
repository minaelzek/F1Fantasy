import SwiftUI

struct UserView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        VStack {
            if let user = viewModel.user {
                Text("Welcome, \(user.displayName)")
                    .font(.largeTitle)
                    .padding()

                Button(action: {
                    viewModel.signOut()
                }) {
                    Text("Sign Out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                TextField("Display Name", text: $viewModel.displayName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    viewModel.updateDisplayName()
                }) {
                    Text("Update Display Name")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            } else {
                Text("Please sign in to view your profile.")
                    .font(.title)
                    .padding()
            }
        }
        .onAppear {
            viewModel.loadCurrentUser()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

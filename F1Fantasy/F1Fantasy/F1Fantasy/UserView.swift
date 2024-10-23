import SwiftUI

struct UserView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        VStack {
            Text("User Profile")
                .font(.largeTitle)
                .padding()

            Form {
                Section(header: Text("Profile Information")) {
                    TextField("Full Name", text: $viewModel.fullName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true) // Email should not be editable
                }

                Section(header: Text("Account Actions")) {
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

                    Button(action: {
                        viewModel.resetPassword()
                    }) {
                        Text("Reset Password")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchUserProfile()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

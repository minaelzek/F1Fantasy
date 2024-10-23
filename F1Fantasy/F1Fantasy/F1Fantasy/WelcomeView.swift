import SwiftUI

struct WelcomeView: View {
    @State private var user: User?
    @State private var comment: String = ""
    @State private var comments: [String] = []

    var body: some View {
        NavigationView {
            ZStack {
                Image("f1WelcomeBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("F1Fantasy")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 50)

                    Text("Your ultimate F1 fantasy experience")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.bottom, 50)

                    Spacer()
                }

                VStack {
                    Spacer()

                    if user == nil {
                        NavigationLink(destination: CreateAccountView()) {
                            Text("Create Account")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.bottom)

                        CustomButton(text: "Sign in with Google", backgroundColor: Color.blue, image: Image("google-logo"), action: {
                            handleGoogleSignIn() // Trigger the Google sign-in process
                        })
                    } else {
                        Text("Welcome, \(user?.displayName ?? "")")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }

                    CustomButton(text: "Sign in with Apple", backgroundColor: Color.blue, image: Image("apple-logo"), action: {
                        // Handle Apple sign-in
                    })

                    .padding(.bottom, 50)
                }

                VStack {
                    Text("Comments")
                        .font(.title)
                        .padding()

                    List(comments, id: \.self) { comment in
                        Text(comment)
                    }

                    HStack {
                        TextField("Add a comment", text: $comment)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        Button(action: {
                            if !comment.isEmpty {
                                comments.append(comment)
                                comment = ""
                            }
                        }) {
                            Text("Post")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Welcome")
    }

    private func handleGoogleSignIn() { // Implement Google Sign-in
        // Configure Firebase with Google Sign-in
        FirebaseApp.configure(name: "F1Fantasy", options: GoogleAppOptions.sharedInstance().options)

        let signInConfig = GIDConfiguration.init(clientID: YOUR_CLIENT_ID) // Replace YOUR_CLIENT_ID with your actual client ID
        GIDSignIn.sharedInstance().signIn(with: signInConfig, delegate: self as! GIDSignInDelegate)
    }
}

extension WelcomeView: GIDSignInDelegate { // Handle sign-in events
    func sign(_ signIn: GIDSignIn!, didSignInWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Error signing in with Google: \(error.localizedDescription)")
            return
        }

        // Get the Firebase credential from the Google sign-in user
        let credential = GIDGoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)

        // Sign in with Firebase using the credential
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                print("Error signing in with Firebase: \(error.localizedDescription)")
                return
            }

            // Update the user state with the Firebase user
            self.user = result?.user
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!) { // Handle sign-out
        // Sign out of Firebase
        Auth.auth().signOut()

        // Update the user state
        self.user = nil
    }
}

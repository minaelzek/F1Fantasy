//
//  SignInView.swift
//  F1Fantasy
//
//  Created by Mina Elzik on 2023-11-29.
//

import Foundation
import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Sign In")
                .font(.title)
                .fontWeight(.bold)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: signIn) {
                Text("Sign In")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(40)
            }
            .padding(.top, 20)

            // Navigation to Create Account View
            NavigationLink(destination: CreateAccountView()) {
                Text("Don't have an account? Create one")
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }

    private func signIn() {
        // Implement the sign-in logic here
        // For example, validate the credentials and navigate to the next view upon success
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

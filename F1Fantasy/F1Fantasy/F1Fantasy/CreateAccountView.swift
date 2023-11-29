//
//  CreateAccountView.swift
//  F1Fantasy
//
//  Created by Mina Elzik on 2023-11-23.
//

import Foundation
import SwiftUI

struct CreateAccountView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Create Account")
                .font(.title)
                .fontWeight(.bold)

            TextField("Full Name", text: $fullName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                // Handle sign up logic here
            }) {
                Text("SIGN UP")
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
            HStack {
                Text("Already have an account?")
                NavigationLink("Sign in", destination: SignInView())
            }
            .foregroundColor(.gray)
        }
        .padding()
    }
}

struct SignInView: View {
    var body: some View {
        // Implement the sign-in view
        Text("Sign In View")
    }
}



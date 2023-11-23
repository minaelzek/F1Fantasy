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
    @State private var phone: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        Form {
            Section(header: Text("Please fill in the information below").font(.headline)) {
                TextField("Full Name", text: $fullName)
                TextField("Phone", text: $phone)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                SecureField("Confirm Password", text: $confirmPassword)
            }
            Button("SIGN UP") {
                // Handle sign up logic
            }
            .buttonStyle(FilledButton())
        }
        .navigationBarTitle("Create Account", displayMode: .inline)
    }
}

// Example of a custom filled button style
struct FilledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.horizontal)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

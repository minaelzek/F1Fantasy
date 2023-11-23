//
//  WelcomeView.swift
//  F1Fantasy
//
//  Created by Mina Elzik on 2023-11-23.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Image("f1WelcomeBackground") // Use the image as the background
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all) // Ensure it covers the entire screen

            // The rest of your view content
            VStack(spacing: 20) {
                Text("Welcome to F1Fantasy")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                Spacer()
                CustomButton(text: "Create Account", backgroundColor: Color.blue)
                CustomButton(text: "Sign in with Google", image: Image("google-logo"), backgroundColor: .blue)
                CustomButton(text: "Sign in with Apple", image: Image("apple-logo"), backgroundColor: .blue)
                Spacer()
            }
            .padding()
        }
    }
}



struct CustomButton: View {
    var text: String
    var image: Image? = nil
    var backgroundColor: Color
    @State private var isPressed = false

    var body: some View {
        Button(action: {
            // Handle button action
        }) {
            HStack {
                if let image = image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                Text(text)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .brightness(isPressed ? 0.05 : 0)
        }
        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.2)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}

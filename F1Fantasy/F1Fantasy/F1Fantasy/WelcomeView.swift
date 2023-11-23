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

            VStack {
                Text("Welcome to F1Fantasy")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 10, x: 0, y: 0)
                    .opacity(0.8)
                    .padding(.top, 50) // Adds padding at the top
                Spacer() // Pushes everything below it down
            }

            VStack {
                Spacer() // Pushes everything below it to the bottom
                CustomButton(text: "Create Account", backgroundColor: Color.blue)
                CustomButton(text: "Sign in with Google", image: Image("google-logo"), backgroundColor: .blue)
                CustomButton(text: "Sign in with Apple", image: Image("apple-logo"), backgroundColor: .blue)
                Spacer(minLength: 30) // Adjusts the space at the bottom
            }
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

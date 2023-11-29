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
                        // Handle Google sign-in
                    })

                    CustomButton(text: "Sign in with Apple", backgroundColor: Color.blue, image: Image("apple-logo"), action: {
                        // Handle Apple sign-in
                    })

                    .padding(.bottom, 50)
                }
            }
        }
        .navigationBarTitle("Welcome")
    }
}






struct CustomButton: View {
    var text: String
    var backgroundColor: Color
    var image: Image? = nil
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
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
        }
    }
}

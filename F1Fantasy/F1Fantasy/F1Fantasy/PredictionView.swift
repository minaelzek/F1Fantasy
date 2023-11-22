//
//  PredictionView.swift
//  F1Fantasy
//
//  Created by Mina Elzik on 2023-11-22.
//

import Foundation
import SwiftUI

struct PredictionView: View {
    let drivers = ["Max Verstappen", "Sergio Perez", "Charles Leclerc", "Carlos Sainz",
                   "Lewis Hamilton", "George Russell", "Pierre Gasly", "Esteban Ocon",
                   "Lando Norris", "Oscar Piastri", "Zhou Guanyu", "Valtteri Bottas",
                   "Fernando Alonso", "Lance Stroll", "Kevin Magnussen", "Nico Hulkenberg",
                   "Yuki Tsunoda", "Nyck de Vries", "Logan Sargeant", "Alex Albon"]

    @State private var selectedP1: String = ""
    @State private var selectedP2: String = ""
    @State private var selectedP3: String = ""
    @State private var selectedFastestLap: String = ""

    var body: some View {
        Form {
            Section(header: Text("Predictions")) {
                Picker("P1", selection: $selectedP1) {
                    ForEach(drivers, id: \.self) {
                        Text($0)
                    }
                }
                Picker("P2", selection: $selectedP2) {
                    ForEach(drivers, id: \.self) {
                        Text($0)
                    }
                }
                Picker("P3", selection: $selectedP3) {
                    ForEach(drivers, id: \.self) {
                        Text($0)
                    }
                }
                Picker("Fastest Lap", selection: $selectedFastestLap) {
                    ForEach(drivers, id: \.self) {
                        Text($0)
                    }
                }

                Button("Submit Prediction") {
                    if validatePredictions() {
                        // Code to handle the successful submission
                    } else {
                        // Show an error message or prompt the user to correct their selections
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .navigationBarTitle("Make a Prediction", displayMode: .inline)
    }

    func validatePredictions() -> Bool {
        let allPicks = [selectedP1, selectedP2, selectedP3, selectedFastestLap]
        return Set(allPicks).count == allPicks.count // Returns true if all picks are unique
    }
}

struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
    }
}

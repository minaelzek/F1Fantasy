import Foundation
import SwiftUI

struct PredictionView: View {
    let drivers = ["Max Verstappen", "Sergio Perez", "Charles Leclerc", "Carlos Sainz",
                   "Lewis Hamilton", "George Russell", "Pierre Gasly", "Esteban Ocon",
                   "Lando Norris", "Oscar Piastri", "Zhou Guanyu", "Valtteri Bottas",
                   "Fernando Alonso", "Lance Stroll", "Kevin Magnussen", "Nico Hulkenberg",
                   "Yuki Tsunoda", "Nyck de Vries", "Logan Sargeant", "Alex Albon"]

    @State private var selectedP1: String = "Pick a driver"
    @State private var selectedP2: String = "Pick a driver"
    @State private var selectedP3: String = "Pick a driver"
    @State private var selectedFastestLap: String = "Pick a driver"
    @State private var selectedSideBet1: String = "Pick a side bet"
    @State private var selectedSideBet2: String = "Pick a side bet"
    @State private var selectedSideBet3: String = "Pick a side bet"
    
    @State private var countdown: String = ""

    var body: some View {
        VStack {
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
                }
                
                Section(header: Text("Side Bets")) {
                    Picker("Side Bet 1", selection: $selectedSideBet1) {
                        Text("Podium Prediction").tag("Podium Prediction")
                        Text("Top Rookie").tag("Top Rookie")
                        Text("Over/Under Race Incidents").tag("Over/Under Race Incidents")
                    }
                    Picker("Side Bet 2", selection: $selectedSideBet2) {
                        Text("Podium Prediction").tag("Podium Prediction")
                        Text("Top Rookie").tag("Top Rookie")
                        Text("Over/Under Race Incidents").tag("Over/Under Race Incidents")
                    }
                    Picker("Side Bet 3", selection: $selectedSideBet3) {
                        Text("Podium Prediction").tag("Podium Prediction")
                        Text("Top Rookie").tag("Top Rookie")
                        Text("Over/Under Race Incidents").tag("Over/Under Race Incidents")
                    }
                }
            }

            Spacer()
            
            Text("Submission Deadline: \(countdown)")
                .font(.headline)
                .padding()

            Button("Submit Prediction") {
                if validatePredictions() {
                    // Code to handle the successful submission
                } else {
                    // Show an error message or prompt the user to correct their selections
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(0)
        }
        .navigationBarTitle("Make a Prediction", displayMode: .inline)
        .onAppear {
            startCountdown()
        }
    }

    func validatePredictions() -> Bool {
        let allPicks = [selectedP1, selectedP2, selectedP3, selectedFastestLap]
        return Set(allPicks).count == allPicks.count // Returns true if all picks are unique
    }
    
    func startCountdown() {
        let deadline = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let now = Date()
            let remaining = deadline.timeIntervalSince(now)
            if remaining > 0 {
                let hours = Int(remaining) / 3600
                let minutes = Int(remaining) % 3600 / 60
                let seconds = Int(remaining) % 60
                countdown = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            } else {
                countdown = "00:00:00"
            }
        }
        timer.fire()
    }
}

struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
    }
}

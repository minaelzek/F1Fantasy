import SwiftUI

struct RaceDataView: View {
    @StateObject private var viewModel = RaceDataViewModel()

    var body: some View {
        VStack {
            Text("Race Data")
                .font(.largeTitle)
                .padding()

            if let raceData = viewModel.raceData {
                Text("Race: \(raceData.raceName)")
                Text("Circuit: \(raceData.circuit)")
                Text("Date: \(raceData.date)")

                List(raceData.results) { result in
                    HStack {
                        Text("\(result.position)")
                        Text(result.driver)
                        Spacer()
                        Text(result.team)
                        Text(result.time)
                    }
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            viewModel.fetchRaceData()
        }
    }
}

struct RaceDataView_Previews: PreviewProvider {
    static var previews: some View {
        RaceDataView()
    }
}

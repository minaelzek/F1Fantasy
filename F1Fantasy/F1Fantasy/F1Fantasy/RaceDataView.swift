import SwiftUI

struct RaceDataView: View {
    @ObservedObject var viewModel = RaceDataViewModel()

    var body: some View {
        VStack {
            Text("Race Data")
                .font(.largeTitle)
                .padding()

            if let raceData = viewModel.raceData {
                Text("Race: \(raceData.raceName)")
                Text("Date: \(raceData.date, formatter: dateFormatter)")

                List(raceData.results) { result in
                    HStack {
                        Text("\(result.position)")
                        Text(result.driverName)
                        Spacer()
                        Text(result.teamName)
                        Spacer()
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

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct RaceDataView_Previews: PreviewProvider {
    static var previews: some View {
        RaceDataView()
    }
}

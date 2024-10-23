import Foundation
import SwiftUI

struct LeaderboardView: View {
    @State private var leaderboardData: [LeaderboardEntry] = []

    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .padding()

            List(leaderboardData) { entry in
                HStack {
                    Text(entry.username)
                    Spacer()
                    Text("\(entry.points) pts")
                }
            }
        }
        .onAppear(perform: loadLeaderboardData)
    }

    private func loadLeaderboardData() {
        // Placeholder for backend integration to fetch leaderboard data
        // This function should update the leaderboardData state variable with the fetched data
    }
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let username: String
    let points: Int
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}

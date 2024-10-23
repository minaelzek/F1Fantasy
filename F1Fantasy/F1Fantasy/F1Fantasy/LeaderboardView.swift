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
                    Text("\(entry.points) points")
                }
            }
            .padding()
        }
        .onAppear {
            fetchLeaderboardData()
        }
    }

    private func fetchLeaderboardData() {
        // Simulate fetching data from backend
        // Replace this with actual network call to your backend
        leaderboardData = [
            LeaderboardEntry(id: 1, username: "User1", points: 100),
            LeaderboardEntry(id: 2, username: "User2", points: 90),
            LeaderboardEntry(id: 3, username: "User3", points: 80)
        ]
    }
}

struct LeaderboardEntry: Identifiable {
    let id: Int
    let username: String
    let points: Int
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}

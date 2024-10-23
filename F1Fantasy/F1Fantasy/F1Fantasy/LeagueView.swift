import SwiftUI

struct LeagueView: View {
    @StateObject private var viewModel = LeagueViewModel()
    @State private var newLeagueName: String = ""
    @State private var selectedLeague: League?

    var body: some View {
        VStack {
            Text("Leagues")
                .font(.largeTitle)
                .padding()

            Form {
                Section(header: Text("Create a New League")) {
                    TextField("League Name", text: $newLeagueName)
                    Button(action: {
                        viewModel.createLeague(name: newLeagueName)
                    }) {
                        Text("Create League")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }

                Section(header: Text("Your Leagues")) {
                    List(viewModel.leagues) { league in
                        Button(action: {
                            selectedLeague = league
                        }) {
                            Text(league.name)
                        }
                    }
                }
            }

            Spacer()

            if let selectedLeague = selectedLeague {
                VStack {
                    Text("Selected League: \(selectedLeague.name)")
                        .font(.headline)
                    List(selectedLeague.members, id: \.self) { member in
                        Text(member)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchLeagues()
        }
    }
}

struct LeagueView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueView()
    }
}

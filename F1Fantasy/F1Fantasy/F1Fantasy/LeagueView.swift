import SwiftUI

struct LeagueView: View {
    @State private var leagues: [League] = []
    @State private var leagueName: String = ""
    @State private var selectedLeague: League?
    @State private var showCreateLeague: Bool = false
    @State private var showInviteUser: Bool = false
    @State private var inviteEmail: String = ""

    var body: some View {
        VStack {
            Text("Leagues")
                .font(.largeTitle)
                .padding()

            List(leagues) { league in
                HStack {
                    Text(league.name)
                    Spacer()
                    Button(action: {
                        selectedLeague = league
                        showInviteUser = true
                    }) {
                        Text("Invite")
                            .foregroundColor(.blue)
                    }
                }
            }

            Button(action: {
                showCreateLeague = true
            }) {
                Text("Create League")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            Spacer()
        }
        .sheet(isPresented: $showCreateLeague) {
            VStack {
                Text("Create League")
                    .font(.title)
                    .padding()

                TextField("League Name", text: $leagueName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    let newLeague = LeagueService().createLeague(name: leagueName, owner: User(displayName: "Current User"))
                    leagues.append(newLeague)
                    showCreateLeague = false
                }) {
                    Text("Create")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .padding()
        }
        .sheet(isPresented: $showInviteUser) {
            VStack {
                Text("Invite User")
                    .font(.title)
                    .padding()

                TextField("User Email", text: $inviteEmail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    if let league = selectedLeague {
                        LeagueService().inviteUserToLeague(league: league, user: User(displayName: inviteEmail))
                        showInviteUser = false
                    }
                }) {
                    Text("Invite")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .padding()
        }
        .onAppear {
            // Load leagues for the current user
            leagues = LeagueService().getLeaguesForUser(user: User(displayName: "Current User"))
        }
    }
}

struct LeagueView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueView()
    }
}

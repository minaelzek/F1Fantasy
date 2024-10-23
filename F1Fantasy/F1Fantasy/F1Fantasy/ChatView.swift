import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var newMessage: String = ""

    var body: some View {
        VStack {
            Text("Chat")
                .font(.largeTitle)
                .padding()

            List(viewModel.messages) { message in
                VStack(alignment: .leading) {
                    Text(message.username)
                        .font(.headline)
                    Text(message.message)
                        .font(.body)
                }
            }

            HStack {
                TextField("Enter your message", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    viewModel.sendMessage(newMessage)
                    newMessage = ""
                }) {
                    Text("Send")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchMessages()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

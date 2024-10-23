import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel = ChatViewModel()

    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                HStack {
                    Text(message.userId)
                        .font(.headline)
                    Text(message.message)
                        .font(.body)
                }
            }

            HStack {
                TextField("Enter message", text: $viewModel.newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    viewModel.sendMessage()
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
        .navigationBarTitle("Chat", displayMode: .inline)
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

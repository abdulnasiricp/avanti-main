import 'package:flutter/material.dart';

void main() {
  runApp(const ChatbotApp());
}

class ChatbotApp extends StatelessWidget {
  const ChatbotApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatbotPage(),
    );
  }
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _chatMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Us'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];
                return ListTile(
                  title: Align(
                    alignment: message['sender'] == 'User'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: message['sender'] == 'User'
                          ? Colors.blue
                          : Colors.green,
                      child: Text(
                        message['text']!,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String message) {
    // Add the user's message to the chat
    setState(() {
      _chatMessages.add({'sender': 'User', 'text': message});
      _messageController.clear();
    });

    // Call the chatbot service to get a response
    _getBotResponse(message);
  }

  void _getBotResponse(String userMessage) {
    // Replace this with your actual API call to the chatbot service
    // For simplicity, we'll echo the user's message as the bot's response.
    String botResponse = userMessage;

    // Simulate a delayed response
    Future.delayed(const Duration(seconds: 1), () {
      // Add the bot's response to the chat
      setState(() {
        _chatMessages.add({'sender': 'Support Team', 'text': botResponse});
      });
    });
  }
}

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _message = TextEditingController();
  String currentUserName = "You";
  List<Map<String, dynamic>> chatList = [
    {
      "userId": 1,
      "message": "Hello, everyone!",
      "sendBy": "John Doe",
      "time": "12:30 PM",
      "date": "2024-11-17",
    },
    {
      "userId": 2,
      "message": "Hi, John! How are you?",
      "sendBy": "Jane Smith",
      "time": "12:31 PM",
      "date": "2024-11-17",
    },
  ]; // Sample hardcoded data
  ScrollController _scrollController = ScrollController();
  int? currentUserId = 1; // Set to a default user ID for testing
  bool isUserScrollingUp = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void sendMessage() {
    final message = _message.text.trim();
    if (message.isEmpty) return;

    setState(() {
      // Add the new message to the chat list
      chatList.add({
        "userId": currentUserId,
        "message": message,
        "sendBy": currentUserName,
        "time": "Now", // Simulating current time
        "date": "2024-11-17", // Hardcoded date
      });
    });

    _message.clear(); // Clear the message input field after sending
    scrollToBottom(); // Scroll to bottom after sending
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ARU Students"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              // Dummy functionality for more options
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Assign the ScrollController
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                bool isCurrentUser = chatList[index]['userId'] == currentUserId;
                bool showDate = true;

                if (index > 0) {
                  showDate =
                      chatList[index]['date'] != chatList[index - 1]['date'];
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showDate)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: Text(
                            chatList[index]['date'] ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: isCurrentUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            constraints:
                                BoxConstraints(maxWidth: 0.7 * size.width),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 14),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: isCurrentUser
                                  ? Colors.blue
                                  : Colors.grey[300],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isCurrentUser
                                    ? const Text('You')
                                    : Text(
                                        '${chatList[index]['sendBy']}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                SizedBox(
                                  height: size.height / 200,
                                ),
                                Text(
                                  '${chatList[index]['message']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: isCurrentUser
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height / 200,
                                ),
                                Text(
                                  '${chatList[index]['time']}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _message,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      sendMessage();
                    },
                  ),
                ),
                IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

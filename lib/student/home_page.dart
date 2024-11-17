import 'package:flutter/material.dart';
import 'package:rides_sharing_app/student/members_page.dart';
import 'package:rides_sharing_app/student/request_ride_page.dart';

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
  int? currentUserId = 1; // Default user ID for testing
  bool isUserScrollingUp = false;

  var currentPage = DrawerSections.home;

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
      chatList.add({
        "userId": currentUserId,
        "message": message,
        "sendBy": currentUserName,
        "time": "Now",
        "date": "2024-11-17",
      });
    });

    _message.clear();
    scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ARU Students"),
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'Join Group') {
                // Logic for joining the group
              } else if (value == 'Members') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MembersPage()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'Join Group',
                  child: Row(
                    children: [
                      Icon(Icons.group_add, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Join Group'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'Members',
                  child: Row(
                    children: [
                      Icon(Icons.people, color: Colors.green),
                      SizedBox(width: 8),
                      Text('Members'),
                    ],
                  ),
                ),
              ];
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
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
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyHeaderDrawer(
                  token: null,
                  userId: currentUserId ?? 0,
                  role: "Chat User",
                  showRole: false,
                ),
                Container(
                  height: 3,
                  color: Colors.grey[300],
                ),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Home", Icons.home, currentPage == DrawerSections.home),
          menuItem(2, "Request Ride", Icons.directions_car,
              currentPage == DrawerSections.request),
          menuItem(3, "Driver Response", Icons.feedback,
              currentPage == DrawerSections.response),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          if (id == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RequestPage(
                  userId: currentUserId ?? 0,
                  role: "Student",
                ),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHeaderDrawer extends StatelessWidget {
  final String? token;
  final int userId;
  final String role;
  final bool showRole;

  const MyHeaderDrawer({
    super.key,
    required this.token,
    required this.userId,
    required this.role,
    required this.showRole,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 220,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('lib/images/user.png'),
          ),
          const SizedBox(height: 10),
          MouseRegion(
            cursor: SystemMouseCursors.click, // Pointer to a hand
            child: GestureDetector(
              onTap: () {
                // Handle click on "My Account"
              },
              child: const Text(
                "My Account",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (showRole)
            Text(
              role,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }
}

enum DrawerSections {
  home,
  request,
  response,
}

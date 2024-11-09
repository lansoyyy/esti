import 'package:esti/utils/data.dart';
import 'package:esti/widgets/drawer_widget.dart';
import 'package:esti/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  final msg = TextEditingController();

  List<Map<String, String>> chatMessages = [];

  void _sendMessage() {
    final message = msg.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        chatMessages.add({'sender': 'user', 'message': message});
      });

      _getResponse(message);

      msg.clear();
    }
  }

  void _getResponse(String question) {
    String response =
        'Sorry, I didn\'t understand the question. Please ask something else.';

    for (var faq in faqData) {
      if (faq['question']!.toLowerCase() == question.toLowerCase()) {
        response = faq['answer']!;
        break;
      }
    }

    setState(() {
      chatMessages.add({'sender': 'bot', 'message': response});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerWidget(),
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'ESTI',
              fontSize: 32,
              fontFamily: 'Bold',
              color: Colors.amber[800],
            ),
            TextWidget(
              text: 'School Guide & Info',
              fontSize: 18,
              fontFamily: 'Medium',
              color: Colors.amber[800],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.volume_up_outlined,
              color: Colors.black,
            ),
          ),
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                final isUserMessage = message['sender'] == 'user';

                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color:
                          isUserMessage ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      message['message']!,
                      style: TextStyle(
                        color: isUserMessage ? Colors.black : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: msg,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Type your question...',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

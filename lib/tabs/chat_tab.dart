import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esti/screens/home_screen.dart';
import 'package:esti/services/add_chat.dart';
import 'package:esti/utils/const.dart';
import 'package:esti/utils/data.dart';
import 'package:esti/widgets/drawer_widget.dart';
import 'package:esti/widgets/text_widget.dart';
import 'package:esti/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';

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
        addChat(message, 'user');
        _controller.play();
      });

      _getResponse(message);

      msg.clear();
    }
  }

  void _getResponse(String question) async {
    String response =
        'Sorry, I didn\'t understand the question. Please ask something else.';

    // Convert question to lowercase for case-insensitive matching
    final questionLower = question.toLowerCase();

    // Use a Map to store matching scores
    Map<String, int> matches = {};

    for (var faq in faqData) {
      // Split the question and FAQ question into words for partial matching
      final questionWords =
          faq['question']!.toLowerCase().split(RegExp(r'\W+'));
      int score = 0;

      for (var word in questionLower.split(RegExp(r'\W+'))) {
        if (questionWords.contains(word)) {
          score++;
        }
      }
      matches[faq['question']!] = score;
    }

    final bestMatch =
        matches.entries.reduce((a, b) => a.value > b.value ? a : b);

    if (bestMatch.value > 0) {
      // If a match is found, get the corresponding answer
      response = faqData
          .firstWhere((faq) => faq['question'] == bestMatch.key)['answer']!;
    }
    setState(() {
      addChat(response, 'bot');
    });
    await flutterTts.setLanguage("en-US");

    await flutterTts.setVolume(1.0);

    await flutterTts.setPitch(1.0);
    await flutterTts.speak(response);
  }

  late VideoPlayerController _controller;

  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/images/esti.mp4')
      ..initialize().then((_) {
        // _controller.setVolume(1);

        // _controller.pause();
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text(
                          'Delete All Confirmation',
                          style: TextStyle(
                              fontFamily: 'QBold', fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          'Are you sure you want to delete all chat history with Esti?',
                          style: TextStyle(fontFamily: 'QRegular'),
                        ),
                        actions: <Widget>[
                          MaterialButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text(
                              'Close',
                              style: TextStyle(
                                  fontFamily: 'QRegular',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              try {
                                final collectionRef = FirebaseFirestore.instance
                                    .collection(userId);

                                // Retrieve all documents in the collection
                                final querySnapshot = await collectionRef.get();

                                // Delete each document
                                for (var doc in querySnapshot.docs) {
                                  await doc.reference.delete();
                                }

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()),
                                );
                              } catch (e) {
                                Navigator.pop(context);
                                showToast('Error deleting history!');
                              }
                            },
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                  fontFamily: 'QRegular',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ));
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
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
          _controller.value.isInitialized
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              : const CircularProgressIndicator(),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection(userId).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      final message = data.docs[index];
                      final isUserMessage = message['sender'] == 'user';

                      return message['msg'] == enroll
                          ? GestureDetector(
                              onTap: () async {
                                await launchUrlString(
                                    'https://www.sti.edu/admissions_registration.asp');
                              },
                              child: Align(
                                alignment: isUserMessage
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.green[300],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    message['msg'] ?? '',
                                    style: TextStyle(
                                      color: isUserMessage
                                          ? Colors.black
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Align(
                              alignment: isUserMessage
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: isUserMessage
                                      ? Colors.blue[100]
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  message['msg'] ?? '',
                                  style: TextStyle(
                                    color: isUserMessage
                                        ? Colors.black
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                );
              }),
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

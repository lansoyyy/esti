import 'package:esti/screens/notif_screen.dart';
import 'package:esti/tabs/chat_tab.dart';
import 'package:esti/tabs/settings_tab.dart';
import 'package:esti/utils/colors.dart';
import 'package:esti/widgets/drawer_widget.dart';
import 'package:esti/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const ChatTab(),
    const SettingsTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List labels = ['Chat', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerWidget(),
      appBar: AppBar(
        title: const CircleAvatar(
          minRadius: 15,
          maxRadius: 15,
          backgroundImage: AssetImage(
            'assets/images/ESTI Avatar.png',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NotifScreen()),
              );
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextWidget(
              text: 'ESTI',
              fontSize: 75,
              fontFamily: 'Bold',
              color: Colors.yellow[700],
            ),
            const CircleAvatar(
              minRadius: 125,
              maxRadius: 125,
              backgroundImage: AssetImage(
                'assets/images/ESTI Avatar.png',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              maxLines: 5,
              text:
                  'Hello, Good Day!\nIm ESTI, your School\nInformation & Guide A.I',
              fontSize: 24,
              fontFamily: 'Bold',
              color: Colors.black,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Builder(builder: (context) {
        return BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.yellow[900],
          onTap: (value) {
            if (value == 0) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ChatTab()),
              );
            } else {
              Scaffold.of(context).openEndDrawer();
            }
          },
        );
      }),
    );
  }
}
